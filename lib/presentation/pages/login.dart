import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/loginAnimation.dart';
import 'package:e_mart_11bdg/data/controllers/loginAnimate.dart';
import '../widgets/sosialButton.dart';
import '../pages/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late LoginAnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = LoginAnimationController(this);
    animationController.controller.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          SlideTransition(
            position: animationController.slide1,
            child: FadeTransition(
              opacity: animationController.fade1,
              child: Container(
                height: 400,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: SvgPicture.asset(
                        'assets/images/login-regist/4.svg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 100,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        height: 330,
                        width: width + 20,
                        child: SvgPicture.asset(
                          'assets/images/login-regist/2.svg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: SvgPicture.asset(
                        'assets/images/login-regist/3.svg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 0),
          SlideTransition(
            position: animationController.slide1,
            child: FadeTransition(
              opacity: animationController.fade1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "LOGIN | E-MART",
                      style: TextStyle(
                        color: Color(0xFFBF3131),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Righteous',
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 300,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 6),
                            spreadRadius: 0,
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: TextField(
                        style: TextStyle(fontSize: 12, fontFamily: 'Righteous'),
                        decoration: InputDecoration(
                          hintText: 'Masukkan Email',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 300,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 6),
                            spreadRadius: 0,
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: TextField(
                        style: TextStyle(fontSize: 12, fontFamily: 'Righteous'),
                        decoration: InputDecoration(
                          hintText: 'Masukkan Password',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      child: Container(
                        width: 100,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 6),
                              spreadRadius: 0,
                              color: Color.fromRGBO(0, 0, 0, 0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Righteous',
                              color: Colors.white,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 0),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFBF3131),
                                  fontFamily: 'Righteous',
                                ),
                              ),
                              SizedBox(width: 6),
                              GestureDetector(
                                onTap: () {
                                  print('Register tapped');
                                },
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 139, 35, 35),
                                    fontFamily: 'Righteous',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: 2,
                            margin: EdgeInsets.symmetric(horizontal: 40),
                            color: const Color.fromARGB(255, 139, 40, 32),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Or Login With',
                      style: TextStyle(
                        fontFamily: 'Righteous',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFBF3131),
                      ),
                    ),
                    SizedBox(height: 10),
                    GoogleLoginButton(
                      onPressed: () {
                        print('Google Sign In tapped');
                      },
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
