import 'package:flutter/material.dart';

class UrunlerUi extends StatefulWidget {
  @override
  _UrunlerUiState createState() => _UrunlerUiState();
}

class _UrunlerUiState extends State<UrunlerUi>
    with AutomaticKeepAliveClientMixin {
  Item selectedUser;
  List<Item> users = <Item>[
    const Item(
        'Android',
        Icon(
          Icons.android,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Flutter',
        Icon(
          Icons.flag,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'ReactNative',
        Icon(
          Icons.format_indent_decrease,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'iOS',
        Icon(
          Icons.mobile_screen_share,
          color: const Color(0xFF167F67),
        )),
  ];
  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text(
                          "Hizmet ve Ürünler",
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
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent)),
                          child: DropdownButton<Item>(
                            hint: Row(
                              children: [
                                Icon(Icons.filter_1),
                                Text("Filtrele"),
                              ],
                            ),
                            value: selectedUser,
                            onChanged: (Item Value) {
                              setState(() {
                                selectedUser = Value;
                              });
                            },
                            items: users.map((Item user) {
                              return DropdownMenuItem<Item>(
                                value: user,
                                child: Row(
                                  children: <Widget>[
                                    user.icon,
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      user.name,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Container(
                            height: 45,
                            child: TextField(
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(),
                                labelText: 'Ara',
                                hintText: 'Ara',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 45,
                          margin: EdgeInsets.all(20),
                          child: FlatButton(
                            child: Text('Ürün Ekle'),
                            color: Colors.blueAccent,
                            textColor: Colors.white,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: wsize,
                    child: DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'Adı',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Stok Miktarı',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Alış(Vergiler Hariç)',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Satış(Vergiler Hariç)',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                      rows: const <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Sarah')),
                            DataCell(Text('19')),
                            DataCell(Text('Student')),
                            DataCell(Text('Student')),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Janine')),
                            DataCell(Text('43')),
                            DataCell(Text('Professor')),
                            DataCell(Text('Student')),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('William')),
                            DataCell(Text('27')),
                            DataCell(Text('Associate Professor')),
                            DataCell(Text('Student')),
                          ],
                        ),
                      ],
                    ),
                  )
                  /*   Container(
                    margin: EdgeInsets.all(10),
                    child: Table(
                      border: TableBorder.symmetric(
                          inside: BorderSide(width: 2, color: Colors.blue),
                          outside: BorderSide(width: 2)),
                      columnWidths: {
                        0: FlexColumnWidth(15),
                        1: FlexColumnWidth(5)
                      },
                      children: [
                        TableRow(children: [
                          Container(
                            height: 20,
                            child: Text('Sport',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            height: 20,
                            child: Text('Total Players',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ]),
                        TableRow(children: [
                          Container(
                              height: 35,
                              child:
                                  Text('Soccer', textAlign: TextAlign.center)),
                          Container(
                              height: 35,
                              child: Text('11', textAlign: TextAlign.center)),
                        ]),
                        TableRow(children: [
                          Text('Soccer', textAlign: TextAlign.center),
                          Text('11', textAlign: TextAlign.center),
                        ]),
                        TableRow(children: [
                          Text('Soccer', textAlign: TextAlign.center),
                          Text('11', textAlign: TextAlign.center),
                        ]),
                      ],
                    ),
                  ),*/
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}
