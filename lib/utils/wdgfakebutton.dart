import 'package:flutter/material.dart';

class Wdgfakebutton extends StatelessWidget {
  const Wdgfakebutton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 5,
          margin: EdgeInsets.all(20),
          child: FlatButton(
            child: Text(''),
            color: Colors.white,
            textColor: Colors.white,
            onPressed: () {},
          ),
        ),
        Container(
          height: 5,
          margin: EdgeInsets.all(20),
          child: FlatButton(
            child: Text(''),
            color: Colors.white,
            textColor: Colors.white,
            onPressed: () {
              //kaydet işlemi yapp
            },
          ),
        ),
      ],
    );
  }
}
