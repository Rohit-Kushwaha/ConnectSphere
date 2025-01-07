import 'package:career_sphere/data/local/shared/shared_prefs.dart';
import 'package:career_sphere/feature/home/message/msg/bloc/message_bloc.dart';
import 'package:career_sphere/feature/home/message/chat/view/chat_screen.dart';
import 'package:career_sphere/feature/home/message/msg/model/res/chatted_response.dart';
import 'package:career_sphere/feature/home/message/msg/repo/message_repo.dart';
import 'package:career_sphere/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({
    super.key,
  });

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _allUsers = [
    'Alice',
    'Bob',
    'Charlie',
    'David'
  ]; // Dummy data
  List<Username>? _chatUsers = []; // List of users in the chat
  List<String> _filteredUsers = [];
  late String? senderID;

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredUsers.clear();
      });
    } else {
      setState(() {
        _filteredUsers = _allUsers
            .where((user) => user.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  void initState() {
    senderID = SharedPrefHelper.instance.getString("senderID");
    super.initState();

    _searchController.addListener(() {
      _onSearchChanged(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageBloc(MessageRepoImpl())
        ..add(GetChattedListEvent(senderId: senderID.toString())),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chat"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocConsumer<MessageBloc, MessageState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      context
                          .read<MessageBloc>()
                          .add(SearchUserEvent(name: _searchController.text));
                    },
                    decoration: InputDecoration(
                      labelText: 'Search User',
                      contentPadding: EdgeInsets.only(left: 10.w),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.search),
                    ),
                  );
                },
              ),
            ),
            BlocConsumer<MessageBloc, MessageState>(
              listener: (context, state) {
                debugPrint(state.toString());
              },
              builder: (context, state) {
                return state is SearchSuccessState
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: state.searchResponseModel.users.length,
                            itemBuilder: (context, index) {
                              var searchedUser =
                                  state.searchResponseModel.users[index];
                              return ListTile(
                                  title: Text(
                                    searchedUser.name,
                                    style: merienda14(context),
                                  ),
                                  onTap: () {
                                    //!!
                                    context
                                        .read<MessageBloc>()
                                        .add(SaveUserChattingEvent(
                                          senderID: senderID.toString(),
                                          receiverID:
                                              searchedUser.id.toString(),
                                        ));
                                    debugPrint(
                                        "${searchedUser.id}Searched User id");
                                    // _addUserToChat(searchedUser.name),
                                    if (!_chatUsers!.contains(Username(
                                        name: searchedUser.toString()))) {
                                      setState(() {
                                        _chatUsers!.add(Username(
                                          id: searchedUser.id,
                                          name: searchedUser.name.toString(),
                                        ));
                                      });
                                    }
                                    _searchController.clear();
                                    _filteredUsers.clear();

                                    //!!!
                                  });
                            }),
                      )
                    : state is SearchErrorState
                        ? Text(state.msg, style: merienda16(context))
                        : SizedBox.shrink();
              },
            ),
            Expanded(
              child: Builder(builder: (context) {
                return Column(
                  children: [
                    Expanded(
                      child: BlocConsumer<MessageBloc, MessageState>(
                        listener: (context, state) {
                          if (state is GetChattedListSuccessState) {
                            setState(() {
                              _chatUsers = state.chatteUserResponse.username;
                            });
                          }
                        },
                        builder: (context, state) {
                          return ListView.builder(
                            itemCount: _chatUsers!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(_chatUsers![index].name.toString()),
                                trailing: Icon(Icons.chat),
                                onTap: () {
                                  // Navigate to chat with this user
                                  debugPrint(index.toString());
                                  debugPrint("${_chatUsers![index].id} ID");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                        senderID: senderID.toString(),
                                        receiverID:
                                            _chatUsers![index].id.toString(),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}



















































// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:local_auth/local_auth.dart';

// class MessageScreen extends StatefulWidget {
//   const MessageScreen({super.key});

//   @override
//   State<MessageScreen> createState() => _MessageScreenState();
// }

// class _MessageScreenState extends State<MessageScreen> {
//    final LocalAuthentication auth = LocalAuthentication();
//   _SupportState _supportState = _SupportState.unknown;
//   bool? _canCheckBiometrics;
//   List<BiometricType>? _availableBiometrics;
//   String _authorized = 'Not Authorized';
//   bool _isAuthenticating = false;

//   @override
//   void initState() {
//     super.initState();
//     auth.isDeviceSupported().then(
//           (bool isSupported) => setState(() => _supportState = isSupported
//               ? _SupportState.supported
//               : _SupportState.unsupported),
//         );
//   }

//   Future<void> _checkBiometrics() async {
//     late bool canCheckBiometrics;
//     try {
//       canCheckBiometrics = await auth.canCheckBiometrics;
//     } on PlatformException catch (e) {
//       canCheckBiometrics = false;
//       print(e);
//     }
//     if (!mounted) {
//       return;
//     }

//     setState(() {
//       _canCheckBiometrics = canCheckBiometrics;
//     });
//   }

//   Future<void> _getAvailableBiometrics() async {
//     late List<BiometricType> availableBiometrics;
//     try {
//       availableBiometrics = await auth.getAvailableBiometrics();
//     } on PlatformException catch (e) {
//       availableBiometrics = <BiometricType>[];
//       print(e);
//     }
//     if (!mounted) {
//       return;
//     }

//     setState(() {
//       _availableBiometrics = availableBiometrics;
//     });
//   }

//   Future<void> _authenticate() async {
//     bool authenticated = false;
//     try {
//       setState(() {
//         _isAuthenticating = true;
//         _authorized = 'Authenticating';
//       });
//       authenticated = await auth.authenticate(
//         localizedReason: 'Let OS determine authentication method',
//         options: const AuthenticationOptions(
//           stickyAuth: true,
//         ),
//       );
//       setState(() {
//         _isAuthenticating = false;
//       });
//     } on PlatformException catch (e) {
//       print(e);
//       setState(() {
//         _isAuthenticating = false;
//         _authorized = 'Error - ${e.message}';
//       });
//       return;
//     }
//     if (!mounted) {
//       return;
//     }

//     setState(
//         () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
//   }

//   Future<void> _authenticateWithBiometrics() async {
//     bool authenticated = false;
//     try {
//       setState(() {
//         _isAuthenticating = true;
//         _authorized = 'Authenticating';
//       });
//       authenticated = await auth.authenticate(
//         localizedReason:
//             'Scan your fingerprint (or face or whatever) to authenticate',
//         options: const AuthenticationOptions(
//           stickyAuth: true,
//           biometricOnly: true,
//         ),
//       );
//       setState(() {
//         _isAuthenticating = false;
//         _authorized = 'Authenticating';
//       });
//     } on PlatformException catch (e) {
//       print(e);
//       setState(() {
//         _isAuthenticating = false;
//         _authorized = 'Error - ${e.message}';
//       });
//       return;
//     }
//     if (!mounted) {
//       return;
//     }

//     final String message = authenticated ? 'Authorized' : 'Not Authorized';
//     setState(() {
//       _authorized = message;
//     });
//   }

//   Future<void> _cancelAuthentication() async {
//     await auth.stopAuthentication();
//     setState(() => _isAuthenticating = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: ListView(
//           padding: const EdgeInsets.only(top: 30),
//           children: <Widget>[
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 if (_supportState == _SupportState.unknown)
//                   const CircularProgressIndicator()
//                 else if (_supportState == _SupportState.supported)
//                   const Text('This device is supported')
//                 else
//                   const Text('This device is not supported'),
//                 const Divider(height: 100),
//                 Text('Can check biometrics: $_canCheckBiometrics\n'),
//                 ElevatedButton(
//                   onPressed: _checkBiometrics,
//                   child: const Text('Check biometrics'),
//                 ),
//                 const Divider(height: 100),
//                 Text('Available biometrics: $_availableBiometrics\n'),
//                 ElevatedButton(
//                   onPressed: _getAvailableBiometrics,
//                   child: const Text('Get available biometrics'),
//                 ),
//                 const Divider(height: 100),
//                 Text('Current State: $_authorized\n'),
//                 if (_isAuthenticating)
//                   ElevatedButton(
//                     onPressed: _cancelAuthentication,
//                     child: const Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         Text('Cancel Authentication'),
//                         Icon(Icons.cancel),
//                       ],
//                     ),
//                   )
//                 else
//                   Column(
//                     children: <Widget>[
//                       ElevatedButton(
//                         onPressed: _authenticate,
//                         child: const Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                             Text('Authenticate'),
//                             Icon(Icons.perm_device_information),
//                           ],
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: _authenticateWithBiometrics,
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                             Text(_isAuthenticating
//                                 ? 'Cancel'
//                                 : 'Authenticate: biometrics only'),
//                             const Icon(Icons.fingerprint),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// enum _SupportState {
//   unknown,
//   supported,
//   unsupported,
// }

// // import 'package:flutter/material.dart';

// // class MessageScreen extends StatelessWidget {
// //   const MessageScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return const Scaffold();
// //   }
// // }


