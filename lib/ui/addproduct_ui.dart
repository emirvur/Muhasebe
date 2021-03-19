import 'package:flutter/material.dart';

class AddProdForm extends StatefulWidget {
  @override
  _AddProdFormState createState() => _AddProdFormState();
}

class _AddProdFormState extends State<AddProdForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Expanded(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Text(
                              "Hizmet ve Ürünler > Yeni",
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),

                            //   SizedBox(
                            //       width: 13,  ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 24.0),
                              child: Text(
                                "Ahmet Seç",
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              color: Colors.white,
                              child: Column(children: [
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Center(
                                                    child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Icon(Icons
                                                            .bar_chart_outlined)),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text("Adı")),
                                                  ],
                                                ))),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                height: 45,
                                                child: TextFormField(
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (value) {
                                                    // validation logic
                                                  },
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 45,
                                                  margin: EdgeInsets.all(20),
                                                  child: FlatButton(
                                                    child: Text('Vazgeç'),
                                                    color: Colors.grey,
                                                    textColor: Colors.white,
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                Container(
                                                  height: 45,
                                                  margin: EdgeInsets.all(20),
                                                  child: FlatButton(
                                                    child: Text('Kaydet'),
                                                    color: Colors.blueAccent,
                                                    textColor: Colors.white,
                                                    onPressed: () {},
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Center(
                                                    child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Icon(Icons
                                                            .bar_chart_outlined)),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text("Adı")),
                                                  ],
                                                ))),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                height: 45,
                                                //   width: 45,
                                                child: TextFormField(
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (value) {
                                                    // validation logic
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Center(
                                                    child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Icon(Icons
                                                            .bar_chart_outlined)),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text("Adı")),
                                                  ],
                                                ))),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                height: 45,
                                                child: TextFormField(
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (value) {
                                                    // validation logic
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Center(
                                                    child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Icon(Icons
                                                            .bar_chart_outlined)),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text("Adı")),
                                                  ],
                                                ))),
                                            Expanded(
                                                flex: 4,
                                                child: Chip(
                                                  label: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child:
                                                          Text("Kategorisiz")),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Center(
                                                    child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Icon(Icons
                                                            .bar_chart_outlined)),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                            "Alış/Satış Birimi")),
                                                  ],
                                                ))),
                                            Expanded(
                                                flex: 4,
                                                child: DropdownButton<String>(
                                                  items: <String>[
                                                    'Adet',
                                                    'Kilogram',
                                                    'Litre',
                                                  ].map((String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value:
                                                          "11", // selectedvalue
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  onChanged: (_) {},
                                                )),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Center(
                                                    child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Icon(Icons
                                                            .bar_chart_outlined)),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text("Adı")),
                                                  ],
                                                ))),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  //     height: ,
                                                  child: CheckboxListTile(
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    title:
                                                        Text('I am true now'),
                                                    value: true,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        //     _checkboxListTile = !_checkboxListTile;
                                                      });
                                                    },
                                                  )),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  //   height: ,
                                                  child: CheckboxListTile(
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    title:
                                                        Text('I am false now'),
                                                    value: false,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        //     _checkboxListTile = !_checkboxListTile;
                                                      });
                                                    },
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Center(
                                                    child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Icon(Icons
                                                            .bar_chart_outlined)),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text("Adı")),
                                                  ],
                                                ))),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                height: 45,
                                                child: TextFormField(
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (value) {
                                                    // validation logic
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Center(
                                                    child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Icon(Icons
                                                            .bar_chart_outlined)),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text("Adı")),
                                                  ],
                                                ))),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  //     height: ,
                                                  child: CheckboxListTile(
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    title:
                                                        Text('I am true now'),
                                                    value: true,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        //     _checkboxListTile = !_checkboxListTile;
                                                      });
                                                    },
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(flex: 1, child: Text("")),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                //   height: 45,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 45,
                                                      //  color: Colors.grey,
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey,
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black)),
                                                      child: Center(
                                                        child: Text(
                                                            "Kritik Stok Seviyesi"),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        height: 45,
                                                        child: TextFormField(
                                                          decoration: const InputDecoration(
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius
                                                                              .zero))),
                                                          validator: (value) {
                                                            // validation logic
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(flex: 1, child: Text("")),
                                            Expanded(
                                                flex: 4,
                                                child: Text(
                                                  "Stok, belirttiğiniz seviyenin altına düştüğünde e-posta ve mobil uygulamamız aracılığı ile haberdar edilir, ürün liste ve sayfalarında kritik miktardaki ürünlerinizi görebilirsiniz.",
                                                  style: TextStyle(
                                                      fontSize: 8,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Center(
                                                    child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Icon(Icons
                                                            .bar_chart_outlined)),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text("Adı")),
                                                  ],
                                                ))),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                height: 45,
                                                child: TextFormField(
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (value) {
                                                    // validation logic
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Center(
                                                    child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Icon(Icons
                                                            .bar_chart_outlined)),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text("Adı")),
                                                  ],
                                                ))),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                height: 45,
                                                child: TextFormField(
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (value) {
                                                    // validation logic
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Center(
                                                    child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Icon(Icons
                                                            .bar_chart_outlined)),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                            "Alış/Satış Birimi")),
                                                  ],
                                                ))),
                                            Expanded(
                                                flex: 4,
                                                child: DropdownButton<String>(
                                                  items: <String>[
                                                    '%18',
                                                    '%8',
                                                    '%1',
                                                  ].map((String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value:
                                                          "11", // selectedvalue
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  onChanged: (_) {},
                                                )),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Center(
                                                    child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Icon(Icons
                                                            .bar_chart_outlined)),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text("Adı")),
                                                  ],
                                                ))),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                height: 45,
                                                child: TextFormField(
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (value) {
                                                    // validation logic
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Center(
                                                    child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Icon(Icons
                                                            .bar_chart_outlined)),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text("Adı")),
                                                  ],
                                                ))),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                height: 45,
                                                child: TextFormField(
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (value) {
                                                    // validation logic
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ])))
                    ]),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
