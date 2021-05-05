import 'package:flutter/material.dart';

class Wdgloadingalert extends StatelessWidget {
  const Wdgloadingalert({
    Key key,
    @required this.wsize,
  }) : super(key: key);

  final Size wsize;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: wsize.height / 4,
        width: wsize.width / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(),
            Text("Lütfen Bekleyiniz"),
            SizedBox(
              height: 50,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
      actions: [
        FlatButton(
          child: Text(""),
          onPressed: () {
            //  Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(""),
          onPressed: () {
            //  Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
