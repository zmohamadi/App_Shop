import 'package:flutter/material.dart';
import '../../Theme/Scaffold.dart';


class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const BodyScaffold(
      body: Center(
        child: Text("Login"),
      ),
    );
  }
}
