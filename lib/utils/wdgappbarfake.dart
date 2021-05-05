import 'package:flutter/material.dart';

class Wdgappbarfake extends StatelessWidget {
  const Wdgappbarfake(); //: super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            text: "",
            style: TextStyle(color: Colors.grey, fontSize: 24),
            children: <TextSpan>[
              TextSpan(
                  text: "", style: TextStyle(color: Colors.black, fontSize: 24)
                  //       fontWeight:
                  //              FontWeight.w300)
                  ),
            ],
          ),
        ),
        Row(
          children: [
            Column(
              children: [
                Text(
                  "",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0, // fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0, // fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
