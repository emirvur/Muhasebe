import 'package:flutter/material.dart';

class AddProdForm extends StatefulWidget {
  @override
  _AddProdFormState createState() => _AddProdFormState();
}

class _AddProdFormState extends State<AddProdForm> {
  final _formKey = GlobalKey<FormState>();
  String dropstr = "Adet";
  String strkd = "%18";
  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey.shade300,
          body: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Expanded(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                text: "Hizmet ve Ürünler >",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 24),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "Yeni",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 24)
                                      //       fontWeight:
                                      //              FontWeight.w300)
                                      ),
                                ],
                              ),
                            ),

                            //   SizedBox(
                            //       width: 13,  ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                "Ahmet Seç",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  //      fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              //  color: Colors.white,
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
                                                        child: Text(
                                                          "Adı",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
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
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  height: 45,
                                                  margin: EdgeInsets.all(20),
                                                  child: FlatButton(
                                                    child: Text('Vazgeç'),
                                                    color: Colors.white,
                                                    textColor: Colors.black,
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  height: 45,
                                                  margin: EdgeInsets.all(20),
                                                  child: FlatButton(
                                                    child: Text('Kaydet'),
                                                    color: Colors.grey.shade700,
                                                    textColor: Colors.white,
                                                    onPressed: () {
                                                      //kaydet işlemi yapp
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(height: 20, color: Colors.black),
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
                                                          "Barkod Numarası",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
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
                                            Row(
                                              children: [
                                                Container(
                                                  height: 45,
                                                  margin: EdgeInsets.all(20),
                                                  child: FlatButton(
                                                    child: Text(''),
                                                    color: Colors.white,
                                                    textColor: Colors.white,
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                Container(
                                                  height: 45,
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
                                                        child: Text(
                                                          "Kategorisi",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  ],
                                                ))),
                                            Expanded(
                                                flex: 1,
                                                child: Chip(
                                                  label: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child:
                                                          Text("Kategorisiz")),
                                                )),
                                            Expanded(flex: 3, child: Text("")),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 45,
                                                  margin: EdgeInsets.all(20),
                                                  child: FlatButton(
                                                    child: Text(''),
                                                    color: Colors.white,
                                                    textColor: Colors.white,
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                Container(
                                                  height: 45,
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
                                                        child: Text(
                                                          "Alış/Satış Birimi",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  ],
                                                ))),
                                            Expanded(
                                                flex: 4,
                                                child: DropdownButton<String>(
                                                  value: dropstr,
                                                  items: <String>[
                                                    'Adet',
                                                    'Kilogram',
                                                    'Litre',
                                                  ].map((String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  onChanged: (v) {
                                                    dropstr = v;
                                                  },
                                                )),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 45,
                                                  margin: EdgeInsets.all(20),
                                                  child: FlatButton(
                                                    child: Text(''),
                                                    color: Colors.white,
                                                    textColor: Colors.white,
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                Container(
                                                  height: 45,
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
                                                        child: Text(
                                                          "Stok Takibi",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  ],
                                                ))),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  //     height: ,
                                                  child: CheckboxListTile(
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    title: Text('YAPILSIN'),
                                                    value: true,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        //     _checkboxListTile = !_checkboxListTile;
                                                      });
                                                    },
                                                  )),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black)),
                                                  //   height: ,
                                                  child: CheckboxListTile(
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    title: Text('YAPILMASIN'),
                                                    value: false,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        //     _checkboxListTile = !_checkboxListTile;
                                                      });
                                                    },
                                                  )),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 45,
                                                  margin: EdgeInsets.all(20),
                                                  child: FlatButton(
                                                    child: Text(''),
                                                    color: Colors.white,
                                                    textColor: Colors.white,
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                Container(
                                                  height: 45,
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
                                                        child: Text(
                                                          "Başlangıç Stok Miktarı",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  ],
                                                ))),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                height: 45,
                                                child: TextFormField(
                                                  initialValue: "0,0",
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
                                                    child: Text(''),
                                                    color: Colors.white,
                                                    textColor: Colors.white,
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                Container(
                                                  height: 45,
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
                                                        child: Text(
                                                          "Kritik Stok Uyarısı",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
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
                                                    title: Text('Etkinleştir'),
                                                    value: true,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        //     _checkboxListTile = !_checkboxListTile;
                                                      });
                                                    },
                                                  )),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 45,
                                                  margin: EdgeInsets.all(20),
                                                  child: FlatButton(
                                                    child: Text(''),
                                                    color: Colors.white,
                                                    textColor: Colors.white,
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                Container(
                                                  height: 45,
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
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            //        Expanded(  flex: 1,child: Icon(Icons.bar_chart_outlined)),
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
                                                          "Kritik Stok Seviyesi",
                                                        ),
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
                                            Row(
                                              children: [
                                                Container(
                                                  height: 45,
                                                  margin: EdgeInsets.all(20),
                                                  child: FlatButton(
                                                    child: Text(''),
                                                    color: Colors.white,
                                                    textColor: Colors.white,
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                Container(
                                                  height: 45,
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
                                                      fontSize: 14,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                )),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 45,
                                                  margin: EdgeInsets.all(20),
                                                  child: FlatButton(
                                                    child: Text(''),
                                                    color: Colors.white,
                                                    textColor: Colors.white,
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                Container(
                                                  height: 45,
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
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.black,
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
                                                          "Vergiler Hariç Alış Fiyatı",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  ],
                                                ))),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                height: 45,
                                                child: TextFormField(
                                                  initialValue: "0,0",
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
                                                    child: Text(''),
                                                    color: Colors.white,
                                                    textColor: Colors.white,
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                Container(
                                                  height: 45,
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
                                                        child: Text(
                                                          "Vergiler Hariç Satış Fiyatı",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  ],
                                                ))),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                height: 45,
                                                child: TextFormField(
                                                  initialValue: "0,0",
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
                                                    child: Text(''),
                                                    color: Colors.white,
                                                    textColor: Colors.white,
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                Container(
                                                  height: 45,
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
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.black,
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
                                                          "KDV",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  ],
                                                ))),
                                            Expanded(
                                                flex: 4,
                                                child: DropdownButton<String>(
                                                  value: strkd,
                                                  items: <String>[
                                                    '%18',
                                                    '%8',
                                                    '%1',
                                                  ].map((String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  onChanged: (_) {
                                                    strkd = _;
                                                  },
                                                )),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 45,
                                                  margin: EdgeInsets.all(20),
                                                  child: FlatButton(
                                                    child: Text(''),
                                                    color: Colors.white,
                                                    textColor: Colors.white,
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                Container(
                                                  height: 45,
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
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.black,
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
                                                          "Vergiler Dahil Alış Fiyatı",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  ],
                                                ))),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                height: 45,
                                                child: TextFormField(
                                                  initialValue: "0,0",
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
                                                    child: Text(''),
                                                    color: Colors.white,
                                                    textColor: Colors.white,
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                Container(
                                                  height: 45,
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
                                                        child: Text(
                                                          "Vergiler Dahil Satış Fiyatı",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  ],
                                                ))),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                height: 45,
                                                child: TextFormField(
                                                  initialValue: "0,0",
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
                                                    child: Text(''),
                                                    color: Colors.white,
                                                    textColor: Colors.white,
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                Container(
                                                  height: 45,
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
