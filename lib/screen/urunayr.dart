import 'package:Muhasebe/models/dtostokdetay.dart';
import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/dtourungecmisi.dart';

import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/screen/alfatdetayicin.dart';
import 'package:Muhasebe/screen/satisfaticinurun.dart';

import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/load.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgloadingalert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Urunayr extends StatefulWidget {
  final Dtourun ur;
  Urunayr(this.ur);
  @override
  _UrunayrState createState() => _UrunayrState();
}

class _UrunayrState extends State<Urunayr> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  TabController _tabController;
  bool _isloading = true;
  List<Dtourungecmisi> lis = [];
  List<Dtostokdetay> satlist = [];
  List<Dtostokdetay> allist = [];
  bool fatmi = false;
  bool istabload = false;
  GlobalKey _toolTipKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    APIServices.urungecmisial(widget.ur.barkodno).then((value) {
      setState(() {
        lis = value;
        _isloading = false;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        if (_tabController.index == 0) {
          print("1de");
        } else if (_tabController.index == 1) {
          setState(() {
            _isloading = true;
          });
          APIServices.stokdetayfatsatis(widget.ur.barkodno).then((value) {
            satlist = value;
            setState(() {
              _isloading = false;
              print("tekarra");
            });
          });
        } else {
          print("e3rrr");
          setState(() {
            _isloading = true;
          });
          APIServices.stokdetayfatalis(widget.ur.barkodno).then((value) {
            allist = value;
            setState(() {
              _isloading = false;
              print("tekarra");
            });
          });
        }
        print("setstewf");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.grey[200], //fromRGBO(52, 213, 235, 1),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(200),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Wdgappbar("Hizmet ve Ürünler >", "Hizmet/Ürün", ""),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    //   color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            /*   CircleAvatar(
                                      backgroundColor: Color(24),
                                      child: Icon(Icons.edit_attributes),
                                    ),*/
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                widget.ur.adi,
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Chip(
                                  label: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(widget.ur.katad)),
                                ),
                                /* Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(width: 1)),
                                  height: 45,
                                  margin: EdgeInsets.all(20),
                                  child: FlatButton(
                                    child: Text('Diğer'),
                                    color: Colors.white,
                                    textColor: Colors.grey,
                                    onPressed: () {},
                                  ),
                                ),*/
                                Container(
                                  height: 45,
                                  margin: EdgeInsets.all(20),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Tooltip(
                                      key: _toolTipKey,
                                      message: "Pek yakında",
                                      child: FlatButton(
                                        child: Text('Düzenle'),
                                        color: Colors.grey.shade700,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          final dynamic _toolTip =
                                              _toolTipKey.currentState;
                                          _toolTip.ensureTooltipVisible();
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  //   Icon(Icons.select_all),
                                  RichText(
                                    text: TextSpan(
                                      text: 'SATIŞ',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: '  ',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text: widget.ur.verharal.toString(),
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: wsize.width / 30,
                              ),
                              Row(
                                children: [
                                  //   Icon(Icons.select_all),
                                  RichText(
                                    text: TextSpan(
                                      text: 'ALIŞ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: '  ',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                widget.ur.verharsat.toString(),
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: wsize.width / 30,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.select_all),
                                  RichText(
                                    text: TextSpan(
                                      text: 'KDV',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: '  ',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text: widget.ur.kdv.toString(),
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: wsize.width / 30,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.thList,
                                    size: 18,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'ADET',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: '  ',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text: widget.ur.adet.toString(),
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.barcode,
                                    color: Colors.grey,
                                    size: 18,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(widget.ur.barkodno.toString()),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            decoration:
                                BoxDecoration(color: Colors.grey.shade100),
                            //  height: 60,
                            width: wsize.width / 2,
                            child: TabBar(
                              // isScrollable: true,
                              unselectedLabelColor: Colors.red, //grey[300],
                              //         labelStyle: TextStyle(fontSize: 18.0),
                              labelColor: Colors.orange, //white,
                              controller: _tabController,
                              indicator: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                      color:
                                          Colors.grey), // provides to left side
                                  right: BorderSide(
                                      color: Colors.grey), // for right side
                                ),
                              ),
                              /* UnderlineTabIndicator(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                                insets:
                                    EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
                              ),*/
                              tabs: <Widget>[
                                Container(
                                  width: wsize.width / 3,
                                  child: Tab(
                                    text: "TÜMÜ",
                                  ),
                                ),
                                Container(
                                  width: wsize.width / 3,
                                  child: Tab(
                                    text: "SATIŞLAR",
                                  ),
                                ),
                                Container(
                                  width: wsize.width / 3,
                                  child: Tab(
                                    text: "ALIŞLAR",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ]),
            )),
        body: _isloading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                color: Colors.white, //grey[200],
                child: Column(
                  children: [
                    //   Align(alignment: Alignment.centerLeft, child: Text("Nisan 2021")),
                    Expanded(
                      // child: Container(
                      //     color: Colors.grey[300],
                      child: TabBarView(
                          //  physics: NeverScrollableScrollPhysics(),

                          controller: _tabController,
                          children: <Widget>[
                            SingleChildScrollView(
                              physics: ScrollPhysics(),
                              child: Container(
                                  width: wsize.width,
                                  child: DataTable(
                                      headingRowColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Colors.grey.shade200),
                                      columns: const <DataColumn>[
                                        DataColumn(
                                          label: Text(
                                            'İşlem Türü',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Müşteri/Tedarikçi',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'İşlem Tarihi',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Miktar',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                      ],
                                      rows: lis
                                          .map((e) => DataRow(cells: [
                                                DataCell(InkWell(
                                                    /*  onTap: () {
                                                e.fattur == "Stok Çıkış"
                                                    ? Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Satfatdetailicinurun(
                                                                    e.fatid)),
                                                      )
                                                    : Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Alfatdetailicinurun(
                                                                    e.fatid)),
                                                      );
                                              },*/
                                                    child: Text(
                                                        e.fattur.toString()))),
                                                DataCell(Text(
                                                  e.cariad.toString(),
                                                  style: TextStyle(),
                                                )),
                                                DataCell(Text(
                                                  e.duzenlemetarih,
                                                  //     .substring(0, 9),
                                                  style: TextStyle(),
                                                )),
                                                DataCell(Text(
                                                  e.miktar.toString(),
                                                  style: TextStyle(),
                                                )),
                                              ]))
                                          .toList())),
                            ),
                            SingleChildScrollView(
                              physics: ScrollPhysics(),
                              child: Container(
                                child: Container(
                                    width: wsize.width,
                                    child: DataTable(
                                        headingRowColor:
                                            MaterialStateColor.resolveWith(
                                                (states) =>
                                                    Colors.grey.shade200),
                                        columns: const <DataColumn>[
                                          DataColumn(
                                            label: Text(
                                              'Geçmiş İşlemler',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Müşteri',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'İşlem Tarihi',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Miktar',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Br. Fiyat',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Toplam Fiyat',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                        rows: satlist
                                            .map((e) => DataRow(cells: [
                                                  DataCell(InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Satfatdetailicinurun(
                                                                      e.fatid)),
                                                        );
                                                      },
                                                      child: Text(e.fatacik
                                                          .toString()))),
                                                  DataCell(Text(
                                                    e.ad.toString(),
                                                    style: TextStyle(),
                                                  )),
                                                  DataCell(Text(
                                                    e.duzt.substring(0, 10),
                                                    style: TextStyle(),
                                                  )),
                                                  DataCell(Text(
                                                    e.miktar.toString(),
                                                    style: TextStyle(),
                                                  )),
                                                  DataCell(Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        Load.numfor
                                                            .format(e.brfiyat),
                                                        style: TextStyle(),
                                                      ),
                                                      Icon(
                                                          FontAwesomeIcons
                                                              .liraSign,
                                                          size: 12),
                                                    ],
                                                  )),
                                                  DataCell(Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        Load.numfor.format(
                                                            e.miktar *
                                                                e.brfiyat),
                                                        style: TextStyle(),
                                                      ),
                                                      Icon(
                                                          FontAwesomeIcons
                                                              .liraSign,
                                                          size: 12),
                                                    ],
                                                  )),
                                                ]))
                                            .toList())),
                              ),
                            ),
                            SingleChildScrollView(
                              physics: ScrollPhysics(),
                              child: Container(
                                child: Container(
                                    width: wsize.width,
                                    child: DataTable(
                                        headingRowColor:
                                            MaterialStateColor.resolveWith(
                                                (states) =>
                                                    Colors.grey.shade200),
                                        columns: const <DataColumn>[
                                          DataColumn(
                                            label: Text(
                                              'İşlem Türü',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Tedarikçi',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'İşlem Tarihi',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Miktar',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Br. Fiyat',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Toplam Fiyat',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                        rows: allist
                                            .map((e) => DataRow(cells: [
                                                  DataCell(InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Alfatdetailicinurun(
                                                                      e.fatid)),
                                                        );
                                                      },
                                                      child: Text(e.fatacik
                                                          .toString()))),
                                                  DataCell(Text(
                                                    e.ad.toString(),
                                                    style: TextStyle(),
                                                  )),
                                                  DataCell(Text(
                                                    e.duzt.toString(),
                                                    style: TextStyle(),
                                                  )),
                                                  DataCell(Text(
                                                    e.miktar.toString(),
                                                    style: TextStyle(),
                                                  )),
                                                  DataCell(Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        Load.numfor
                                                            .format(e.brfiyat),
                                                        style: TextStyle(),
                                                      ),
                                                      Icon(
                                                          FontAwesomeIcons
                                                              .liraSign,
                                                          size: 12),
                                                    ],
                                                  )),
                                                  DataCell(Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        Load.numfor.format(
                                                            e.miktar *
                                                                e.brfiyat),
                                                        style: TextStyle(),
                                                      ),
                                                      Icon(
                                                          FontAwesomeIcons
                                                              .liraSign,
                                                          size: 12),
                                                    ],
                                                  )),
                                                ]))
                                            .toList())),
                              ),
                            ),
                          ]),
                      //    ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
