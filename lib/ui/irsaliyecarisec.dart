import 'package:Muhasebe/models/cari.dart';
import 'package:Muhasebe/models/dtoirsaliye.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/ui/satirs.dart';
import 'package:Muhasebe/utils/wdgfakebutton.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class Irsaliyecarisec extends StatefulWidget {
  @override
  _IrsaliyecarisecState createState() => _IrsaliyecarisecState();
}

class _IrsaliyecarisecState extends State<Irsaliyecarisec> {
  List<Cari> liscar = [];
  List<Dtoirsaliye> lisirs = [];
  TextEditingController conmus;
  bool arama = false;
  DateTime baslangictar = DateTime.now();
  DateTime bitistar = DateTime.now();
  cariara(String ar) async {
    liscar = await APIServices.mustara(ar);
  }

  Cari cari = Cari(1, "ss", "", 1, ",", "", "", "", "", 1, "", 1);

  Future<Null> secbasl(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: baslangictar,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        baslangictar = picked;
        // contar.text =
        //       selectedDate.toString(); //DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> secbitis(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: bitistar,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        bitistar = picked;
        // contar.text =
        //       selectedDate.toString(); //DateFormat.yMd().format(selectedDate);
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    conmus = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    conmus.dispose();
    super.dispose();
  }

  Widget searchBarUI(String komut) {
    return FloatingSearchBar(
      hint: "Lütfen $komut seçiniz",
      openAxisAlignment: 0.0,
      maxWidth: 600,
      axisAlignment: 0.0,
      scrollPadding: EdgeInsets.only(top: 16, bottom: 20),
      elevation: 4.0,
      physics: BouncingScrollPhysics(),
      onQueryChanged: (query) async {
        setState(() {});
        await cariara(query);
        setState(() {});
      },
      // showDrawerHamburger: false,
      transitionCurve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 500),
      transition: CircularFloatingSearchBarTransition(),
      debounceDelay: Duration(milliseconds: 500),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: Icon(Icons.close_outlined),
            onPressed: () {
              setState(() {
                arama = false;
              });
            },
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Material(
            color: Colors.white,
            child: Container(
              height: 400.0,
              color: Colors.white,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true, //
                  itemCount: liscar == null ? 0 : liscar.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Colors.grey[200],
                      child: ListTile(
                        onTap: () {
                          cari = liscar[index];
                          print(cari.cariunvani);
                          conmus.text = cari.cariunvani;
                          liscar = [];
                          setState(() {
                            arama = false;
                          });
                        },
                        title: Text(liscar[index].cariunvani ?? ""),
                      ),
                    );
                  }),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.black)),
                      height: 45,
                      margin: EdgeInsets.all(20),
                      child: FlatButton(
                        child: Text('Vazgeç'),
                        color: Colors.white,
                        textColor: Colors.grey,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Container(
                      height: 45,
                      margin: EdgeInsets.all(20),
                      child: FlatButton(
                        child: Text('Faturaya dönüştür'),
                        color: Colors.grey.shade700,
                        textColor: Colors.white,
                        onPressed: () async {
                          /*    Urunhareket ur1 =
                                                                Urunhareket(
                                                              -1,
                                                            );*/
                          /*     bool h =
                                                                await APIServices
                                                                    .(
                                                                        pf);
                                                            print(h);*/
                          //   Dtofattahs fat=Dtofattahs(fatid, fatTur, durum, cariId, cariad, duztarih, fataciklama, katad, aratop, araind, kdv, geneltoplam, vadta, alta, alinmism, tahsid)
                          var g = DateTime(baslangictar.year,
                              baslangictar.month, baslangictar.day);
                          var h = DateTime(
                              bitistar.year, bitistar.month, bitistar.day);
                          int w = await APIServices.irsifatyap(cari.cariId,
                              g.toIso8601String(), h.toIso8601String());
                          //     print(g.toString());
                          //       await APIServices.urharfatidekle(g,);
                          Navigator.of(context).pop(1);
                        },
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
                                flex: 1, child: Icon(Icons.bar_chart_outlined)),
                            Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          arama = true;
                                        });
                                      },
                                      child: Text(
                                        "Müşteri",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ))),
                    Expanded(
                      flex: 4,
                      child: Container(
                        //  height: 45,
                        //   width: 45,
                        child: Column(
                          children: [
                            TextFormField(
                              onTap: () {
                                setState(() {
                                  print("yyy");
                                  arama = true;
                                });
                              },
                              readOnly: true,
                              controller: conmus,
                              onChanged: (v) async {
                                setState(() {
                                  //       _isloading = true;
                                });
                                await cariara(v);
                                setState(() {
                                  //    _isloading = false;
                                });
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder()),
                              //    validator: (value) {
                              // validation logic
                              //      },
                            ),
                            cari.cariunvani != "ss"
                                ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        "Bu müşterinin bakiyesi : ${cari.bakiye}"),
                                  )
                                : Text("")
                          ],
                        ),
                      ),
                    ),
                    Wdgfakebutton()
                  ],
                ),
              ),
              /*   ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true, //
                  itemCount: liscar == null ? 0 : liscar.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Colors.grey[200],
                      child: ListTile(
                        onTap: () {
                          cari = liscar[index];
                          print(cari.cariunvani);
                          conmus.text = cari.cariunvani;
                          liscar = [];
                          setState(() {});
                        },
                        title: Text(liscar[index].cariunvani ?? ""),
                      ),
                    );
                  }),*/
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white),
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "İrsaliyeler",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: InkWell(
                                      onTap: () async {
                                        await secbasl(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          "Başlangıç Tarihi",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ))),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      //  border: Border.all(color: Colors.black)
                                      ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ListTile(
                                          title: Text(
                                              " ${baslangictar.year}, ${baslangictar.month}, ${baslangictar.day}"),
                                          trailing: Icon(Icons.calendar_today),
                                          onTap: () async {
                                            await secbasl(context);
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: InkWell(
                                      onTap: () async {
                                        await secbitis(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text("Bitiş Tarihi",
                                            style:
                                                TextStyle(color: Colors.grey)),
                                      ))),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      //    border: Border.all(color: Colors.black)
                                      ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ListTile(
                                          title: Text(
                                              " ${bitistar.year}, ${bitistar.month}, ${bitistar.day}"),
                                          trailing: Icon(Icons.calendar_today),
                                          onTap: () async {
                                            await secbitis(context);
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              setState(() {
                                var g = DateTime(baslangictar.year,
                                    baslangictar.month, baslangictar.day);
                                var h = DateTime(bitistar.year, bitistar.month,
                                    bitistar.day);

                                APIServices.tarihliirsaliyeal(
                                        g.toIso8601String(),
                                        h.toIso8601String())
                                    .then((value) {
                                  setState(() {
                                    lisirs = value;
                                  });
                                });
                                //   dtofattahslis = y;
                              });
                            },
                            child: Text(
                              "Uygula",
                              style: TextStyle(fontSize: 18),
                            ))
                      ],
                    )),
              ),
              Container(
                  width: wsize.width,
                  child: DataTable(
                      columns: <DataColumn>[
                        /* DataColumn(
                          label: Checkbox(value: false, onChanged: (b) {}),
                        ),*/
                        DataColumn(
                          label: Text(
                            'Irsaliye Açıklaması',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey //fontStyle: FontStyle.italic
                                ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Tarih',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey //fontStyle: FontStyle.italic
                                ),
                          ),
                        ),
                        DataColumn(
                          label: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Genel Toplam',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Colors.teal //fontStyle: FontStyle.italic
                                  ),
                            ),
                          ),
                        ),
                      ],
                      rows: lisirs
                          .map((e) => DataRow(
                                  color: MaterialStateColor.resolveWith(
                                      (states) => Colors.white),
                                  cells: [
                                    /*   DataCell(Checkbox(
                                      value: true,
                                      onChanged: (b) {},
                                    )),*/
                                    DataCell(InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Satirs(e)),
                                          ).then((e) {
                                            e != 1
                                                ? print("gggg")
                                                : APIServices.satfatal()
                                                    .then((value) {
                                                    Future.delayed(
                                                        Duration(seconds: 1),
                                                        () {
                                                      setState(() {
                                                        lisirs = value;

                                                        //    _isloading = false;
                                                      });
                                                    });
                                                  });

                                            // setState(() {
                                            //   lis.add(e);
                                            //     print(lis.length.toString());
                                            //     });
                                            /*         setState(() {
                                      print("ee");
                                      _isloading = true;
                                    });
                                    setState(() async {
                                      await APIServices.urunal();
                                      _isloading = false;
                                    });*/
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                e.aciklama.toString(),
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(e.cariad,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15)),
                                            )
                                          ],
                                        ))),
                                    DataCell(Text(e.tarih.toString(),
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 15))),
                                    DataCell(Text(e.geneltop.toString(),
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 15))),
                                  ]))
                          .toList())),
            ],
          ),
          arama == true
              ? searchBarUI("Cari")
              : Container(
                  height: 1,
                  width: 1,
                )
        ],
      ),
    );
  }
}

