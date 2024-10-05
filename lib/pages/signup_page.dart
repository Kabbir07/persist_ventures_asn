import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persist_ventures_asn/widgets/c_text.dart';
import '../controllers/auth_controller.dart';
import '../shared/colors.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _authController = Get.put(AuthController());

  bool _isPasswordVisible = false;
  bool _isCnfPasswordVisible = false;
  bool _isAgreedTC = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cnfPasswordController = TextEditingController();

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
              const Row(
                children: [
                  CText("Create Account", size: 22, weight: FontWeight.bold),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
// full name rich text
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Full Name",
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

// full name text field
              SizedBox(
                height: 45,
                child: TextField(
                  controller: _nameController,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: grey300, width: 2.5),
                    ),
                    contentPadding: const EdgeInsets.all(15),
                    prefixIcon: const Icon(
                      Icons.person,
                      size: 18,
                    ),
                    prefixIconColor: grey500,
                    hintStyle: TextStyle(
                      color: grey500,
                      fontSize: 14,
                    ),
                    hintText: "Ex : John Doe",
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),

// email rich text
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Email",
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

// email text field
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
                    hintText: "Ex : john@example.com",
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),

// password rich text
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Create Password",
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

// password text field
              SizedBox(
                height: 45,
                child: TextField(
                  controller: _passwordController,
                  obscureText: _isPasswordVisible == false,
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
                    hintText: "Ex : #123aBc!",
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
                height: 15,
              ),

//confirm password rich text
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Confirm Password",
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

// confirm password text field
              SizedBox(
                height: 45,
                child: TextField(
                  controller: _cnfPasswordController,
                  obscureText: _isCnfPasswordVisible == false,
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
                    hintText: "Retype your password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isCnfPasswordVisible = !_isCnfPasswordVisible;
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
                height: 10,
              ),

// terms and conditions
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isAgreedTC = !_isAgreedTC;
                      });
                    },
                    child: Container(
                      width: 18.0,
                      height: 18.0,
                      decoration: BoxDecoration(
                        color: _isAgreedTC ? Colors.blue : Colors.transparent,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: grey800,
                          width: 2.0,
                        ),
                      ),
                      child: _isAgreedTC
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
                    "I agree to terms & conditions",
                    size: 12,
                    color: grey800,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
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
                    // Get.to(const SignupPage());

                    _validateFields();
                  },
                  child: CText(
                    "Create Account",
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
                  Get.back();
                },
                child: RichText(
                  text: TextSpan(
                    text: "Already have account?",
                    style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: ' Sign In',
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
    if (_nameController.text.isEmpty) {
      Get.snackbar("Error", "Name cannot be empty");
      return;
    }

    if (_emailController.text.isEmpty) {
      Get.snackbar("Error", "Email cannot be empty");
      return;
    }

    if (_passwordController.text.isEmpty) {
      Get.snackbar("Error", "Password cannot be empty");
      return;
    }

    if (_cnfPasswordController.text.isEmpty) {
      Get.snackbar("Error", "Confirm Password cannot be empty");
      return;
    }

    if (_passwordController.text != _cnfPasswordController.text) {
      Get.snackbar("Error", "Password and Confirm Password do not match");
      return;
    }

    if (!_isAgreedTC) {
      Get.snackbar("Error", "Please agree to terms & conditions");
      return;
    }
    _authController.signUpWithEmailAndPassword(_nameController.text.trim(),
        _emailController.text.trim(), _passwordController.text.trim());
  }
}
