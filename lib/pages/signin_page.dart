import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persist_ventures_asn/pages/home_page.dart';
import 'package:persist_ventures_asn/pages/signup_page.dart';
import 'package:persist_ventures_asn/shared/colors.dart';
import 'package:persist_ventures_asn/shared/navigation_helper.dart';
import 'package:persist_ventures_asn/widgets/c_text.dart';
import '../controllers/auth_controller.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _authController = Get.put(AuthController());

  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 70),
              Image.asset(
                "assets/images/ngbrgd_logo.png",
                width: MediaQuery.of(context).size.width,
              ),
              const CText("Welcome Back!", size: 22, weight: FontWeight.bold),
              const SizedBox(
                height: 3,
              ),
              CText(
                "Let's begin for explore continuous",
                size: 13,
                color: grey500,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Email or Phone Number",
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold),
                      children: const [
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 45,
                child: TextField(
                  controller: _emailController,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: grey300, width: 2.5),
                    ),
                    contentPadding: const EdgeInsets.all(15),
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      size: 18,
                    ),
                    prefixIconColor: grey500,
                    hintStyle: TextStyle(
                      color: grey500,
                      fontSize: 14,
                    ),
                    hintText: "Email or Phone Number",
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Password",
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold),
                      children: const [
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 45,
                child: TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: grey300, width: 2.5),
                    ),
                    contentPadding: const EdgeInsets.all(15),
                    prefixIcon: const Icon(
                      Icons.lock_outline_rounded,
                      size: 20,
                    ),
                    prefixIconColor: grey500,
                    hintStyle: TextStyle(
                      color: grey500,
                      fontSize: 14,
                    ),
                    hintText: "Enter your password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: grey800,
                          size: 18,
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: CText(
                      "Forgot Password?",
                      color: amber,
                      size: 12.5,
                      weight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _rememberMe = !_rememberMe;
                      });
                    },
                    child: Container(
                      width: 18.0,
                      height: 18.0,
                      decoration: BoxDecoration(
                        color: _rememberMe ? Colors.blue : Colors.transparent,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: grey800,
                          width: 2.0,
                        ),
                      ),
                      child: _rememberMe
                          ? Icon(
                              Icons.check,
                              color: white,
                              size: 13.0,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  CText(
                    "Remember Me",
                    size: 12,
                    color: grey800,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: deeporrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    // goNextPage(const HomePage());
                    _validateFields();
                  },
                  child: CText(
                    "Sign In",
                    color: white,
                    size: 14,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: grey500,
                      thickness: 1,
                      endIndent: 10,
                    ),
                  ),
                  Text(
                    'You can connect with',
                    style: TextStyle(fontSize: 14.0, color: grey800),
                  ),
                  Expanded(
                    child: Divider(
                      color: grey500,
                      thickness: 1,
                      indent: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 45.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                      color: grey100,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset("assets/images/facebook.png"),
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Container(
                    width: 45.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                      color: grey100,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset("assets/images/google.png"),
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Container(
                    width: 45.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                      color: grey100,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset("assets/images/apple.png"),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  // Get.to(const SignupPage());
                  goNextPage(const SignupPage());
                },
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account?",
                    style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: ' Sign Up here',
                        style: TextStyle(
                          color: amber,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _validateFields() {
    if (_emailController.text.isEmpty) {
      Get.snackbar("Error", "Email cannot be empty");
      return;
    }

    if (_passwordController.text.isEmpty) {
      Get.snackbar("Error", "Password cannot be empty");
      return;
    }

    _authController.signInWithEmailAndPassword(
        _emailController.text.trim(), _passwordController.text.trim());
  }
}
