import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_mart_11bdg/core/services/auth_services.dart';
import 'package:e_mart_11bdg/presentation/pages/login.dart';
import 'package:e_mart_11bdg/data/controllers/loginAnimate.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with TickerProviderStateMixin {
  late LoginAnimationController animationController;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    setState(() {
      isLoading = true;
    });

    final success = await AuthService().register(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      noTelp: phoneController.text.trim(),
      password: passwordController.text.trim(),
    );

    setState(() {
      isLoading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registrasi berhasil. Silakan login.")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registrasi gagal. Coba lagi.")),
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
          SlideTransition(
            position: animationController.slide1,
            child: FadeTransition(
              opacity: animationController.fade1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const Text(
                      "REGISTER | E-MART",
                      style: TextStyle(
                        color: Color(0xFFBF3131),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Righteous',
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(nameController, "Nama Lengkap"),
                    const SizedBox(height: 10),
                    _buildTextField(emailController, "Email"),
                    const SizedBox(height: 10),
                    _buildTextField(phoneController, "No. Telepon"),
                    const SizedBox(height: 10),
                    _buildTextField(passwordController, "Password", obscure: true),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: isLoading ? null : _handleRegister,
                      child: Container(
                        width: 120,
                        padding: const EdgeInsets.symmetric(vertical: 12),
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
                                  'REGISTER',
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
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text(
                        "Sudah punya akun? Login",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFBF3131),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Righteous',
                        ),
                      ),
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
            ),
          ),
        ],  
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {bool obscure = false}) {
    return Container(
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
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(
          fontSize: 12,
          fontFamily: 'Righteous',
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
