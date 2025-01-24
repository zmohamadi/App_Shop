import 'package:flutter/material.dart';
import './AppBar.dart';
import './BottomBar.dart';
import './Drawer.dart';

class BodyScaffold extends StatelessWidget {
  final dynamic body, appBar, bottomNavigationBar, drawer;

  const BodyScaffold({super.key, this.body, this.appBar, this.bottomNavigationBar, this.drawer});

  @override
  Widget build(BuildContext context) {

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: appBar == false? null: (appBar ?? const HeadAppBar()),
          bottomNavigationBar: bottomNavigationBar == false? null: (bottomNavigationBar ?? const FooterBottomBar()),
          body: body,
          endDrawer: drawer == false? null: (drawer ?? const BaseDrawer()),
        ),
    );
  }
}
