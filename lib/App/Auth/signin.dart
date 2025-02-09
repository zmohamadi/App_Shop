import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Controllers/auth_controller.dart';
import 'auth_layout.dart';
import 'signup.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final authController = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عنوان
            const Center(
              child: Column(
                children: [
                  Text(
                    'Sign In To Your Account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Welcome Back! You've Been Missed!",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),

            // فیلد ایمیل
            const Text('Email Address*', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: 'Enter your email',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return "ایمیل الزامی است";
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return "ایمیل معتبر نیست";
                return null;
              },
            ),
            const SizedBox(height: 20),

            // فیلد پسورد
            const Text('Password*', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextFormField(
              controller: passwordController,
              obscureText: isPasswordHidden,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: 'Enter your password',
                suffixIcon: IconButton(
                  icon: Icon(isPasswordHidden ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      isPasswordHidden = !isPasswordHidden;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return "رمز عبور الزامی است";
                if (value.length < 6) return "رمز عبور باید حداقل ۶ کاراکتر باشد";
                return null;
              },
            ),
            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {}, 
                child: const Text('Forgot password?'),
              ),
            ),
            const SizedBox(height: 16),

            // دکمه ورود
            Obx(() => ElevatedButton(
                  onPressed: authController.isLoading.value
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            authController.login(
                              emailController.text.trim(),
                              "",
                              passwordController.text.trim(),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: authController.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Sign In', style: TextStyle(color: Colors.white, fontSize: 16)),
                )),
            const SizedBox(height: 20),

            const Center(child: Text('Or Continue With')),
            const SizedBox(height: 20),

            // دکمه‌های ورود با گوگل و اپل
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: authController.loginWithGoogle,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF1F1F1),
                    minimumSize: const Size(140, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                  label: const Text('Google', style: TextStyle(color: Colors.black)),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF1F1F1),
                    minimumSize: const Size(140, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: const Icon(Icons.apple, color: Colors.black),
                  label: const Text('Apple', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // لینک ثبت‌نام
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Not a member? "),
                GestureDetector(
                  onTap: () {
                    Get.to(() => SignUpScreen());
                  },
                  child: const Text(
                    'Create an account',
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