/*
import 'package:Muhasebe/models/cari.dart';
import 'package:Muhasebe/models/dtoirsaliye.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/ui/satirs.dart';
import 'package:Muhasebe/utils/wdgfakebutton.dart';
import 'package:flutter/material.dart';

class Irsaliyecarisec extends StatefulWidget {
  @override
  _IrsaliyecarisecState createState() => _IrsaliyecarisecState();
}

class _IrsaliyecarisecState extends State<Irsaliyecarisec> {
  List<Cari> liscar = [];
  List<Dtoirsaliye> lisirs = [];
  TextEditingController conmus;
  DateTime baslangictar = DateTime.now();
  DateTime bitistar = DateTime.now();
  cariara(String ar) async {
    liscar = await APIServices.mustara(ar);
  }

  Cari cari = Cari(1, "ss", "", 1, ",", "", "", "", "", 1, "", 1);

  Future<Null> secbasl(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: baslangictar,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        baslangictar = picked;
        // contar.text =
        //       selectedDate.toString(); //DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> secbitis(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: bitistar,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        bitistar = picked;
        // contar.text =
        //       selectedDate.toString(); //DateFormat.yMd().format(selectedDate);
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    conmus = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    conmus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.black)),
                  height: 45,
                  margin: EdgeInsets.all(20),
                  child: FlatButton(
                    child: Text('Vazgeç'),
                    color: Colors.white,
                    textColor: Colors.grey,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Container(
                  height: 45,
                  margin: EdgeInsets.all(20),
                  child: FlatButton(
                    child: Text('Faturaya dönüştür'),
                    color: Colors.grey.shade700,
                    textColor: Colors.white,
                    onPressed: () async {
                      /*    Urunhareket ur1 =
                                                              Urunhareket(
                                                            -1,
                                                          );*/
                      /*     bool h =
                                                              await APIServices
                                                                  .(
                                                                      pf);
                                                          print(h);*/
                      //   Dtofattahs fat=Dtofattahs(fatid, fatTur, durum, cariId, cariad, duztarih, fataciklama, katad, aratop, araind, kdv, geneltoplam, vadta, alta, alinmism, tahsid)
                      var g = DateTime(baslangictar.year, baslangictar.month,
                          baslangictar.day);
                      var h =
                          DateTime(bitistar.year, bitistar.month, bitistar.day);
                      int w = await APIServices.irsifatyap(cari.cariId,
                          g.toIso8601String(), h.toIso8601String());
                      //     print(g.toString());
                      //       await APIServices.urharfatidekle(g,);
                      Navigator.of(context).pop(1);
                    },
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
                            flex: 1, child: Icon(Icons.bar_chart_outlined)),
                        Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(
                                  "Müşteri",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                      ],
                    ))),
                Expanded(
                  flex: 4,
                  child: Container(
                    //  height: 45,
                    //   width: 45,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: conmus,
                          onChanged: (v) async {
                            setState(() {
                              //       _isloading = true;
                            });
                            await cariara(v);
                            setState(() {
                              //    _isloading = false;
                            });
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                          //    validator: (value) {
                          // validation logic
                          //      },
                        ),
                        cari.cariunvani != "ss"
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    "Bu müşterinin bakiyesi : ${cari.bakiye}"),
                              )
                            : Text("")
                      ],
                    ),
                  ),
                ),
                Wdgfakebutton()
              ],
            ),
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true, //
              itemCount: liscar == null ? 0 : liscar.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: Colors.grey[200],
                  child: ListTile(
                    onTap: () {
                      cari = liscar[index];
                      print(cari.cariunvani);
                      conmus.text = cari.cariunvani;
                      liscar = [];
                      setState(() {});
                    },
                    title: Text(liscar[index].cariunvani ?? ""),
                  ),
                );
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "İrsaliyeler",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                  onTap: () async {
                                    await secbasl(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      "Başlangıç Tarihi",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ))),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  //  border: Border.all(color: Colors.black)
                                  ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  ListTile(
                                      title: Text(
                                          " ${baslangictar.year}, ${baslangictar.month}, ${baslangictar.day}"),
                                      trailing: Icon(Icons.calendar_today),
                                      onTap: () async {
                                        await secbasl(context);
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                  onTap: () async {
                                    await secbitis(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text("Bitiş Tarihi",
                                        style: TextStyle(color: Colors.grey)),
                                  ))),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  //    border: Border.all(color: Colors.black)
                                  ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  ListTile(
                                      title: Text(
                                          " ${bitistar.year}, ${bitistar.month}, ${bitistar.day}"),
                                      trailing: Icon(Icons.calendar_today),
                                      onTap: () async {
                                        await secbitis(context);
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          setState(() {
                            var g = DateTime(baslangictar.year,
                                baslangictar.month, baslangictar.day);
                            var h = DateTime(
                                bitistar.year, bitistar.month, bitistar.day);

                            APIServices.tarihliirsaliyeal(
                                    g.toIso8601String(), h.toIso8601String())
                                .then((value) {
                              setState(() {
                                lisirs = value;
                              });
                            });
                            //   dtofattahslis = y;
                          });
                        },
                        child: Text(
                          "Uygula",
                          style: TextStyle(fontSize: 18),
                        ))
                  ],
                )),
          ),
          Container(
              width: wsize,
              child: DataTable(
                  columns: <DataColumn>[
                    DataColumn(
                      label: Checkbox(value: false, onChanged: (b) {}),
                    ),
                    DataColumn(
                      label: Text(
                        'Irsaliye Açıklaması',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey //fontStyle: FontStyle.italic
                            ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Tarih',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey //fontStyle: FontStyle.italic
                            ),
                      ),
                    ),
                    DataColumn(
                      label: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Genel Toplam',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal //fontStyle: FontStyle.italic
                              ),
                        ),
                      ),
                    ),
                  ],
                  rows: lisirs
                      .map((e) => DataRow(
                              color: MaterialStateColor.resolveWith(
                                  (states) => Colors.white),
                              cells: [
                                DataCell(Checkbox(
                                  value: true,
                                  onChanged: (b) {},
                                )),
                                DataCell(InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Satirs(e)),
                                      ).then((e) {
                                        e != 1
                                            ? print("gggg")
                                            : APIServices.satfatal()
                                                .then((value) {
                                                Future.delayed(
                                                    Duration(seconds: 1), () {
                                                  setState(() {
                                                    lisirs = value;

                                                    //    _isloading = false;
                                                  });
                                                });
                                              });

                                        // setState(() {
                                        //   lis.add(e);
                                        //     print(lis.length.toString());
                                        //     });
                                        /*         setState(() {
                                    print("ee");
                                    _isloading = true;
                                  });
                                  setState(() async {
                                    await APIServices.urunal();
                                    _isloading = false;
                                  });*/
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            e.aciklama.toString(),
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(e.cariad,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15)),
                                        )
                                      ],
                                    ))),
                                DataCell(Text(e.tarih.toString(),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15))),
                                DataCell(Text(e.geneltop.toString(),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15))),
                              ]))
                      .toList())),
        ],
      ),
    );
  }
}



*/
