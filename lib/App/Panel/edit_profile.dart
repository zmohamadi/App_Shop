import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  // متغیرها برای ذخیره اطلاعات فرم
  File? _image;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  // تابع انتخاب تصویر از گالری
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // تابع ثبت اطلاعات فرم
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String phone = _phoneController.text;
      String email = _emailController.text;
      String address = _addressController.text;

      // اینجا می‌توان اطلاعات را برای ذخیره در دیتابیس ارسال کرد
      print("نام: $name");
      print("موبایل: $phone");
      print("ایمیل: $email");
      print("آدرس: $address");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ویرایش پروفایل")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // تصویر پروفایل
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? const Icon(Icons.camera_alt, size: 50)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // فیلد نام
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "نام کامل"),
                validator: (value) => value!.isEmpty ? "نام را وارد کنید" : null,
              ),
              // فیلد شماره موبایل
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: "شماره موبایل"),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? "شماره موبایل را وارد کنید" : null,
              ),
              // فیلد ایمیل
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "ایمیل"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value!.contains("@") ? null : "ایمیل معتبر وارد کنید",
              ),
              // فیلد آدرس
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: "آدرس"),
              ),
              const SizedBox(height: 20),
              // دکمه ثبت فرم
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("ثبت"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
