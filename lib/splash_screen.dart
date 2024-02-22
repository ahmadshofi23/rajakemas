import 'package:flutter/material.dart';
import 'package:rajakemas/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    navigateToHome();
    super.initState();
  }

  void navigateToHome(){
    Future.delayed(Duration(seconds: 2)).then((value) => Navigator.pushReplacement(context,_createRoute()));
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
      transitionDuration: const Duration(seconds: 3),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background.png'),
            fit: BoxFit.fill
          )
      ),
      child: SafeArea(
          child: Stack(
            children: [
              Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                    child: Image.asset('assets/logoapps.png'),
                  )
              ),
              Positioned(
                left: 0,
                 bottom: 0,
                 right: 0,
                  child: Image.asset('assets/logobanner.png', height: MediaQuery.of(context).size.height * 0.1,))
            ],
          ),
      )
    );
  }
}
