import 'package:flutter/material.dart';
import '../env.dart';

class HeadAppBar extends StatelessWidget implements PreferredSizeWidget{
  @override
  Size get preferredSize => const Size.fromHeight(70);

  const HeadAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(env.mainTitle),
      // title: Text("آموزش مجازی برهان", style: TextStyle(fontFamily: header.font,)),

    );
  }
}
