import 'package:Muhasebe/models/cari.dart';
import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/fatharlis.dart';
import 'package:Muhasebe/models/fatura.dart';
import 'package:Muhasebe/models/kasa.dart';
import 'package:Muhasebe/models/postfat.dart';
import 'package:Muhasebe/models/tahsilat.dart';
import 'package:Muhasebe/models/urun.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgloadingalert.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:intl/intl.dart';

class Yenialisfatui extends StatefulWidget {
  @override
  _YenialisfatuiState createState() => _YenialisfatuiState();
}

class _YenialisfatuiState extends State<Yenialisfatui> {
  final _formKey = GlobalKey<FormState>();
  bool ischeck = false;
  List lis = [1];
  bool irsa = false;
  bool odendimi = false;
  bool tahsedilce = false;
  List<Kasa> ksl = [];
  Cari cari = Cari(1, "ss", "", 1, ",", "", "", "", "", 1, "", 1);
  List<Cari> liscar = [];
  List<Dtourun> lisurun;
  bool _isloading = false;
  bool arama = false;
  TextEditingController conmus;
  TextEditingController conur;
  TextEditingController conur2;
  List<Kasa> kasalist = [];
  Kasa kas = Kasa(1, "", 1);
  String fatacik = "";
  String tahsacik = "";
  Dtourun urun = Dtourun(0, "", 1, "", "", 0, 0, 0, 0, 0);
  Dtourun urun2 = Dtourun(1, "", 1, "", "", 0, 0, 0, 0, 0);

