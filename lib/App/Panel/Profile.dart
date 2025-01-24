import 'package:flutter/material.dart';
import '../../Theme/Scaffold.dart';


class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const BodyScaffold(
      body: Center(
        child: Text("Profile"),
      ),
    );
  }
}
