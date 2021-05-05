import 'package:Muhasebe/models/cari.dart';
import 'package:Muhasebe/models/dtofattahs.dart';
import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/fatharlis.dart';
import 'package:Muhasebe/models/fatura.dart';
import 'package:Muhasebe/models/kasa.dart';
import 'package:Muhasebe/models/postfat.dart';
import 'package:Muhasebe/models/tahsilat.dart';
import 'package:Muhasebe/models/urun.dart';
import 'package:Muhasebe/models/urunhareket.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgfakebutton.dart';
import 'package:Muhasebe/utils/wdgloadingalert.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:intl/intl.dart';

class Yenisatfatui extends StatefulWidget {
  @override
  _YenisatfatuiState createState() => _YenisatfatuiState();
}

class _YenisatfatuiState extends State<Yenisatfatui> {
  final _formKey = GlobalKey<FormState>();
  bool ischeck = false;
  bool irsa = false;
  List lis = [1];
  bool tahsett = true;
  bool arama = false;
  bool aramaur = false;
  List<Fathareket> lishar = [];

  List<Kasa> ksl = [];
  Cari cari = Cari(1, "ss", "", 1, ",", "", "", "", "", 1, "", 1);
  List<Cari> liscar =
      []; //[Cari(1, "ss", "", 1, ",", "", "", "", "", 1, "", 1)];
  List<Dtourun> lisurun;
  bool _isloading = false;
  TextEditingController conmus;
  TextEditingController conur;
  TextEditingController conur2;
  TextEditingController conbir;
  TextEditingController conmi;
  TextEditingController conbrfi;
  TextEditingController contopf;
  List<Kasa> kasalist = [];
  Kasa kas = Kasa(1, "", 1);
  String fatacik = "";
  String tahsacik = "";
  Dtourun urun = Dtourun(0, "", 1, "", "", 0, 0, 0, 0, 0);
  Dtourun urun2 = Dtourun(1, "", 1, "", "", 0, 0, 0, 0, 0);
  num aratop = 0;
  num topkdv = 0;
  List<String> liskd = ["18", "8"];
  String kdvkac = "18";
  Dtourun securun;

