import 'package:Muhasebe/utils/loginformwdg.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginmobil extends StatefulWidget {
  @override
  _LoginmobilState createState() => _LoginmobilState();
}

class _LoginmobilState extends State<Loginmobil> {
  DateTime baslangictar = DateTime.now();
  Future<Null> secbasl(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark(),
            child: child,
          );
        },
        context: context,
        locale: Locale("tr"),
        initialDate: baslangictar,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        baslangictar = picked;
        print(baslangictar.toString());
        // contar.text =
        //       selectedDate.toString(); //DateFormat.yMd().format(selectedDate);
      });
  }

  Future<bool> sharprefset() async {
    print("ee");
    SharedPreferences sp = await SharedPreferences.getInstance();
    var islogin = sp.setBool("islogin", true);
    print("uu");
    return islogin;
  }

  Future<bool> sharprefsifirla() async {
    print("ee");
    SharedPreferences sp = await SharedPreferences.getInstance();
    var islogin = sp.setBool("islogin", false);
    print("uu");
    return islogin;
  }

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SafeArea(
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      Color.fromRGBO(66, 105, 255, 1),
                      Color.fromRGBO(66, 205, 255, 1)
                    ])),
                child: Column(children: [
                  Container(
                    color: Colors.red,
                    height: 100,
                    child: TextButton(
                        onPressed: () async {
                          print("dsa");
                          sharprefset()
                              .then((value) => print(value.toString()));
                          await secbasl(context);
                        },
                        child: Text("dd")),
                  ),
                  /*    Image.asset('images/login-form.png',
                      height: heightSize * 0.3, width: widthSize * 0.6),*/
                  SingleChildScrollView(
                      child: Loginformwdg(
                          0.007,
                          0.04,
                          widthSize * 0.04,
                          0.06,
                          0.04,
                          0.07,
                          widthSize * 0.09,
                          0.05,
                          0.032,
                          0.04,
                          0.032))
                ]))));
  }
}
