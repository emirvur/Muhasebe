import 'package:Muhasebe/controller/tedarliscontroller.dart';
import 'package:Muhasebe/models/dtocarilist.dart';

import 'package:Muhasebe/services/apiservices.dart';

import 'package:Muhasebe/screen/tedardetay.dart';
import 'package:Muhasebe/screen/yenitedarikci.dart';

import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/load.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Tedarikcili extends StatefulWidget {
  @override
  _TedarikciliState createState() => _TedarikciliState();
}

class _TedarikciliState extends State<Tedarikcili>
    with AutomaticKeepAliveClientMixin {
  String selectedfilt = "test";
  List<String> lstr = ["Bakiye(Azdan çoğa)", "Bakiye(Çoktan aza)"];
  List<Dtocarilist> lis = [];
  bool _isloading = true;
  String dropdownValue = 'Filtrele';
  TextEditingController contara;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contara = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    contara.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Row(
          children: [
            Container(
                color: Colors.black87,
                width: wsize.width / 5,
                //    height: 500,
                child: Wdgdrawer()),
            Expanded(
              child: Column(
                children: [
                  Wdgappbar("Tedarikçiler", "", ""),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.black)),
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.filter_1),
                              //  iconSize: 24,
                              /*     elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),*/
                              onChanged: (String newValue) {
                                if (newValue == "Bakiye(Azdan çoğa)") {
                                  Get.find<Tedarliscontroller>()
                                      .sirafiltre(2)
                                      .then((value) {
                                    APIServices.tedaralac().then((value) {
                                      setState(() {
                                        dropdownValue = newValue;
                                        lis = value;
                                        _isloading = false;
                                      });
                                    });
                                  });
                                } else if (newValue == 'Bakiye(Çoktan aza)') {
                                  Get.find<Tedarliscontroller>()
                                      .sirafiltre(2)
                                      .then((value) {
                                    APIServices.tedaralca().then((value) {
                                      setState(() {
                                        dropdownValue = newValue;
                                        lis = value;
                                        _isloading = false;
                                      });
                                    });
                                  });
                                }
                              },
                              items: <String>[
                                'Filtrele',

                                "Bakiye(Azdan çoğa)",
                                "Bakiye(Çoktan aza)"
                                //  'Four'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.grey.shade100,
                            height: 45,
                            child: TextField(
                              controller: contara,
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                    onTap: () async {
                                      if (contara.text.isEmpty) {
                                        return;
                                      }
                                      if (Get.find<Tedarliscontroller>().sira ==
                                          0) {
                                        setState(() {
                                          print("ilk setstateee");
                                          _isloading = true;
                                        });
                                        var value = await APIServices.tedara(
                                            contara.text);
                                        List<Dtocarilist> l = [];
                                        for (var i in value) {
                                          l.add(Dtocarilist(i.cariId,
                                              i.cariunvani, "", i.bakiye));
                                        }
                                        lis = l;

                                        Get.find<Tedarliscontroller>()
                                            .siradegistir(1)
                                            .then((value) {
                                          setState(() {
                                            print("ikibci setstatte");
                                            _isloading = false;
                                          });
                                        });
                                      } else {
                                        Get.find<Tedarliscontroller>()
                                            .siradegistir(0)
                                            .then((value) {
                                          setState(() {
                                            dropdownValue = "Filtrele";
                                            contara.text = "";
                                            print("ikibci setstatte");
                                            _isloading = false;
                                          });
                                        });
                                      }
                                    },
                                    child: Icon(
                                      Get.find<Tedarliscontroller>().sira == 0
                                          ? FontAwesomeIcons.search
                                          : Get.find<Tedarliscontroller>()
                                                      .sira ==
                                                  1
                                              ? Icons.close
                                              : Icons.search,
                                    )),
                                border: OutlineInputBorder(),
                                labelText: 'Ara...',
                                hintText: 'Ara...',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 45,
                          margin: EdgeInsets.all(20),
                          child: FlatButton(
                            child: Text('Yeni Tedarikçi Oluştur'),
                            color: Colors.grey.shade700,
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Yenited()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: wsize.width,
                      child: Obx(() {
                        if (Get.find<Tedarliscontroller>().isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return DataTable(
                            showCheckboxColumn: false,
                            //       columnSpacing: 300,
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => Colors.grey.shade200),
                            columns: <DataColumn>[
                              /*   DataColumn(
                                label:
                                    Checkbox(value: false, onChanged: (b) {}),
                              ),*/
                              DataColumn(
                                label: Text(
                                  'Unvanı',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Bakiye',
                                  //     style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                            rows: Get.find<Tedarliscontroller>().sira != 0
                                ? lis
                                    .map((e) => DataRow(
                                            onSelectChanged: (bool b) {
                                              if (b) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Tedardetay(e)),
                                                );
                                              }
                                            },
                                            color:
                                                MaterialStateColor.resolveWith(
                                                    (states) => Colors.white),
                                            cells: [
                                              /*     DataCell(Checkbox(
                                            value: true,
                                            onChanged: (b) {},
                                          )),*/
                                              DataCell(InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Tedardetay(e)),
                                                    );
                                                  },
                                                  child: Text(e.cariunvani
                                                      .toString()))),
                                              DataCell(Text(
                                                Load.numfor.format(e.bakiye),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ]))
                                    .toList()
                                : Get.find<Tedarliscontroller>()
                                    .listdtofatta
                                    .map((e) => DataRow(
                                            onSelectChanged: (bool b) {
                                              if (b) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Tedardetay(e)),
                                                );
                                              }
                                            },
                                            color:
                                                MaterialStateColor.resolveWith(
                                                    (states) => Colors.white),
                                            cells: [
                                              /*     DataCell(Checkbox(
                                            value: true,
                                            onChanged: (b) {},
                                          )),*/
                                              DataCell(InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Tedardetay(e)),
                                                    );
                                                  },
                                                  child: Text(e.cariunvani
                                                      .toString()))),
                                              DataCell(Text(
                                                Load.numfor.format(e.bakiye),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ]))
                                    .toList());
                      }))
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
