import 'package:Muhasebe/controller/kasacontroller.dart';
import 'package:Muhasebe/models/kasa.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/load.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgfakebutton.dart';
import 'package:Muhasebe/utils/wdgloadingalert.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:intl/intl.dart';

class Yenikasa extends StatefulWidget {
  @override
  _YenikasaState createState() => _YenikasaState();
}

class _YenikasaState extends State<Yenikasa> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController conthes;
  TextEditingController contbak;
  bool _isLoading = false;
  String hes;
  int bak;

  DateTime pickedDate;
  DateTime pickedduztar;

  _pickDate() async {
    DateTime date = await showDatePicker(
      locale: Locale("tr"),
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
    );
    if (date != null)
      setState(() {
        pickedDate = date;
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    conthes = TextEditingController();
    contbak = TextEditingController();
    pickedDate = DateTime.now();
  }

  @override
  void dispose() {
    conthes.dispose();
    contbak.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState.validate()) {
      try {
        _formKey.currentState.save();

        setState(() {
          _isLoading = true;
        });

        // Simulate a service call
        await Future.delayed(Duration(seconds: 3));
        setState(() {
          Kasa kas = Kasa(0, conthes.text, bak);
          APIServices.kasaekle(kas).then((value) {
            print(value.toString());
          });
          Get.find<KasaController>().eklekasa(kas);
          _isLoading = false;
        });
        //  Kasa k = Kasa();
        Navigator.of(context).pop();
        Load.showtoast("Başarı ile oluşturuldu");
      } catch (e) {
        Load.showtoast("Bir hata oluştu");
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          /*appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.grey.shade300,
              title: Wdgappbar("Kasa ve Bankalar >", "Yeni Kasa", "Ahmet Seç")),
          drawer: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors
                  .black87, //This will change the drawer background to blue.
              //other styles
            ),
            child: Drawer(child: Wdgdrawer()),
          ),*/
          backgroundColor: Colors.grey.shade300,
          body: LoadingOverlay(
            isLoading: _isLoading,
            progressIndicator: Wdgloadingalert(wsize: wsize),
            child: Row(
              children: [
                Container(
                    color: Colors.black87,
                    width: wsize.width / 5,
                    //    height: 500,
                    child: Wdgdrawer()),
                Expanded(
                  child: Scrollbar(
                    isAlwaysShown: true,
                    child: SingleChildScrollView(
                      //    child: Expanded(
                      child: Column(children: [
                        //      Wdgappbar("wwww", "gggg", "qqqsw"),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                //    color: Colors.white,
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
                                                          child: Icon(
                                                              Icons.money)),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            "Hesap İsmi*",
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
                                                  // width: 75,
                                                  child: TextFormField(
                                                    controller: conthes,
                                                    decoration:
                                                        const InputDecoration(
                                                            border:
                                                                OutlineInputBorder()),
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return "Hesap ismi boş olamaz";
                                                      }
                                                      return null;
                                                      // validation logic
                                                    },
                                                    onSaved: (v) {
                                                      hes = v;
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        border: Border.all()),
                                                    height: 45,
                                                    margin: EdgeInsets.all(10),
                                                    child: FlatButton(
                                                      child: Text('Vazgeç'),
                                                      color: Colors.white,
                                                      textColor: Colors.grey,
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        border: Border.all()),
                                                    height: 45,
                                                    margin: EdgeInsets.all(10),
                                                    child: FlatButton(
                                                      child: Text('Kaydet'),
                                                      color: Colors.grey,
                                                      textColor: Colors.white,
                                                      onPressed: () async {
                                                        print("uuu");
                                                        _submit();
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
                                                              .attach_money)),
                                                      Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            "Açılış Bakiyesi",
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
                                                  //    width: 65,
                                                  child: TextFormField(
                                                    controller: contbak,
                                                    decoration:
                                                        const InputDecoration(
                                                            border:
                                                                OutlineInputBorder()),
                                                    validator: (value) {
                                                      int h =
                                                          int.tryParse(value);
                                                      if (h == null) {
                                                        return "Lütfen sayı giriniz";
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (v) {
                                                      int h = int.tryParse(v);
                                                      bak = h;
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Wdgfakebutton()
                                              //    Spacer()
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
                                                            "Açılış Bakiyesi Tarihi",
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
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      ListTile(
                                                        title: Text(DateFormat
                                                                .yMMMd('tr_TR')
                                                            .format(
                                                                pickedDate)),
                                                        //  " ${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day}"),
                                                        trailing: Icon(Icons
                                                            .calendar_today),
                                                        onTap: _pickDate,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Wdgfakebutton()
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ])))
                      ]),
                      //  ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
