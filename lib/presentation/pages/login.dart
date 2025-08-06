import 'package:e_mart_11bdg/core/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/loginAnimation.dart';
import 'package:e_mart_11bdg/data/controllers/loginAnimate.dart';
import '../widgets/sosialButton.dart';
import '../pages/home.dart';
import 'package:e_mart_11bdg/data/models/User.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late LoginAnimationController animationController;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email dan Password wajib diisi')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final User? user = await _authService.login(email, password);

      if (!mounted) return;
      setState(() => _isLoading = false);

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login berhasil, selamat datang ${user.name}')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login gagal, periksa email dan password kamu!'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  void _register() {
    Navigator.pushNamed(context, '/register');
  }

  @override
  void initState() {
    super.initState();
    animationController = LoginAnimationController(this);
    animationController.controller.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          SlideTransition(
            position: animationController.slide1,
            child: FadeTransition(
              opacity: animationController.fade1,
              child: SizedBox(
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
                        style: const TextStyle(fontSize: 12, fontFamily: 'Righteous'),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
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
                        style: const TextStyle(fontSize: 12, fontFamily: 'Righteous'),
                        controller: _passwordController,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          hintText: 'Masukkan Password',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          border: InputBorder.none,
                        ),
                        onSubmitted: (_) => _login(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // ========= TOMBOL LOGIN YANG BENAR =========
                    GestureDetector(
                      onTap: _isLoading ? null : _login,
                      child: Container(
                        width: 120,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _isLoading ? Colors.grey : Colors.red,
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
                          child: _isLoading
                              ? const SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
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
                                onTap: _register,
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
                        // TODO: implement google sign in
                        debugPrint('Google Sign In tapped');
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