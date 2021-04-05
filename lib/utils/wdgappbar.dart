import 'package:flutter/material.dart';

class Wdgappbar extends StatelessWidget {
  final String ilk;
  final String iki;
  final String ad;
  const Wdgappbar(this.ilk, this.iki, this.ad); //: super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            text: ilk,
            style: TextStyle(color: Colors.grey, fontSize: 24),
            children: <TextSpan>[
              TextSpan(
                  text: iki, style: TextStyle(color: Colors.black, fontSize: 24)
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
                  ad,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0, // fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "Buse Tekstil",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0, // fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 5,
            ),
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.tealAccent,
              child: Icon(
                Icons.person,
                color: Color(0xffCCCCCC),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
