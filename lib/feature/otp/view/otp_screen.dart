import 'dart:async';

import 'package:career_sphere/feature/otp/bloc/bloc/otp_bloc.dart';
import 'package:career_sphere/utils/colors.dart';
import 'package:career_sphere/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.email});

  final String email;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());

  // Use ValueNotifier to manage the countdown timer without setState
  final ValueNotifier<int> _remainingTime = ValueNotifier<int>(120);
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // context.read<OtpBloc>().add(AutomaticOtpSentEvent(email: widget.email));
    // });
    _startCountdown();
  }

  @override
  void dispose() {
    // Dispose of all focus nodes and the controller when the widget is destroyed
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    _timer.cancel();
    super.dispose();
  }

  void _onChanged(String value, int index) {
    // Move to the next field if the user enters a digit
    if (value.isNotEmpty && index < 3) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }
    // Move to the previous field if the user deletes a digit
    if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime.value > 0) {
        _remainingTime.value--;
      } else {
        _timer.cancel();
      }
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "$minutes:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  String getOtp() {
    // Combine all OTP values into a single string
    return _controllers.map((controller) => controller.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Verify OTP',
            style: GoogleFonts.merienda(
              textStyle: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(letterSpacing: 1),
            ),
          ),
        ),
        body: Builder(builder: (context) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'OTP',
                  style: GoogleFonts.merienda(
                    textStyle: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Enter the 6-digit OTP we sent to your email rohitkushwaha@gmail.com",
                  style: GoogleFonts.merienda(
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(letterSpacing: 1),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  spacing: 25.w,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) => SizedBox(
                      height: 50.h,
                      width: 50.w,
                      child: TextField(
                        focusNode: _focusNodes[index],
                        controller: _controllers[index],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.merienda(
                          textStyle: Theme.of(context).textTheme.headlineMedium,
                        ),
                        onChanged: (value) => _onChanged(value, index),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                        ],
                        maxLength: 1,
                        decoration:
                            InputDecoration(hintText: '-', counterText: ''),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  child: ValueListenableBuilder<int>(
                    valueListenable: _remainingTime,
                    builder: (context, remainingTime, child) {
                      return Text(
                        textAlign: TextAlign.end,
                        'Otp expire in ${formatTime(remainingTime)} min',
                        style: GoogleFonts.merienda(
                          textStyle:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(),
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Resend OTP logic
                      if (_remainingTime.value != 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please wait till time")));
                      } else {
                        context
                            .read<OtpBloc>()
                            .add(ResendOtpSentEvent(email: widget.email));
                      }
                    },
                    // },
                    child: Text(
                      'Resend OTP',
                      style: GoogleFonts.merienda(
                        textStyle:
                            Theme.of(context).textTheme.bodyLarge?.copyWith(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: BlocConsumer<OtpBloc, OtpState>(
                          listener: (context, state) {
                        if (state is OtpErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                state.error,
                                style: merienda16(context)
                                    .copyWith(color: AppColors.whiteColor),
                              ),
                            ),
                          );
                        }

                        if (state is OtpSendState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                state.message,
                                style: merienda16(context)
                                    .copyWith(color: AppColors.whiteColor),
                              ),
                            ),
                          );
                        }

                        if (state is OtpVerifiedState) {
                          context.go('/home');
                        }
                      }, builder: (contex, state) {
                        return ElevatedButton(
                          onPressed: () {
                            // Verify OTP logic
                            if (getOtp().length != 4) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Otp is not valid",
                                    style: merienda16(context)
                                        .copyWith(color: AppColors.whiteColor),
                                  ),
                                ),
                              );
                            } else {
                              // hit api
                              context.read<OtpBloc>().add(VerifyOtpEvent(
                                  email: widget.email, otp: getOtp()));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: state is OtpCheckingState
                              ? CircularProgressIndicator()
                              : Text("Verify",
                                  style: merienda24(context).copyWith(
                                    color: AppColors.whiteColor,
                                  )),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
