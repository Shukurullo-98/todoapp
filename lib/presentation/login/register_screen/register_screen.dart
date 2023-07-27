import 'package:flutter/material.dart';
import 'package:my_todo_app/data/local_data/storage.dart';
import 'package:my_todo_app/presentation/login/login_screen/login_screen.dart';
import 'package:my_todo_app/utils/utility_functions.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController ageController = TextEditingController();


  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();

    usernameController.dispose();
    passwordController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register Screen"),
      leading: IconButton(onPressed: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
          return const LoginScreen();
        }));
      },icon: const Icon(Icons.arrow_back_sharp),),),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              onSubmitted: (value){
                UtilityFunctions.filedFocusChange(context, focusNode1, focusNode2);
              },
              controller: usernameController,
              focusNode: focusNode1,
            ),
            TextField(
              controller: passwordController,
              onSubmitted: (value){
                UtilityFunctions.filedFocusChange(context, focusNode2, focusNode3);
              },
              focusNode: focusNode2,
            ),
            TextField(
              onSubmitted: (value){
                focusNode3.unfocus();
              },
              controller: ageController,
              focusNode: focusNode3,
            ),
            TextButton(
                onPressed: () async {
                  if (usernameController.text.length > 3 &&
                      passwordController.text.length > 6 &&
                      ageController.text.isNotEmpty) {
                    await StorageRepository.putString(
                        key: "username", value: usernameController.text);
                    await StorageRepository.putString(
                        key: "password", value: passwordController.text);
                    await StorageRepository.putString(
                        key: "age", value: ageController.text);
                  }
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return LoginScreen();
                  }));
                },
                child: const Text("Register Users"))
          ],
        ),
      ),
    );
  }
}
