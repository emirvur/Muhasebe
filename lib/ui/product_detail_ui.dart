import 'package:Muhasebe/ui/satisfat_detay_ui.dart';
import 'package:Muhasebe/ui/urunler_ui.dart';
import 'package:flutter/material.dart';

class ProdDetailui extends StatefulWidget {
  @override
  _ProdDetailuiState createState() => _ProdDetailuiState();
}

class _ProdDetailuiState extends State<ProdDetailui>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
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
          backgroundColor:
              Color.fromRGBO(220, 221, 220, 1), //Colors.grey.shade200,
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
                              "Hizmet ve Ürünler > Hizmet/Ürün",
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
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(24),
                                    child: Icon(Icons.edit_attributes),
                                  ),
                                  Text("ASUS Laptop"),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Chip(
                                        label: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text("Kategorisiz")),
                                      ),
                                      Container(
                                        height: 45,
                                        margin: EdgeInsets.all(20),
                                        child: FlatButton(
                                          child: Text('Sil'),
                                          color: Colors.grey,
                                          textColor: Colors.white,
                                          onPressed: () {},
                                        ),
                                      ),
                                      Container(
                                        height: 45,
                                        margin: EdgeInsets.all(20),
                                        child: FlatButton(
                                          child: Text('Düzenle'),
                                          color: Colors.blueAccent,
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
                                              color: Colors.black,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: '  ',
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text: '3000,00 TL',
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
                                              color: Colors.black,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: '  ',
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text: '2500,00 TL',
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
                                              color: Colors.black,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: '  ',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text: '18',
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
                                              color: Colors.black,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: '  ',
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text: '22',
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
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.radio),
                                            Text("1")
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.radio),
                                            Text("1")
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Divider(),
                              Container(
                                decoration:
                                    BoxDecoration(color: Colors.amberAccent),
                                height: 60,
                                //   width: wsize / 2,
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
                                  unselectedLabelColor: const Color(0xffacb3bf),
                                  indicatorColor: Color(0xFFffac81),
                                  labelColor: Colors.black,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicatorWeight: 3.0,
                                  indicatorPadding: EdgeInsets.all(10),
                                  isScrollable: false,
                                  controller: _tabController,
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
                                          rows: <DataRow>[
                                            DataRow(
                                              cells: <DataCell>[
                                                DataCell(
                                                    Text(
                                                        'Başlangıç Stok Miktarı'),
                                                    onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SatisfatDetailui()),
                                                  );
                                                }),
                                                DataCell(Text('-')),
                                                DataCell(Text('12 Nisan 2020')),
                                                DataCell(Text('5 Adet')),
                                              ],
                                            ),
                                            DataRow(
                                              cells: <DataCell>[
                                                DataCell(Text('Stok Çıkışı')),
                                                DataCell(Text('Bute')),
                                                DataCell(Text('18 Mart 2021')),
                                                DataCell(Text('2 Adet')),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
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
          )),
    );
  }
}
