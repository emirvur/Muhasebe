import 'package:Muhasebe/models/dtostokdetay.dart';
import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/dtourungecmisi.dart';

import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/screen/alfatdetayicin.dart';
import 'package:Muhasebe/screen/satisfaticinurun.dart';

import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Urunayrinti extends StatefulWidget {
  final Dtourun ur;
  Urunayrinti(this.ur);
  @override
  _UrunayrintiState createState() => _UrunayrintiState();
}

class _UrunayrintiState extends State<Urunayrinti>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  TabController _tabController;
  bool _isloading = true;
  List<Dtourungecmisi> lis = [];
  List<Dtostokdetay> satlist = [];
  bool fatmi = false;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 1, vsync: this);
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
          APIServices.stokdetayfatsatis(widget.ur.barkodno).then((value) {
            satlist = value;
            setState(() {
              print("tekarra");
            });
          });
        } else {
          print("e3rrr");
          APIServices.stokdetayfatalis(widget.ur.barkodno).then((value) {
            satlist = value;
            setState(() {
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
      //       Color.fromRGBO(220, 221, 220, 1),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        //   color: Colors.white,
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(color: Colors.grey.shade100),
              //  height: 60,
              width: wsize.width / 2,
              //      margin: EdgeInsets.only(left: 60),
              child: TabBar(
                tabs: [
                  Container(
                    width: 35.0,
                    child: Text(
                      'Stok Geçmişi',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
                unselectedLabelColor: Colors.grey, //   const Color(0xffacb3bf),
                indicatorColor: Color(0xFFffac81),
                labelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3.0,
                //   indicatorPadding: EdgeInsets.all(10),
                isScrollable: false,
                controller: _tabController,
              ),
            ),
          ),
          Container(
            color: Colors.grey[200],
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(
                      // physics: NeverScrollableScrollPhysics(),
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
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Müşteri/Tedarikçi',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'İşlem Tarihi',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Miktar',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                  rows: lis
                                      .map((e) => DataRow(cells: [
                                            DataCell(InkWell(
                                                onTap: () {
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
                                                },
                                                child:
                                                    Text(e.fattur.toString()))),
                                            DataCell(Text(
                                              e.cariad.toString(),
                                              style: TextStyle(),
                                            )),
                                            DataCell(Text(
                                              e.duzenlemetarih.toString(),
                                              style: TextStyle(),
                                            )),
                                            DataCell(Text(
                                              e.miktar.toString(),
                                              style: TextStyle(),
                                            )),
                                          ]))
                                      .toList())),
                        ),
                      ]),
                  //    ),
                ),
              ],
            ),
          ),
        ]),
      ),
    ));
  }
}
