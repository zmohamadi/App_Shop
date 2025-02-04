import 'package:flutter/material.dart';
import './AppBar.dart';
import './BottomBar.dart';
import './Drawer.dart';
import '../env.dart';

class BodyScaffold extends StatelessWidget {
  final dynamic body, appBar, bottomNavigationBar, drawer;

  const BodyScaffold({super.key, this.body, this.appBar, this.bottomNavigationBar, this.drawer});

  @override
  Widget build(BuildContext context) {
    TextDirection textDirection = env.direction == 'rtl' ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
        textDirection: textDirection,
        child: Scaffold(
          appBar: appBar == false? null: (appBar ?? const HeadAppBar()),
          bottomNavigationBar: bottomNavigationBar == false? null: (bottomNavigationBar ?? const FooterBottomBar()),
          body: body,
          endDrawer: drawer == false? null: (drawer ?? const BaseDrawer()),
        ),
    );
  }
}
