import 'package:Muhasebe/ui/loginmobil.dart';
import 'package:Muhasebe/ui/loginpage.dart';
import 'package:Muhasebe/ui/urunler_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Islogin extends StatefulWidget {
  @override
  _IsloginState createState() => _IsloginState();
}

class _IsloginState extends State<Islogin> {
  bool x;
  sharprefal() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool islogin = sp.getBool("islogin");
    x = islogin;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharprefal();
  }

  @override
  Widget build(BuildContext context) {
    /*sharprefal().then((value) {
      print(value.toString());
      x = value;
      print("tesss");
    });*/
    if (x == true) {
      print("rrr");
      return UrunlerUi();
    } else {
      print("ooo");
      return Loginpage();
    }
  }
}
