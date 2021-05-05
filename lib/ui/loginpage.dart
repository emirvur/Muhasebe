import 'package:Muhasebe/ui/loginmobil.dart';
import 'package:Muhasebe/ui/loginweb.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 1024) {
          return Loginmobil();
        } else {
          return Loginweb();
        }
      },
    );
  }
}
