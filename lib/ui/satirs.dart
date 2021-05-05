import 'package:Muhasebe/models/dtofattahs.dart';
import 'package:Muhasebe/models/dtoirsaliye.dart';
import 'package:Muhasebe/models/dtoirsurunhar.dart';
import 'package:Muhasebe/models/dtotahsharfat.dart';
import 'package:Muhasebe/models/dtourungecmisi.dart';
import 'package:Muhasebe/models/dtourunhareket.dart';
import 'package:Muhasebe/models/kasa.dart';
import 'package:Muhasebe/models/tahsput.dart';
import 'package:Muhasebe/models/urunhareket.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/ui/urunler_ui.dart';
import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/createExcel.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgfakebutton.dart';
import 'package:Muhasebe/utils/wdgloadingalert.dart';

import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../utils/createpdf.dart';

class Satirs extends StatefulWidget {
  final Dtoirsaliye dt;
  Satirs(this.dt);
  @override
  _SatirsState createState() => _SatirsState();
}

class _SatirsState extends State<Satirs> {
  final _formKey = GlobalKey<FormState>();
  List<Dtoirsurunhar> lis = [];
  List<Dtotahsharfat> ltah = [];
  bool _isloading = true;
  bool tahsilform = false;
  DateTime selectedDate = DateTime.now();
  TextEditingController contar;
  List<Kasa> kasalist = [];
  Kasa kas = Kasa(1, "", 1);
  String acikla = "";
  num deger;
  TextEditingController conacik;
  TextEditingController condeg;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contar = TextEditingController();
    conacik = TextEditingController();
    condeg = TextEditingController();
    //  APIServices.detayirsal(widget.dt.irsid).then((value) => ltah = value);
    /*APIServices.kasalistal().then((value) {
      kasalist = value;
      kas = kasalist[0];
    });*/
    APIServices.detayirsal(widget.dt.irsid).then((value) {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          lis = value;
          _isloading = false;
        });
      });
    });
  }

