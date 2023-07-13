import 'package:flutter/material.dart';
import 'package:my_todo_app/data/lolcal_data/storage.dart';
import 'package:my_todo_app/presentation/login/register_screen/register_screen.dart';
import 'package:my_todo_app/presentation/tabs/tab_box/tab_box.dart';
import 'package:my_todo_app/utils/utility_functions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String savedUsername = '';
  String savedPassword = '';
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    getInitials();
    super.initState();
  }

  void getInitials() {
    savedPassword = StorageRepository.getString("password");
    savedUsername = StorageRepository.getString("username");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: usernameController,
          ),
          TextField(
            controller: passwordController,
          ),
          TextButton(
              onPressed: () async {
                String username = usernameController.text;
                String password = passwordController.text;

                if (username.length > 3 && password.length > 6) {
                  if (username == savedUsername && password == savedPassword) {
                    await StorageRepository.putBool('is_logged', true);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const TabBox();
                        },
                      ),
                    );
                  } else {
                    UtilityFunctions.getMyToast(
                        message: "Username and Password wrong");
                  }
                } else {
                  UtilityFunctions.getMyToast(
                      message: "Password length >6 and username length > 3");
                }
              },
              child: const Text("Login")),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const RegisterScreen();
                }));
              },
              child: const Text("Register"))
        ],
      ),
    ));
  }
}
