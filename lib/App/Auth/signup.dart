import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/auth_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'auth_layout.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  bool _agreeToTerms = false;
  bool _isPasswordVisible = false;

  void _submitForm() {
    if (_formKey.currentState!.validate() && _agreeToTerms) {
      authController.register(
        _nameController.text,
        _emailController.text,
        '',
        _passwordController.text,
      );
    } else if (!_agreeToTerms) {
      Get.snackbar('خطا', 'باید با قوانین موافقت کنید.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("ایجاد حساب کاربری", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text("لطفاً اطلاعات خود را وارد کنید", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "نام*", border: OutlineInputBorder()),
                  validator: (value) => value == null || value.isEmpty ? "نام الزامی است" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: "ایمیل*", border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "ایمیل الزامی است";
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return "ایمیل معتبر نیست";
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: "رمز عبور*",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                    ),
                  ),
                  validator: (value) => value == null || value.length < 6 ? "رمز عبور باید حداقل ۶ کاراکتر باشد" : null,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: _agreeToTerms,
                      onChanged: (value) => setState(() => _agreeToTerms = value!),
                    ),
                    const Text("موافقت با قوانین و مقررات"),
                  ],
                ),
                const SizedBox(height: 24),
                Obx(() => ElevatedButton(
                  onPressed: authController.isLoading.value ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.black,
                  ),
                  child: authController.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("ثبت‌نام", style: TextStyle(color: Colors.white)),
                )),
                const SizedBox(height: 16),
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 8.0), child: Text("یا ورود با")),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: authController.loginWithGoogle,
                  icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
                  label: const Text("ورود با جیمیل"),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
