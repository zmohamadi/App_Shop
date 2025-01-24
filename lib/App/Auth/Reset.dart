import 'package:flutter/material.dart';
import '../../Theme/Scaffold.dart';


class Reset extends StatelessWidget {
  const Reset({super.key});

  @override
  Widget build(BuildContext context) {
    return const BodyScaffold(
      body: Center(
        child: Text("Reset"),
      ),
    );
  }
}
