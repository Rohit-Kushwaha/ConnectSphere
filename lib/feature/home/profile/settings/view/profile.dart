import 'package:career_sphere/data/local/shared/shared_prefs.dart';
import 'package:career_sphere/feature/home/profile/logout/bloc/logout_bloc.dart';
import 'package:career_sphere/feature/home/profile/logout/repo/logout_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? name = SharedPrefHelper.instance.getString('name');
    String? email = SharedPrefHelper.instance.getString('email');
    debugPrint("$name+ $email");

    return BlocProvider(
      create: (context) => LogoutBloc(LogOutRepoImpl()),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: const NetworkImage(
                            "https://cdn.pixabay.com/photo/2023/01/23/00/45/cat-7737618_1280.jpg"),
                        onBackgroundImageError: (exception, stackTrace) {
                          debugPrint("Error loading image: $exception");
                        },
                      ),
                      const SizedBox(
                        width: 120,
                      ),
                      BlocConsumer<LogoutBloc, LogoutState>(
                        listener: (ctx, state) {
                          if (state is LogoutFailedState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Log out failed")),
                            );
                          }
                          if (state is LogoutSucess) {
                            SharedPrefHelper.instance.clearAllData();
                            context.go('/login');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Log out success")),
                            );
                          }
                        },
                        builder: (ctx, state) {
                          return IconButton(
                            onPressed: () {
                              showMenu(
                                context: context,
                                position:
                                    const RelativeRect.fromLTRB(100, 100, 0, 0),
                                items: [
                                   PopupMenuItem(
                                    value: 'profile',
                                    onTap: (){
                                       context.push('/post');
                                    },
                                    child: ListTile(
                                      leading: Icon(Icons.person),
                                      title: Text('Profile'),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'settings',
                                    onTap: () {
                                      context.push('/settings');
                                    },
                                    child: const ListTile(
                                      leading: Icon(Icons.settings),
                                      title: Text('Settings'),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'logout',
                                    child: InkWell(
                                      onTap: () async {
                                        ctx
                                            .read<LogoutBloc>()
                                            .add(LogOutEvent());
                                      },
                                      child: const ListTile(
                                        leading: Icon(Icons.logout),
                                        title: Text('Logout'),
                                      ),
                                    ),
                                  )
                                ],
                              ).then((value) {
                                // Handle the selected value
                                if (value != null) {
                                  debugPrint('Selected: $value');
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.settings,
                              size: 30,
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                name.toString(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                email.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
