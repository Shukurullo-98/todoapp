import 'package:flutter/material.dart';
import 'package:my_todo_app/data/lolcal_data/storage.dart';
import 'package:my_todo_app/presentation/login/login_screen/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPageIndex = 0;
  String buttonText = "Next";
  PageController controller = PageController(initialPage: 0);
  List<Widget> screens = [
    Container(
      color: Colors.pink,
      child: Center(
        child: Text("Page 1"),
      ),
    ),
    Container(
      color: Colors.pink,
      child: Center(
        child: Text("Page 2"),
      ),
    ),
    Container(
      color: Colors.pink,
      child: Center(
        child: Text("Page 3"),
      ),
    ),
    Container(
      color: Colors.pink,
      child: Center(
        child: Text("Page 4"),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [SizedBox(), Text("Skip")],
          ),
          Expanded(
              child: PageView(
            onPageChanged: (pageIndex) {},
            controller: controller,
            children: screens,
          )),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 10,
                color: currentPageIndex == 0 ? Colors.blueAccent : Colors.blue,
                width: currentPageIndex == 0 ? 20 : 10,
              ),
              Container(
                height: 10,
                color: currentPageIndex == 2
                    ? Colors.blueAccent.shade400
                    : Colors.blue.shade50,
                width: currentPageIndex == 2 ? 20 : 10,
              ),
              TextButton(
                  onPressed: () async {
                    if (currentPageIndex < 2) {
                      setState(() {
                        currentPageIndex++;
                        controller.jumpToPage(currentPageIndex);
                      });
                    } else {
                      await StorageRepository.putBool("is_initial", true);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return LoginScreen();
                        }),
                      );
                    }
                    if (currentPageIndex == 2) {
                      setState(() {
                        buttonText = 'Lets Start';
                      });
                    }
                  },
                  child: Container(
                    height: 55,
                    child: Center(child: Text(buttonText)),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