  DateTime pickedDate;
  DateTime pickedduztar;
  DateTime pickedvad;
  @override
  void initState() {
    super.initState();
    //liskd.add("18");
    //  liskd.add("8");
    conmus = TextEditingController();
    conur = TextEditingController();
    conur2 = TextEditingController();
    conmi = TextEditingController();
    conbrfi = TextEditingController();
    conbir = TextEditingController();
    contopf = TextEditingController();
    pickedDate = DateTime.now();
    pickedvad = DateTime.now();
    pickedduztar = DateTime.now();
    APIServices.kasalistal().then((value) {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          kasalist = value;
          kas = kasalist[0];
          _isloading = false;
        });
      });
    });
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
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

  _pickDate1() async {
    DateTime date = await showDatePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
      locale: Locale("tr"),
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
    );
    if (date != null)
      setState(() {
        pickedduztar = date;
      });
  }

  Future cariara(String ar) async {
    liscar = await APIServices.mustara(ar);
  }

  urunara(String ar) async {
    lisurun = await APIServices.urunara(ar);
  }

  @override
  Widget _dropdownbutton(List<String> liskd) {
    return Container(
      height: 60,
      padding: EdgeInsets.all(1),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(),
        //    borderRadius: BorderRadius.all(Radius.circular(15.0) //),
      ),
      child: DropdownButton<String>(
        value: kdvkac ?? "",
        underline: SizedBox(),
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down),
        //  hint: Text("  $dropdownvalue"),
        // value: selectedUser[index],
        onChanged: (String value) {
          kdvkac = value;
          setState(() {});
        },
        items: liskd.map((String user) {
          return DropdownMenuItem<String>(
            value: user ?? "",
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text(
                  user,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget _dropdownbuttonkasa(List<Kasa> liskd) {
    return Container(
      height: 60,
      padding: EdgeInsets.all(1),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(),
        //    borderRadius: BorderRadius.all(Radius.circular(15.0) //),
      ),
      child: DropdownButton<Kasa>(
        value: kas,
        underline: SizedBox(),
        isExpanded: true,
        icon: Icon(Icons.arrow_drop_down),
        //  hint: Text("  $dropdownvalue"),
        // value: selectedUser[index],
        onChanged: (Kasa value) {
          kas = value;
          setState(() {});
        },
        items: liskd.map((Kasa user) {
          return DropdownMenuItem<Kasa>(
            value: user ?? "",
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

  Future<void> showInformationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text('Ürün Ekle'),
            content: //Stack(fit: StackFit.expand, children: [
                Column(
              children: [
                TextField(
                  /*     readOnly: true,
                    onTap: () {
                      setState(() {
                        aramaur = true;
                      });
                      aramaur = true;
                      setState(() {
                        aramaur = true;
                      });
                    },*/
                  controller: conur,
                  decoration: InputDecoration(hintText: "Ürün"),
                  onChanged: (v) async {
                    setState(() {
                      //_isloading = true;
                    });
                    await urunara(v);

                    setState(() {
                      // _isloading = false;
                    });
                  },
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      //  physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: lisurun == null ? 0 : lisurun.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          color: Colors.grey[200],
                          child: ListTile(
                            onTap: () {
                              securun = lisurun[index];
                              conur.text = securun.adi;
                              lisurun = [];
                              print(securun.birim);
                              conbir.text = securun.birim;
                              conbrfi.text = securun.verharsat.toString();

                              setState(() {});
                            },
                            title: Text(lisurun[index].adi ?? ""),
                          ),
                        );
                      }),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: conmi,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: "Miktar",
                            prefixIcon: Icon(Icons.access_alarm),
                            hintText: "Miktar"),
                        onChanged: (v) async {
                          setState(() {
                            //_isloading = true;
                            int mik = int.tryParse(v);
                            print(mik.toString());
                            num fiy = int.tryParse(conbrfi.text);
                            print(fiy.toString());
                            num kd = int.tryParse(kdvkac);
                            print(kd.toString());
                            num sonu = mik * (fiy + ((fiy * kd) / 100));
                            contopf.text = sonu.toString();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        readOnly: true,
                        controller: conbir,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: "Birim",
                            prefixIcon: Icon(Icons.access_alarm),
                            hintText: "Birim"),
                        onChanged: (v) async {
                          //setState(() {
                          //_isloading = true;
                          //});
                          await cariara(v);
                          // setState(() {
                          // _isloading = false;
                          //});
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: conbrfi,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: "Br. Fiyat",
                            prefixIcon: Icon(Icons.access_alarm),
                            hintText: "Br. Fiyat"),
                        onChanged: (v) async {
                          //setState(() {
                          //_isloading = true;
                          //});
                          await cariara(v);
                          // setState(() {
                          // _isloading = false;
                          //});
                        },
                      ),
                    ),
                    Expanded(flex: 1, child: _dropdownbutton(liskd)),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: contopf,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: "Toplam Fiyat",
                            prefixIcon: Icon(Icons.access_alarm),
                            hintText: "Toplam Fiyat"),
                        onChanged: (v) async {
                          //setState(() {
                          //_isloading = true;
                          //});
                          await cariara(v);
                          // setState(() {
                          // _isloading = false;
                          //});
                        },
                      ),
                    ),
                  ],
                ),
                /*     aramaur == true
                      ? searchBarurun("ürün")
                      : Container(
                          height: 1,
                          width: 1,
                        )*/
              ],
            ),
            // ]),
            actions: <Widget>[
              FlatButton(
                child: Text('İptal'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('Tamam'),
                onPressed: () {
                  Fathareket fat = Fathareket(
                      ad: conur.text,
                      barkodno: securun.barkodno,
                      birim: conmi.text,
                      miktar: int.tryParse(conmi.text),
                      brfiyat: int.tryParse(conbrfi.text),
                      vergi: int.tryParse(kdvkac),
                      toplfiy: int.tryParse(conmi.text) *
                          (int.tryParse(conbrfi.text) +
                              (int.tryParse(conbrfi.text) *
                                  int.tryParse(kdvkac))));
                  lishar.add(fat);
                  aratop = aratop +
                      (int.tryParse(conbrfi.text) * int.tryParse(conmi.text));
                  var tp = int.tryParse(conmi.text) *
                      (int.tryParse(conbrfi.text) +
                          (int.tryParse(conbrfi.text) * int.tryParse(kdvkac)));
                  var kd =
                      int.tryParse(conmi.text) * int.tryParse(conbrfi.text);
                  var h = tp - kd;
                  topkdv = topkdv + h;
                  conmi.text = "";
                  conbir.text = "";
                  conbrfi.text = "";
                  conur.text = "";
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
      },
    ).then((value) {
      setState(() {});
    });
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

  Widget searchBarurun(String komut) {
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
        await urunara(query);
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
                aramaur = false;
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
                  itemCount: lisurun == null ? 0 : lisurun.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Colors.grey[200],
                      child: ListTile(
                        onTap: () {
                          securun = lisurun[index];
                          conur.text = securun.adi;
                          lisurun = [];
                          print(securun.birim);
                          conbir.text = securun.birim;
                          conbrfi.text = securun.verharsat.toString();
                          setState(() {
                            aramaur = false;
                          });
                        },
                        title: Text(lisurun[index].adi ?? ""),
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
  void dispose() {
    // TODO: implement dispose
    conmus.dispose();
    conur.dispose();
    conur2.dispose();
    contopf.dispose();
    conmi.dispose();
    conbrfi.dispose();
    conbir.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          /* appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.grey.shade300,
              title: Wdgappbar("Satış Faturaları >", "Yeni", "Ahmet Seç")),
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
              isLoading: _isloading,
              opacity: 0,
              progressIndicator: Wdgloadingalert(wsize: wsize),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Row(
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
                            // child: Expanded(
                            child: Column(children: [
                              Wdgappbar("wwww", "gggg", "qqqsw"),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  //   color: Colors.white,
                                  child: Column(
                                    children: [
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                                Icons.file_copy,
                                                                color:
                                                                    Colors.blue,
                                                              )),
                                                          Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                "Fatura Açıklaması",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
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
                                                        onSaved: (v) {
                                                          fatacik = v;
                                                        },
                                                        decoration:
                                                            const InputDecoration(
                                                                border:
                                                                    OutlineInputBorder()),
                                                        validator: (value) {
                                                          if (value.isEmpty) {
                                                            return "Fatura Açıklaması boş olamaz";
                                                          }
                                                          return null;
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
                                                                    .circular(
                                                                        4),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black)),
                                                        height: 45,
                                                        margin:
                                                            EdgeInsets.all(20),
                                                        child: FlatButton(
                                                          child: Text('Vazgeç'),
                                                          color: Colors.white,
                                                          textColor:
                                                              Colors.grey,
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 45,
                                                        margin:
                                                            EdgeInsets.all(20),
                                                        child: FlatButton(
                                                          child: Text('Kaydet'),
                                                          color: Colors
                                                              .grey.shade700,
                                                          textColor:
                                                              Colors.white,
                                                          onPressed: () async {
                                                            if (_formKey
                                                                .currentState
                                                                .validate()) {
                                                              _formKey
                                                                  .currentState
                                                                  .save();

                                                              Postfatura1 p =
                                                                  Postfatura1(
                                                                      1,
                                                                      fatacik,
                                                                      cari
                                                                          .cariId,
                                                                      pickedduztar
                                                                          .toString(),
                                                                      1,
                                                                      aratop,
                                                                      0,
                                                                      topkdv,
                                                                      aratop +
                                                                          topkdv,
                                                                      null,
                                                                      /*   tahsett ==
                                                                            true
                                                                        ? kas
                                                                            .kasaid
                                                                        : 9,*/
                                                                      9,
                                                                      tahsett ==
                                                                              true
                                                                          ? 1
                                                                          : 0,
                                                                      pickedDate
                                                                          .toString(),
                                                                      pickedDate
                                                                          .toString(),
                                                                      tahsett ==
                                                                              true
                                                                          ? tahsacik
                                                                          : "",
                                                                      tahsett ==
                                                                              true
                                                                          ? aratop +
                                                                              topkdv
                                                                          : 0,
                                                                      aratop +
                                                                          topkdv);
                                                              List<Hareket>
                                                                  listur = [];
                                                              for (int i = 0;
                                                                  i <
                                                                      lishar
                                                                          .length;
                                                                  i++) {
                                                                listur.add(Hareket(
                                                                    barkodno:
                                                                        lishar[i]
                                                                            .barkodno,
                                                                    miktar: lishar[
                                                                            i]
                                                                        .miktar,
                                                                    brfiyat: lishar[
                                                                            i]
                                                                        .brfiyat,
                                                                    vergi: lishar[
                                                                            i]
                                                                        .vergi));
                                                              }
                                                              Postfatura pf =
                                                                  Postfatura(p,
                                                                      listur);

                                                              /*    Urunhareket ur1 =
                                                              Urunhareket(
                                                            -1,
                                                          );*/
                                                              bool h =
                                                                  await APIServices
                                                                      .faturaekle(
                                                                          pf);
                                                              print(h);

                                                              //   Dtofattahs fat=Dtofattahs(fatid, fatTur, durum, cariId, cariad, duztarih, fataciklama, katad, aratop, araind, kdv, geneltoplam, vadta, alta, alinmism, tahsid)
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(1);
                                                            }
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
                                                color: Colors.black),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    "Müşteri",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontWeight:
                                                                            FontWeight.bold),
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
                                                            readOnly: true,
                                                            onTap: () {
                                                              setState(() {
                                                                arama = true;
                                                              });
                                                            },
                                                            controller: conmus,
                                                            onChanged:
                                                                (v) async {
                                                              setState(() {
                                                                _isloading =
                                                                    true;
                                                              });
                                                              await cariara(v);
                                                              setState(() {
                                                                _isloading =
                                                                    false;
                                                              });
                                                            },
                                                            decoration:
                                                                const InputDecoration(
                                                                    border:
                                                                        OutlineInputBorder()),
                                                            //    validator: (value) {
                                                            // validation logic
                                                            //      },
                                                          ),
                                                          cari.cariunvani !=
                                                                  "ss"
                                                              ? Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
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
                                            /*     ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true, //
                                                  itemCount: liscar == null
                                                      ? 0
                                                      : liscar.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Container(
                                                      color: Colors.grey[200],
                                                      child: ListTile(
                                                        onTap: () {
                                                          cari = liscar[index];
                                                          conmus.text =
                                                              cari.cariunvani;
                                                          liscar = [];
                                                          setState(() {});
                                                        },
                                                        title: Text(liscar[index]
                                                                .cariunvani ??
                                                            ""),
                                                      ),
                                                    );
                                                  }),*/
                                            Divider(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                                "İrsaliye",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
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
                                                                color: Colors
                                                                    .black)),
                                                        //     height: ,
                                                        child: CheckboxListTile(
                                                          controlAffinity:
                                                              ListTileControlAffinity
                                                                  .leading,
                                                          title: Text(
                                                              "İrsaliyeli Satış"),
                                                          value: irsa,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              irsa = !irsa;
                                                            });
                                                          },
                                                        )),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black)),
                                                        //   height: ,
                                                        child: CheckboxListTile(
                                                          controlAffinity:
                                                              ListTileControlAffinity
                                                                  .leading,
                                                          title: Text(
                                                              "Irsaliyesiz Satış"),
                                                          value: !irsa,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              irsa = !irsa;
                                                            });
                                                          },
                                                        )),
                                                  ),
                                                  Wdgfakebutton()
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                                "Tahsilat Durumu",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
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
                                                                color: Colors
                                                                    .black)),
                                                        //     height: ,
                                                        child: CheckboxListTile(
                                                          controlAffinity:
                                                              ListTileControlAffinity
                                                                  .leading,
                                                          title: Text(
                                                              "Tahsil Edilecek"),
                                                          value: !tahsett,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              tahsett =
                                                                  !tahsett;
                                                            });
                                                          },
                                                        )),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black)),
                                                        //   height: ,
                                                        child: CheckboxListTile(
                                                          controlAffinity:
                                                              ListTileControlAffinity
                                                                  .leading,
                                                          title: Text(
                                                              "Tahsil Edildi"),
                                                          value: tahsett,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              tahsett =
                                                                  !tahsett;
                                                            });
                                                          },
                                                        )),
                                                  ),
                                                  Wdgfakebutton()
                                                ],
                                              ),
                                            ),
                                            tahsett != true
                                                ? Container(
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Center(
                                                                      child:
                                                                          Row(
                                                                    children: [
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Icon(Icons.bar_chart_outlined)),
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Text(
                                                                            "Düzenleme Tarihi",
                                                                            style:
                                                                                TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                                                          )),
                                                                    ],
                                                                  ))),
                                                              Expanded(
                                                                flex: 4,
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color:
                                                                              Colors.black)),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      ListTile(
                                                                        title: Text(
                                                                            DateFormat.yMMMd('tr_TR').format(pickedduztar)
                                                                            //   pickedduztar.toLocal().toString()
                                                                            //  " ${pickedduztar.year}, ${pickedduztar.month}, ${pickedduztar.day}"
                                                                            ),
                                                                        trailing:
                                                                            Icon(Icons.calendar_today),
                                                                        onTap:
                                                                            _pickDate1,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Wdgfakebutton()
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Center(
                                                                      child:
                                                                          Row(
                                                                    children: [
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Icon(Icons.bar_chart_outlined)),
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Text(
                                                                            "Vade Tarihi",
                                                                            style:
                                                                                TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                                                          )),
                                                                    ],
                                                                  ))),
                                                              Expanded(
                                                                flex: 4,
                                                                child:
                                                                    Container(
                                                                  height: 60,
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color:
                                                                              Colors.black)),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      ListTile(
                                                                        title: Text(
                                                                            DateFormat.yMMMd('tr_TR').format(pickedDate)),
                                                                        //   " ${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day}"),
                                                                        trailing:
                                                                            Icon(Icons.calendar_today),
                                                                        onTap:
                                                                            _pickDate,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ), /*Container(
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black)),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  ListTile(
                                                                    title: Text(
                                                                        " ${pickedvad.year}, ${pickedvad.month}, ${pickedvad.day}"),
                                                                    trailing:
                                                                        Icon(Icons
                                                                            .calendar_today),
                                                                    onTap:
                                                                        _pickDate(), //bunu degistri
                                                                  ),
                                                                ],
                                                              ),
                                                            ),*/
                                                              ),
                                                              Wdgfakebutton()
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Container(
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Center(
                                                                      child:
                                                                          Row(
                                                                    children: [
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Icon(Icons.bar_chart_outlined)),
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Text(
                                                                            "Tahsil edildiği tarih ve kasa hesabı",
                                                                            style:
                                                                                TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                                                          )),
                                                                    ],
                                                                  ))),
                                                              Expanded(
                                                                flex: 2,
                                                                child:
                                                                    Container(
                                                                  height: 60,
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color:
                                                                              Colors.black)),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      ListTile(
                                                                        title: Text(
                                                                            DateFormat.yMMMd('tr_TR').format(pickedDate)),
                                                                        //       " ${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day}"),
                                                                        trailing:
                                                                            Icon(Icons.calendar_today),
                                                                        onTap:
                                                                            _pickDate,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      _dropdownbuttonkasa(
                                                                          ksl)
                                                                  /* Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(),
                                                  ),
                                                  child: DropdownButton<String>(
                                                    items: <String>[
                                                      '%18',
                                                      '%8',
                                                      '%1',
                                                    ].map((String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value:
                                                            "11", // selectedvalue
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    onChanged: (_) {},
                                                  ),
                                                ),*/
                                                                  ),
                                                              Wdgfakebutton()
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Center(
                                                                      child:
                                                                          Row(
                                                                    children: [
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Icon(Icons.bar_chart_outlined)),
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Text(
                                                                            "Tahsilat Açıklaması",
                                                                            style:
                                                                                TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                                                          )),
                                                                    ],
                                                                  ))),
                                                              Expanded(
                                                                flex: 4,
                                                                child:
                                                                    Container(
                                                                  height: 45,
                                                                  child:
                                                                      TextFormField(
                                                                    onSaved:
                                                                        (s) {
                                                                      tahsacik =
                                                                          s ??
                                                                              "";
                                                                    },
                                                                    decoration:
                                                                        const InputDecoration(
                                                                            border:
                                                                                OutlineInputBorder()),
                                                                    //         validator:
                                                                    //           (value) {
                                                                    // validation logic
                                                                    //     },
                                                                  ),
                                                                ),
                                                              ),
                                                              Wdgfakebutton()
                                                            ],
                                                          ),
                                                        ),
                                                        Divider(),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Center(
                                                                      child:
                                                                          Row(
                                                                    children: [
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Icon(Icons.bar_chart_outlined)),
                                                                      Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Text(
                                                                            "Düzenleme Tarihi",
                                                                            style:
                                                                                TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                                                          )),
                                                                    ],
                                                                  ))),
                                                              Expanded(
                                                                flex: 4,
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color:
                                                                              Colors.black)),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      ListTile(
                                                                        title: Text(
                                                                            DateFormat.yMMMd('tr_TR').format(pickedduztar)),
                                                                        //      " ${pickedduztar.year}, ${pickedduztar.month}, ${pickedduztar.day}"),
                                                                        trailing:
                                                                            Icon(Icons.calendar_today),
                                                                        onTap:
                                                                            _pickDate1,
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
                                                  )
                                          ],
                                        ),
                                      ),

                                      //   Container(height: 40, color: Colors.grey[200]),
                                      Container(
                                          width: wsize.width,
                                          child: DataTable(
                                            headingRowColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) =>
                                                        Colors.grey.shade200),
                                            columns: <DataColumn>[
                                              DataColumn(
                                                label: InkWell(
                                                  onTap: () {
                                                    //        showInformationDialog(context);
                                                  },
                                                  child: Text(
                                                    'Ürün',
                                                    style: TextStyle(
                                                        //fontSize: 18,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold
                                                        //    fontStyle:
                                                        //   FontStyle.italic
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text('Miktar',
                                                    style: TextStyle(
                                                        //fontSize: 18,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold
                                                        //    fontStyle:
                                                        //   FontStyle.italic
                                                        )),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Birim',
                                                  style: TextStyle(
                                                      //fontSize: 18,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold
                                                      //    fontStyle:
                                                      //   FontStyle.italic
                                                      ),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Br. Fiyat',
                                                  style: TextStyle(
                                                      //fontSize: 18,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold
                                                      //    fontStyle:
                                                      //   FontStyle.italic
                                                      ),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Vergi',
                                                  style: TextStyle(
                                                      //fontSize: 18,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold
                                                      //    fontStyle:
                                                      //   FontStyle.italic
                                                      ),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  'Toplam',
                                                  style: TextStyle(
                                                      //fontSize: 18,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold
                                                      //    fontStyle:
                                                      //   FontStyle.italic
                                                      ),
                                                ),
                                              ),
                                            ],
                                            rows: lishar
                                                .map((e) => DataRow(
                                                        color: MaterialStateColor
                                                            .resolveWith(
                                                                (states) =>
                                                                    Colors
                                                                        .white),
                                                        cells: [
                                                          DataCell(Text(e.ad)),
                                                          DataCell(Text(e.miktar
                                                              .toString())),
                                                          DataCell(Text(
                                                            e.birim.toString(),
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          )),
                                                          DataCell(Text(e
                                                              .brfiyat
                                                              .toString())),
                                                          DataCell(Text(
                                                            e.vergi.toString(),
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          )),
                                                          DataCell(Text(
                                                            e.toplfiy
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          )),
                                                        ]))
                                                .toList(),
                                          )),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: TextButton.icon(
                                            onPressed: () {
                                              showInformationDialog(context);
                                            },
                                            icon: Icon(Icons.plus_one),
                                            label: Text(
                                              "Ürün Ekle",
                                              style: TextStyle(fontSize: 24),
                                            )),
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: (2 * wsize.width) / 6,
                                            height: 120,
                                            color: Colors.white,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 8, 24.0, 0),
                                            child: Container(
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
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        aratop.toString(),
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                  Divider(),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Toplam Kdv ",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        topkdv.toString(),
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                  Divider(),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Genel Toplam",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        "${(aratop + topkdv)}",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ]),
                            //  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  arama == true
                      ? searchBarUI("Cari")
                      : Container(
                          height: 1,
                          width: 1,
                        )
                ],
              ))),
    );
  }
}

