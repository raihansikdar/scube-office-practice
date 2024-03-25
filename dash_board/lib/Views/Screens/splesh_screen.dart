/*
import 'package:dash_board/Views/Screens/dash_board_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  void goTONextPage(){
    Future.delayed(const Duration(seconds: 2)).then((value) =>
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const DashBoardScreen()),
                (route) => false));
  }

bool animate = false;

  void splashAnimation() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    animate = true;
    await Future.delayed(const Duration(milliseconds: 3000));
   // animate = false;
   // await Future.delayed(const Duration(milliseconds: 1600));

  }

  @override
  void initState() {
    //goTONextPage();
    splashAnimation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/images/logo.png')),
          const Text('WELCOME T0 SQ GROUP',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.deepPurple),),
          SizedBox(height: 8.0,),
          const Text('©Scube Technologies Limited',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w600,fontStyle: FontStyle.italic),),
        ],
      ),
    );
  }
}
*/
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dash_board/Views/Screens/dash_board_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void goTONextPage() {
    Future.delayed(const Duration(seconds: 2)).then((value) =>
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const DashBoardScreen()),
            (route) => false));
  }




  @override
  void initState() {
    goTONextPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/images/logo.png')),
         /* const Text(
            'WELCOME T0 SQ GROUP',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple),
          ),*/
          const SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(width: 20.0, height: 100.0),
              const Text(
                'WELCOME T0',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              const SizedBox(width: 20.0, height: 100.0),
              DefaultTextStyle(
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
                child: AnimatedTextKit(
                  animatedTexts: [
                    RotateAnimatedText('SQ GROUP', ),
                  ],
                ),
              ),
            ],
          ),
          /*const Text(
            '©Scube Technologies Limited',
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic),
          ),*/

          Center(
            child: SizedBox(
             // width: 250.0,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                   fontStyle: FontStyle.italic
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText('©Scube Technologies Limited',

                      speed: const Duration(milliseconds: 50),
                    ),
                  ],

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
