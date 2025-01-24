import 'package:flutter/material.dart';
import '../Theme/Scaffold.dart';


class Sample extends StatelessWidget {
  const Sample({super.key});

  @override
  Widget build(BuildContext context) {
    return const BodyScaffold(
      body: Center(
        child: Text("صفحه نمونه"),
      ),
    );
  }
}
