import 'package:flutter/material.dart';

class SatisfatDetailui extends StatefulWidget {
  @override
  _SatisfatDetailuiState createState() => _SatisfatDetailuiState();
}

class _SatisfatDetailuiState extends State<SatisfatDetailui> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey.shade200,
            body: Column(
              children: [
                Text("bbbbb"),
                Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Expanded(
                          child: Column(
                            children: [Text("fggg")],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Column(
                      children: [Text("fggg")],
                    ))
                  ],
                ),
              ],
            )));
  }
}
