import 'package:Muhasebe/models/dtofattahs.dart';
import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/dtourungecmisi.dart';
import 'package:Muhasebe/models/urun.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/ui/satisfaticinurun.dart';
import 'package:Muhasebe/ui/urunler_ui.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ProdDetailui extends StatefulWidget {
  final Dtourun ur;
  ProdDetailui(this.ur);
  @override
  _ProdDetailuiState createState() => _ProdDetailuiState();
}

class _ProdDetailuiState extends State<ProdDetailui>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  TabController _tabController;
  bool _isloading = true;
  List<Dtourungecmisi> lis = [];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
    APIServices.urungecmisial(widget.ur.barkodno).then((value) {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          lis = value;
          _isloading = false;
        });
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey.shade300,
          //       Color.fromRGBO(220, 221, 220, 1),
          body: LoadingOverlay(
            isLoading: _isloading,
            opacity: 0,
            progressIndicator: Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 50,
                  ),
                  Text("Yükleniyor...")
                ],
              ),
            ),
            child: Row(
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
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 24),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "Hizmet ve Ürün",
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
                                    //    fontWeight: FontWeight.bold
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
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
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
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border: Border.all(width: 1)),
                                          height: 45,
                                          margin: EdgeInsets.all(20),
                                          child: FlatButton(
                                            child: Text('Diğer'),
                                            color: Colors.white,
                                            textColor: Colors.grey,
                                            onPressed: () {},
                                          ),
                                        ),
                                        Container(
                                          height: 45,
                                          margin: EdgeInsets.all(20),
                                          child: FlatButton(
                                            child: Text('Düzenle'),
                                            color: Colors.grey.shade700,
                                            textColor: Colors.white,
                                            onPressed: () {},
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
                                          Icon(Icons.select_all),
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
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                    text: widget.ur.verharal
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: wsize / 30,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.select_all),
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
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                    text: widget.ur.verharsat
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: wsize / 30,
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
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                    text: widget.ur.kdv
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: wsize / 30,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.select_all),
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
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                    text: widget.ur.adet
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      /*      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.radio),
                                              Text(
                                                  widget.ur.barkodno.toString())
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.radio),
                                              Text("1")
                                            ],
                                          )
                                        ],
                                      )*/
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.work_outlined,
                                            color: Colors.grey,
                                          ),
                                          Text(widget.ur.barkodno.toString())
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100),
                                    //  height: 60,
                                    width: wsize / 2,
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
                                        Container(
                                          width: 35.0,
                                          child: Text(
                                            'Satışlar',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: 35.0,
                                          child: Text(
                                            'Alışlar',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        )
                                      ],
                                      unselectedLabelColor: Colors
                                          .grey, //   const Color(0xffacb3bf),
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
                                  height: 200,
                                  child: TabBarView(
                                      controller: _tabController,
                                      children: <Widget>[
                                        Container(
                                            width: wsize,
                                            child: DataTable(
                                                headingRowColor:
                                                    MaterialStateColor
                                                        .resolveWith((states) =>
                                                            Colors
                                                                .grey.shade200),
                                                columns: const <DataColumn>[
                                                  DataColumn(
                                                    label: Text(
                                                      'İşlem Türü',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      'Müşteri/Tedarikçi',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      'İşlem Tarihi',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    ),
                                                  ),
                                                  DataColumn(
                                                    label: Text(
                                                      'Miktar',
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    ),
                                                  ),
                                                ],
                                                rows: lis
                                                    .map((e) => DataRow(cells: [
                                                          DataCell(InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          SatisfatDetailicinurun(
                                                                              e.fatid)),
                                                                );
                                                              },
                                                              child: Text(e
                                                                  .fattur
                                                                  .toString()))),
                                                          DataCell(Text(
                                                            e.cariad.toString(),
                                                            style: TextStyle(),
                                                          )),
                                                          DataCell(Text(
                                                            e.duzenlemetarih
                                                                .toString(),
                                                            style: TextStyle(),
                                                          )),
                                                          DataCell(Text(
                                                            e.miktar.toString(),
                                                            style: TextStyle(),
                                                          )),
                                                        ]))
                                                    .toList())),
                                        Container(
                                          child: Text("sign up"),
                                        ),
                                        Container(
                                          child: Text("login"),
                                        ),
                                      ]),
                                )
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