/*
import 'package:Muhasebe/models/cari.dart';
import 'package:Muhasebe/models/dtofattahs.dart';
import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/fatura.dart';
import 'package:Muhasebe/models/kasa.dart';
import 'package:Muhasebe/models/postfat.dart';
import 'package:Muhasebe/models/tahsilat.dart';
import 'package:Muhasebe/models/urun.dart';
import 'package:Muhasebe/models/urunhareket.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgfakebutton.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';



class Yenisatfatui extends StatefulWidget {
  @override
  _YenisatfatuiState createState() => _YenisatfatuiState();
}

class _YenisatfatuiState extends State<Yenisatfatui> {
  final _formKey = GlobalKey<FormState>();
  bool ischeck = false;
  bool irsa = false;
  List lis = [1];
  bool tahsett = true;

  List<Kasa> ksl = [];
  Cari cari = Cari(1, "ss", "", 1, ",", "", "", "", "", 1, "", 1);
  List<Cari> liscar =
      []; //[Cari(1, "ss", "", 1, ",", "", "", "", "", 1, "", 1)];
  List<Dtourun> lisurun;
  bool _isloading = false;
  TextEditingController conmus;
  TextEditingController conur;
  TextEditingController conur2;
  List<Kasa> kasalist = [];
  Kasa kas = Kasa(1, "", 1);
  String fatacik = "";
  String tahsacik = "";
  Dtourun urun = Dtourun(0, "", 1, "", "", 0, 0, 0, 0, 0);
  Dtourun urun2 = Dtourun(1, "", 1, "", "", 0, 0, 0, 0, 0);
  num aratop = 0;
  num topkdv = 0;

  DateTime pickedDate;
  DateTime pickedduztar;
  DateTime pickedvad;
  @override
  void initState() {
    super.initState();
    conmus = TextEditingController();
    conur = TextEditingController();
    conur2 = TextEditingController();
    pickedDate = DateTime.now();
    pickedvad = DateTime.now();
    pickedduztar = DateTime.now();
    APIServices.kasalistal().then((value) {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          kasalist = value;
          kas = kasalist[0];
          _isloading = false;
        });
      });
    });
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
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

  _pickDate1() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
    );
    if (date != null)
      setState(() {
        pickedduztar = date;
      });
  }

  cariara(String ar) async {
    liscar = await APIServices.mustara(ar);
  }

  urunara(String ar) async {
    lisurun = await APIServices.urunara(ar);
  }

  @override
  Widget _dropdownbutton(List<Kasa> userlist) {
    return Container(
      height: 60,
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

  @override
  void dispose() {
    // TODO: implement dispose
    conmus.dispose();
    conur.dispose();
    conur2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.grey.shade300,
              title: Wdgappbar("Satış Faturaları >", "Yeni", "Ahmet Seç")),
          drawer: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors
                  .black87, //This will change the drawer background to blue.
              //other styles
            ),
            child: Drawer(child: Wdgdrawer()),
          ),
          backgroundColor: Colors.grey.shade300,
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
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            //   color: Colors.white,
                            child: Column(
                              children: [
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
                                                          Icons.file_copy,
                                                          color: Colors.blue,
                                                        )),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          "Fatura Açıklaması",
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
                                                  onSaved: (v) {
                                                    fatacik = v;
                                                  },
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return "Fatura Açıklaması boş olamaz";
                                                    }
                                                    return null;
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
                                                    textColor: Colors.grey,
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
                                                    onPressed: () async {
                                                      if (_formKey.currentState
                                                          .validate()) {
                                                        _formKey.currentState
                                                            .save();
                                                        num x = urun.adet *
                                                            (urun.verharsat +
                                                                urun.verharsat *
                                                                    urun.kdv);
                                                        num y = urun2.adet *
                                                            (urun2.verharsat +
                                                                urun2.verharsat *
                                                                    urun2.kdv);
                                                        Postfatura1 p =
                                                            Postfatura1(
                                                                1,
                                                                fatacik,
                                                                cari.cariId,
                                                                pickedduztar
                                                                    .toString(),
                                                                1,
                                                                urun.verharsat +
                                                                    urun2
                                                                        .verharsat,
                                                                0,
                                                                urun.kdv +
                                                                    urun2.kdv,
                                                                x + y,
                                                                null,
                                                                tahsett == true
                                                                    ? kas.kasaid
                                                                    : 9,
                                                                tahsett == true
                                                                    ? 1
                                                                    : 0,
                                                                pickedDate
                                                                    .toString(),
                                                                pickedDate
                                                                    .toString(),
                                                                tahsett == true
                                                                    ? tahsacik
                                                                    : "",
                                                                tahsett == true
                                                                    ? x + y
                                                                    : 0,
                                                                x + y);
                                                        List<Hareket> listur = [
                                                          Hareket(
                                                              barkodno:
                                                                  urun.barkodno,
                                                              miktar: 1,
                                                              brfiyat: urun
                                                                  .verharsat,
                                                              vergi: urun.kdv),
                                                          Hareket(
                                                              barkodno: urun2
                                                                  .barkodno,
                                                              miktar: 1,
                                                              brfiyat: urun2
                                                                  .verharsat,
                                                              vergi: urun2.kdv)
                                                        ];
                                                        Postfatura pf =
                                                            Postfatura(
                                                                p, listur);

                                                        /*    Urunhareket ur1 =
                                                            Urunhareket(
                                                          -1,
                                                        );*/
                                                        bool h =
                                                            await APIServices
                                                                .faturaekle(pf);
                                                        print(h);
                                                        //   Dtofattahs fat=Dtofattahs(fatid, fatTur, durum, cariId, cariad, duztarih, fataciklama, katad, aratop, araind, kdv, geneltoplam, vadta, alta, alinmism, tahsid)
                                                        Navigator.of(context)
                                                            .pop(1);
                                                      }
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
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              "Müşteri",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
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
                                                          _isloading = true;
                                                        });
                                                        await cariara(v);
                                                        setState(() {
                                                          _isloading = false;
                                                        });
                                                      },
                                                      decoration:
                                                          const InputDecoration(
                                                              border:
                                                                  OutlineInputBorder()),
                                                      //    validator: (value) {
                                                      // validation logic
                                                      //      },
                                                    ),
                                                    cari.cariunvani != "ss"
                                                        ? Align(
                                                            alignment: Alignment
                                                                .centerLeft,
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
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true, //
                                          itemCount: liscar == null
                                              ? 0
                                              : liscar.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              color: Colors.grey[200],
                                              child: ListTile(
                                                onTap: () {
                                                  cari = liscar[index];
                                                  conmus.text = cari.cariunvani;
                                                  liscar = [];
                                                  setState(() {});
                                                },
                                                title: Text(
                                                    liscar[index].cariunvani ??
                                                        ""),
                                              ),
                                            );
                                          }),
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
                                                          "İrsaliye",
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
                                                    title: Text(
                                                        "İrsaliyeli Satış"),
                                                    value: irsa,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        irsa = !irsa;
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
                                                    title: Text(
                                                        "Irsaliyesiz Satış"),
                                                    value: !irsa,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        irsa = !irsa;
                                                      });
                                                    },
                                                  )),
                                            ),
                                            Wdgfakebutton()
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
                                                          "Tahsilat Durumu",
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
                                                    title:
                                                        Text("Tahsil Edilecek"),
                                                    value: !tahsett,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        tahsett = !tahsett;
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
                                                    title:
                                                        Text("Tahsil Edildi"),
                                                    value: tahsett,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        tahsett = !tahsett;
                                                      });
                                                    },
                                                  )),
                                            ),
                                            Wdgfakebutton()
                                          ],
                                        ),
                                      ),
                                      tahsett != true
                                          ? Container(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
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
                                                                        Icons
                                                                            .bar_chart_outlined)),
                                                                Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      "Düzenleme Tarihi",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )),
                                                              ],
                                                            ))),
                                                        Expanded(
                                                          flex: 4,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black)),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                ListTile(
                                                                  title: Text(
                                                                      " ${pickedduztar.year}, ${pickedduztar.month}, ${pickedduztar.day}"),
                                                                  trailing:
                                                                      Icon(Icons
                                                                          .calendar_today),
                                                                  onTap:
                                                                      _pickDate1,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Wdgfakebutton()
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
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
                                                                        Icons
                                                                            .bar_chart_outlined)),
                                                                Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      "Vade Tarihi",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )),
                                                              ],
                                                            ))),
                                                        Expanded(
                                                          flex: 4,
                                                          child: Container(
                                                            height: 60,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black)),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                ListTile(
                                                                  title: Text(
                                                                      " ${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day}"),
                                                                  trailing:
                                                                      Icon(Icons
                                                                          .calendar_today),
                                                                  onTap:
                                                                      _pickDate,
                                                                ),
                                                              ],
                                                            ),
                                                          ), /*Container(
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black)),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                ListTile(
                                                                  title: Text(
                                                                      " ${pickedvad.year}, ${pickedvad.month}, ${pickedvad.day}"),
                                                                  trailing:
                                                                      Icon(Icons
                                                                          .calendar_today),
                                                                  onTap:
                                                                      _pickDate(), //bunu degistri
                                                                ),
                                                              ],
                                                            ),
                                                          ),*/
                                                        ),
                                                        Wdgfakebutton()
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
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
                                                                        Icons
                                                                            .bar_chart_outlined)),
                                                                Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      "Tahsil edildiği tarih ve kasa hesabı",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )),
                                                              ],
                                                            ))),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Container(
                                                            height: 60,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black)),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                ListTile(
                                                                  title: Text(
                                                                      " ${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day}"),
                                                                  trailing:
                                                                      Icon(Icons
                                                                          .calendar_today),
                                                                  onTap:
                                                                      _pickDate,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                            flex: 2,
                                                            child:
                                                                _dropdownbutton(
                                                                    kasalist)
                                                            /* Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(),
                                                ),
                                                child: DropdownButton<String>(
                                                  items: <String>[
                                                    '%18',
                                                    '%8',
                                                    '%1',
                                                  ].map((String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value:
                                                          "11", // selectedvalue
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  onChanged: (_) {},
                                                ),
                                              ),*/
                                                            ),
                                                        Wdgfakebutton()
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
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
                                                                        Icons
                                                                            .bar_chart_outlined)),
                                                                Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      "Tahsilat Açıklaması",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )),
                                                              ],
                                                            ))),
                                                        Expanded(
                                                          flex: 4,
                                                          child: Container(
                                                            height: 45,
                                                            child:
                                                                TextFormField(
                                                              onSaved: (s) {
                                                                tahsacik =
                                                                    s ?? "";
                                                              },
                                                              decoration:
                                                                  const InputDecoration(
                                                                      border:
                                                                          OutlineInputBorder()),
                                                              //         validator:
                                                              //           (value) {
                                                              // validation logic
                                                              //     },
                                                            ),
                                                          ),
                                                        ),
                                                        Wdgfakebutton()
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
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
                                                                        Icons
                                                                            .bar_chart_outlined)),
                                                                Expanded(
                                                                    flex: 1,
                                                                    child: Text(
                                                                      "Düzenleme Tarihi",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )),
                                                              ],
                                                            ))),
                                                        Expanded(
                                                          flex: 4,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black)),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                ListTile(
                                                                  title: Text(
                                                                      " ${pickedduztar.year}, ${pickedduztar.month}, ${pickedduztar.day}"),
                                                                  trailing:
                                                                      Icon(Icons
                                                                          .calendar_today),
                                                                  onTap:
                                                                      _pickDate1,
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
                                            )
                                    ],
                                  ),
                                ),

                                //   Container(height: 40, color: Colors.grey[200]),
                                Container(
                                    width: wsize,
                                    child: DataTable(
                                        headingRowColor:
                                            MaterialStateColor.resolveWith(
                                                (states) =>
                                                    Colors.grey.shade200),
                                        columns: const <DataColumn>[
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
                                            label: Text('Miktar',
                                                style: TextStyle(
                                                    //fontSize: 18,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold
                                                    //    fontStyle:
                                                    //   FontStyle.italic
                                                    )),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Birim',
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
                                              'Br. Fiyat',
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
                                              'Vergi',
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
                                              'Toplam',
                                              style: TextStyle(
                                                  //fontSize: 18,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold
                                                  //    fontStyle:
                                                  //   FontStyle.italic
                                                  ),
                                            ),
                                          ),
                                        ],
                                        rows: <DataRow>[
                                          DataRow(cells: [
                                            DataCell(TextField(
                                              controller: conur,
                                              onChanged: (v) async {
                                                setState(() {
                                                  _isloading = true;
                                                });
                                                await urunara(v);
                                                setState(() {
                                                  _isloading = false;
                                                });
                                              },
                                            )),
                                            DataCell(Text(
                                              "1",
                                            )),
                                            DataCell(Text(urun.birim)),
                                            DataCell(Text(
                                                urun.verharsat.toString() ??
                                                    "")),
                                            DataCell(Text(
                                              urun.kdv.toString() ?? "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            DataCell(Text(
                                              urun == null
                                                  ? ""
                                                  : "${1 * (urun.verharsat + (urun.verharsat * urun.kdv))}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(TextField(
                                              controller: conur2,
                                              onChanged: (v) async {
                                                setState(() {
                                                  _isloading = true;
                                                });
                                                await urunara(v);
                                                setState(() {
                                                  _isloading = false;
                                                });
                                              },
                                            )),
                                            DataCell(Text(
                                              "1",
                                            )),
                                            DataCell(Text(urun2.birim)),
                                            DataCell(Text(
                                                urun2.verharsat.toString() ??
                                                    "")),
                                            DataCell(Text(
                                              urun2.kdv.toString() ?? "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            DataCell(Text(
                                              urun == null
                                                  ? ""
                                                  : "${1 * (urun2.verharsat + (urun2.verharsat * urun2.kdv))}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ])
                                        ])),
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true, //
                                    itemCount:
                                        lisurun == null ? 0 : lisurun.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        color: Colors.grey[200],
                                        child: ListTile(
                                          onTap: () {
                                            //urun1 i değiştiremiyorsun
                                            if (urun.barkodno == 0) {
                                              urun = lisurun[index];
                                              conur.text = urun.adi;
                                            } else {
                                              urun2 = lisurun[index];
                                              conur2.text = urun2.adi;
                                            }

                                            lisurun = [];
                                            setState(() {});
                                          },
                                          title: Text(lisurun[index].adi ?? ""),
                                        ),
                                      );
                                    }),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: (2 * wsize) / 6,
                                      height: 120,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 8, 24.0, 0),
                                      child: Container(
                                        width: (2 * wsize) / 6,
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
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "${urun.verharsat + urun2.verharsat}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            Divider(),
                                            Row(
                                              children: [
                                                Text(
                                                  "Toplam Kdv ",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "${urun.kdv + urun2.kdv}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            Divider(),
                                            Row(
                                              children: [
                                                Text(
                                                  "Genel Toplam",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "${(1 * (urun2.verharsat + (urun2.verharsat * urun2.kdv))) + 1 * (urun.verharsat + (urun.verharsat * urun.kdv))}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
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


*/