/*  @override
  Widget _dropdownbutton(List<Kasa> userlist) {
    return Container(
      padding: EdgeInsets.all(1),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(),
        //    borderRadius: BorderRadius.all(Radius.circular(15.0) //),
      ),
      child: DropdownButton<Kasa>(
        value: kas ?? Kasa(1, "", 1),
        underline: SizedBox(),
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down),
        //  hint: Text("  $dropdownvalue"),
        // value: selectedUser[index],
        onChanged: (Kasa value) {
          kas = value;
          setState(() {});
        },
        items: userlist.map((Kasa user) {
          return DropdownMenuItem<Kasa>(
            value: user,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text(
                  user.kasaAd,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
*/
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        // contar.text =
        //       selectedDate.toString(); //DateFormat.yMd().format(selectedDate);
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    contar.dispose();
    conacik.dispose();
    condeg.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      /*  appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey.shade300,
          title:
              Wdgappbar("Irsaliye Satışları >", "Irsaliye Satış", "Ahmet Seç")),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor:
              Colors.black87, //This will change the drawer background to blue.
          //other styles
        ),
        child: Drawer(child: Wdgdrawer()),
      ),*/
      backgroundColor: Colors.grey.shade300,
      body: LoadingOverlay(
        isLoading: _isloading,
        opacity: 0.2,
        progressIndicator: Wdgloadingalert(wsize: wsize),
        child: Row(
          children: [
            Container(
                color: Colors.black87,
                width: wsize.width / 5,
                //    height: 500,
                child: Wdgdrawer()),
            Expanded(
              flex: 78,
              child: Column(
                children: [
                  Wdgappbar("wwww", "gggg", "qqqsw"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.file_copy,
                                  color: Colors.red,
                                ),
                                Text(
                                  widget.dt.aciklama,
                                  style: TextStyle(fontSize: 24),
                                ),
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey)),
                                  height: 45,
                                  margin: EdgeInsets.all(20),
                                  child: FlatButton(
                                    child: Text('Düzenle'),
                                    color: Colors.white,
                                    textColor: Colors.grey,
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          /*      Container(
                                          child: Chip(
                                            label: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(widget.dt.katad)),
                                          ),
                                        ),*/
                          /*    Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 24.0),
                                    child: Chip(
                                      label: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Center(
                                            child: Text(widget.dt.katad),
                                          )),
                                    ),
                                  )),
                              Expanded(flex: 3, child: Text("")),
                              Wdgfakebutton(),
                            ],
                          ),
                          Divider(),*/
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 24.0),
                                    child: InkWell(
                                      onTap: () {
                                        //cariye git
                                      },
                                      child: Text(
                                        widget.dt.cariad,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(children: [
                                Icon(Icons.calendar_today),
                                Text(
                                  widget.dt.tarih,
                                  style: TextStyle(fontSize: 18),
                                )
                              ]),
                              Row(
                                children: [
                                  Icon(Icons.format_list_numbered),
                                  Text(widget.dt.cariId.toString()),
                                ],
                              )
                            ],
                          ),
                          Divider(),
                          Container(
                              width: wsize.width,
                              child: DataTable(
                                  headingRowColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.grey.shade200),
                                  columns: <DataColumn>[
                                    DataColumn(
                                      label: Text(
                                        'Ürün',
                                        style: TextStyle(
                                            //fontSize: 18,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold
                                            //    fontStyle:
                                            //   FontStyle.italic
                                            ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        ' Miktarı',
                                        style: TextStyle(
                                            // fontSize: 18,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold
                                            //      fontStyle:
                                            //        FontStyle.italic
                                            ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Br. Fiyat',
                                        style: TextStyle(
                                            //   fontSize: 18,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold
                                            //fontStyle:
                                            //      FontStyle.italic
                                            ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Vergi',
                                        style: TextStyle(
                                            // fontSize: 18,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold
                                            //    fontStyle:
                                            //      FontStyle.italic
                                            ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Toplam',
                                        style: TextStyle(
                                            // fontSize: 18,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold
                                            //       fontStyle:
                                            //         FontStyle.italic
                                            ),
                                      ),
                                    ),
                                  ],
                                  rows: lis
                                      .map((e) => DataRow(cells: [
                                            DataCell(Text(
                                              e.ad,
                                              style: TextStyle(fontSize: 18),
                                            )),
                                            DataCell(Text(
                                              e.miktar.toString(),
                                              style: TextStyle(fontSize: 15),
                                            )),
                                            DataCell(Text(
                                              e.brfiyat.toString(),
                                              style: TextStyle(fontSize: 15),
                                            )),
                                            DataCell(Text(
                                              e.vergi.toString(),
                                              style: TextStyle(fontSize: 15),
                                            )),
                                            DataCell(Text(
                                              "${e.brfiyat + (e.brfiyat * e.vergi) / 100}",
                                              style: TextStyle(fontSize: 15),
                                            )),
                                          ]))
                                      .toList())),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: (2 * wsize.width) / 6,
                                height: 120,
                                color: Colors.white,
                              ),
                              Container(
                                width: (2 * wsize.width) / 6,
                                height: 120,
                                //     color: Colors.green,
                                child: Column(
                                  children: [
                                    Divider(),
                                    Row(
                                      children: [
                                        Text(
                                          "Ara Toplam",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Text(widget.dt.aratop.toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        Text("Toplam Kdv ",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                        Spacer(),
                                        Text(widget.dt.kdv.toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        Text("Genel Toplam",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                        Spacer(),
                                        Text(widget.dt.geneltop.toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      //     color: Colors.white,
                    ),
                  ),
                  /*   Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(widget.dt.duztarih.toString()),
                                    Row(children: [
                                      Icon(Icons.calendar_today),
                                      Text("Kasa Hesabı")
                                    ]),
                                    Text(
                                        "Müşteriden Tahsilat   ${widget.dt.alinmism} TL")
                                  ],
                                ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