  DateTime pickedDate;
  DateTime pickedduztar;
  List<Fathareket> lishar = [];
  TextEditingController conbir;
  TextEditingController conmi;
  TextEditingController conbrfi;
  TextEditingController contopf;
  num aratop = 0;
  num topkdv = 0;
  List<String> liskd = ["18", "8"];
  String kdvkac = "18";
  Dtourun securun;
  @override
  void initState() {
    super.initState();
    conmus = TextEditingController();
    conur = TextEditingController();
    conur2 = TextEditingController();
    conmi = TextEditingController();
    conbrfi = TextEditingController();
    conbir = TextEditingController();
    contopf = TextEditingController();
    pickedDate = DateTime.now();
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

  _pickDate1() async {
    DateTime date = await showDatePicker(
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

  cariara(String ar) async {
    liscar = await APIServices.tedara(ar);
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

  Future<void> showInformationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text('Ürün Ekle'),
            content: Column(
              children: [
                TextField(
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
              ],
            ),
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

  @override
  void dispose() {
    // TODO: implement dispose
    conmus.dispose();
    conur.dispose();
    conur2.dispose();
    conmi.dispose();
    conbir.dispose();
    conbrfi.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          /*  appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.grey.shade300,
              title: Wdgappbar("Giderler >", "Yeni Fiş Fatura", "Ahmet Seç")),
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
                            //   child: Expanded(
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
                                                                color: Colors
                                                                    .brown,
                                                              )),
                                                          Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                " Açıklama",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .brown,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )),
                                                        ],
                                                      ))),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Container(
                                                      //         height: 45,
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
                                                            return "Açıklama kısmı boş olamaz";
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
                                                            child:
                                                                Text('Kaydet'),
                                                            color: Colors
                                                                .grey.shade700,
                                                            textColor:
                                                                Colors.white,
                                                            onPressed:
                                                                () async {
                                                              if (_formKey
                                                                  .currentState
                                                                  .validate()) {
                                                                _formKey
                                                                    .currentState
                                                                    .save();

                                                                Postfatura1 p =
                                                                    Postfatura1(
                                                                        0,
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
                                                                        odendimi ==
                                                                                true
                                                                            ? 9 //kas.kasaid
                                                                            : 9,
                                                                        odendimi ==
                                                                                true
                                                                            ? 1
                                                                            : 0,
                                                                        pickedDate
                                                                            .toString(),
                                                                        pickedDate
                                                                            .toString(),
                                                                        odendimi ==
                                                                                true
                                                                            ? tahsacik
                                                                            : "",
                                                                        odendimi ==
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
                                                                    Postfatura(
                                                                        p,
                                                                        listur);
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
                                                            }),
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
                                                              child: Text(
                                                                "Tedarikçi",
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
                                                      //   height: 50,
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
                                                            validator: (value) {
                                                              // validation logic
                                                            },
                                                          ),
                                                          cari.cariunvani !=
                                                                  "ss"
                                                              ? Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                      "Bu tedarikçinin bakiyesi : ${cari.bakiye}"),
                                                                )
                                                              : Text("")
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 45,
                                                        margin:
                                                            EdgeInsets.all(20),
                                                        child: FlatButton(
                                                          child: Text(''),
                                                          color: Colors.white,
                                                          textColor:
                                                              Colors.white,
                                                          onPressed: () {},
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 45,
                                                        margin:
                                                            EdgeInsets.all(20),
                                                        child: FlatButton(
                                                          child: Text(''),
                                                          color: Colors.white,
                                                          textColor:
                                                              Colors.white,
                                                          onPressed: () {
                                                            //kaydet işlemi yapp
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
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
                                                              "İrsaliyeli Fatura"),
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
                                                              "Irsaliyesiz Alış"),
                                                          value: !irsa,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              irsa = !irsa;
                                                            });
                                                          },
                                                        )),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 45,
                                                        margin:
                                                            EdgeInsets.all(20),
                                                        child: FlatButton(
                                                          child: Text(''),
                                                          color: Colors.white,
                                                          textColor:
                                                              Colors.white,
                                                          onPressed: () {},
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 45,
                                                        margin:
                                                            EdgeInsets.all(20),
                                                        child: FlatButton(
                                                          child: Text(''),
                                                          color: Colors.white,
                                                          textColor:
                                                              Colors.white,
                                                          onPressed: () {
                                                            //kaydet işlemi yapp
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
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
                                                                "Fiş Fatura Tarihi",
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
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black)),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          ListTile(
                                                            title: Text(DateFormat
                                                                    .yMMMd(
                                                                        'tr_TR')
                                                                .format(
                                                                    pickedduztar)),
                                                            //     " ${pickedduztar.year}, ${pickedduztar.month}, ${pickedduztar.day}"),
                                                            trailing: Icon(Icons
                                                                .calendar_today),
                                                            //onTap: _pickDate1,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 45,
                                                        margin:
                                                            EdgeInsets.all(20),
                                                        child: FlatButton(
                                                          child: Text(''),
                                                          color: Colors.white,
                                                          textColor:
                                                              Colors.white,
                                                          onPressed: () {},
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 45,
                                                        margin:
                                                            EdgeInsets.all(20),
                                                        child: FlatButton(
                                                          child: Text(''),
                                                          color: Colors.white,
                                                          textColor:
                                                              Colors.white,
                                                          onPressed: () {
                                                            //kaydet işlemi yapp
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            /*       Padding(
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
                                                            "Fiş Fatura numarası",
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
                                                    onSaved: (s) {
                                                      tahsacik = s ?? "";
                                                    },
                                                    decoration: const InputDecoration(
                                                        border:
                                                            OutlineInputBorder()),
                                                    validator: (value) {
                                                      // validation logic
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 45,
                                                    margin: EdgeInsets.all(20),
                                                    child: FlatButton(
                                                      child: Text(''),
                                                      color: Colors.white,
                                                      textColor: Colors.white,
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 45,
                                                    margin: EdgeInsets.all(20),
                                                    child: FlatButton(
                                                      child: Text(''),
                                                      color: Colors.white,
                                                      textColor: Colors.white,
                                                      onPressed: () {
                                                        //kaydet işlemi yapp
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),*/
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
                                                                "Ödeme Durumu",
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
                                                          title:
                                                              Text("Ödenecek"),
                                                          value: !odendimi,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              odendimi =
                                                                  !odendimi;
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
                                                          title: Text("Ödendi"),
                                                          value: odendimi,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              odendimi =
                                                                  !odendimi;
                                                            });
                                                          },
                                                        )),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 45,
                                                        margin:
                                                            EdgeInsets.all(20),
                                                        child: FlatButton(
                                                          child: Text(''),
                                                          color: Colors.white,
                                                          textColor:
                                                              Colors.white,
                                                          onPressed: () {},
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 45,
                                                        margin:
                                                            EdgeInsets.all(20),
                                                        child: FlatButton(
                                                          child: Text(''),
                                                          color: Colors.white,
                                                          textColor:
                                                              Colors.white,
                                                          onPressed: () {
                                                            //kaydet işlemi yapp
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            odendimi == true
                                                ? Padding(
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
                                                                      "Ödendiği tarih ve hesab",
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
                                                                  title: Text(DateFormat
                                                                          .yMMMd(
                                                                              'tr_TR')
                                                                      .format(
                                                                          pickedDate)),
                                                                  //       " ${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day}"),
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
                                                                    liskd)
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
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 45,
                                                              margin: EdgeInsets
                                                                  .all(20),
                                                              child: FlatButton(
                                                                child: Text(''),
                                                                color: Colors
                                                                    .white,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                onPressed:
                                                                    () {},
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 45,
                                                              margin: EdgeInsets
                                                                  .all(20),
                                                              child: FlatButton(
                                                                child: Text(''),
                                                                color: Colors
                                                                    .white,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                onPressed: () {
                                                                  //kaydet işlemi yapp
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                :
                                                //     Divider(),
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
                                                                      "Ödeneceği Tarih",
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
                                                                  title: Text(DateFormat
                                                                          .yMMMd(
                                                                              'tr_TR')
                                                                      .format(
                                                                          pickedDate)),
                                                                  //    " ${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day}"),
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
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 45,
                                                              margin: EdgeInsets
                                                                  .all(20),
                                                              child: FlatButton(
                                                                child: Text(''),
                                                                color: Colors
                                                                    .white,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                onPressed:
                                                                    () {},
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 45,
                                                              margin: EdgeInsets
                                                                  .all(20),
                                                              child: FlatButton(
                                                                child: Text(''),
                                                                color: Colors
                                                                    .white,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                onPressed: () {
                                                                  //kaydet işlemi yapp
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
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
                                            columns: const <DataColumn>[
                                              DataColumn(
                                                label: Text(
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
                                                        "${urun.verharsat + urun2.verharsat}",
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
                                                        "${urun.kdv + urun2.kdv}",
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
                                                        "${(1 * (urun2.verharsat + (urun2.verharsat * urun2.kdv))) + 1 * (urun.verharsat + (urun.verharsat * urun.kdv))}",
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
                            //    ),
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
