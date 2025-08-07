import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_mart_11bdg/presentation/widgets/sosialButton.dart';
import 'package:e_mart_11bdg/core/services/auth_services.dart';
import 'package:e_mart_11bdg/presentation/pages/home.dart';
import 'package:e_mart_11bdg/presentation/pages/register.dart';
import 'package:e_mart_11bdg/data/controllers/loginAnimate.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late LoginAnimationController animationController;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    animationController = LoginAnimationController(this);
    animationController.controller.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    setState(() {
      isLoading = true;
    });

    final success = await AuthService().login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    setState(() {
      isLoading = false;
    });

    if (success) {
      // Navigasi ke halaman Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login gagal. Cek email atau password.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
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
          const SizedBox(height: 0),
          SlideTransition(
            position: animationController.slide1,
            child: FadeTransition(
              opacity: animationController.fade1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "LOGIN | E-MART",
                      style: TextStyle(
                        color: Color(0xFFBF3131),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Righteous',
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 300,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 6),
                            spreadRadius: 0,
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Righteous',
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Masukkan Email',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 300,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 6),
                            spreadRadius: 0,
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Righteous',
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Masukkan Password',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: isLoading ? null : _handleLogin,
                      child: Container(
                        width: 100,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 6),
                              spreadRadius: 0,
                              color: Color.fromRGBO(0, 0, 0, 0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Center(
                          child: isLoading
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : const Text(
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
                    const SizedBox(height: 0),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFBF3131),
                                  fontFamily: 'Righteous',
                                ),
                              ),
                              const SizedBox(width: 6),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context, 
                                    MaterialPageRoute(builder: (context) => const RegisterPage()));
                                },
                                child: const Text(
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
                          const SizedBox(height: 8),
                          Container(
                            height: 2,
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            color: const Color.fromARGB(255, 139, 40, 32),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      'Or Login With',
                      style: TextStyle(
                        fontFamily: 'Righteous',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFBF3131),
                      ),
                    ),
                    const SizedBox(height: 10),
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