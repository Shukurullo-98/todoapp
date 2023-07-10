import 'package:flutter/material.dart';
import 'package:my_todo_app/data/lolcal_data/storage.dart';

import '../login/login_screen/login_screen.dart';
import '../on_boarding/on_boarding_screen.dart';
import '../tabs/tab_box/tab_box.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool isLogged = false;
  bool isInitial = false;


  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async{
    await StorageRepository.getInstance();
    isLogged = StorageRepository.getBool("is_logged");
    isInitial = StorageRepository.getBool("is_initial");
    await Future.delayed(const Duration(seconds: 3));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
        return isLogged ? TabBox() : isInitial == true?  LoginScreen(): OnBoardingScreen();
      }));
    }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Splash Screen"),),
    );
  }
}
