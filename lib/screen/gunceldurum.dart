import 'package:Muhasebe/controller/gdhafta.controller.dart';
import 'package:Muhasebe/controller/gdnuguncontroller.dart';
import 'package:Muhasebe/controller/gunceldurumcontroller.dart';
import 'package:Muhasebe/models/dtogunceldurum.dart';
import 'package:Muhasebe/models/gunceldurummod.dart';
import 'package:Muhasebe/screen/alisfatlist.dart';
import 'package:Muhasebe/screen/kasalist.dart';
import 'package:Muhasebe/screen/satisfatlist.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/screen/satfatrapor.dart';
import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/load.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgloadingalert.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Gunceldurum extends StatefulWidget {
  @override
  _GunceldurumState createState() => _GunceldurumState();
}

class _GunceldurumState extends State<Gunceldurum>
    with TickerProviderStateMixin {
  List<Dtogunceldurum> lis = [];
  bool _isloading = true;
  int touchedIndex;
  num toplamtahsilat = 0.10;
  num toplamodeme = 0.10;
  TabController _tabController;
  num kasabakiye = 0;
  DateTime bugun;
  List<Gunceldurummod> gunceld = [];
  DateTime buay;
  DateTime buhafta;
  DateTime buaysonu;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    /* APIServices.gunceldurumal().then((value) {

      setState(() {
        lis = value;
        for (var x in lis) {
          if (x.fatTur == 0) {
            toplamodeme = toplamodeme + (x.odemtop - x.odemod);
          } else {
            toplamtahsilat = toplamtahsilat + (x.tahstop - x.tahsalin);
          }
        }

        _isloading = false;
      });
    });*/
    bugun = DateTime.now();
    bugun = DateTime(bugun.year, bugun.month, bugun.day);
    buay = DateTime(bugun.year, bugun.month, 1);
    buaysonu = (bugun.month < 12)
        ? new DateTime(bugun.year, bugun.month + 1, 0)
        : new DateTime(bugun.year + 1, 1, 0);
    //buaysonu=DateTime(bugun.year, bugun.month, 30);
    buhafta = DateTime(bugun.year, bugun.month, bugun.day - bugun.weekday + 1);
    Future.wait([
      APIServices.callstp(buay, buaysonu),
      APIServices.kasabakiye(),
      APIServices.gunceldurumal()
    ]).then((value) {
      setState(() {
        print("bb");
        print(value[0].toString());
        gunceld = value[0];
        print(gunceld.length.toString());
        kasabakiye = value[1];
        lis = value[2];
        for (var x in lis) {
          if (x.fatTur == 0) {
            toplamodeme = toplamodeme + (x.odemtop - x.odemod);
          } else {
            toplamtahsilat = toplamtahsilat + (x.tahstop - x.tahsalin);
          }
        }

        _isloading = false;
        _isloading = false;
      });
    });
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
          /*     APIServices.stokdetayfatsatis(widget.ur.barkodno).then((value) {
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
          });*/
        }
        print("setstewf");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body:
            /*LoadingOverlay(
            isLoading: _isloading,
            opacity: 0,
            progressIndicator:
                //CircularProgressIndicator(),
                Wdgloadingalert(wsize: wsize),
            child:*/
            Row(
          children: [
            Container(
                color: Colors.black87,
                width: wsize.width / 5,
                //    height: 500,
                child: Wdgdrawer()),
            Expanded(
              flex: 100, //78,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wdgappbar("Güncel Durum", "", ""),
                  ),

                  /* Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white),
                          height: 175,
                          width: 700,
                          child: Column(
                            children: [
                              Expanded(
                                  child: buildpiechart(
                                      "Toplam Tahsilat", toplamtahsilat, 4.00)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white),
                          height: 175,
                          width: 700,
                          child: Column(
                            children: [
                              Expanded(
                                  child: buildpiechart1(
                                      "Toplam Ödeme", toplamodeme, 4.00)),
                            ],
                          ),
                        ),
                      ),*/
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey.shade200),
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
                                color: Colors.grey), // provides to left side
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
                              text: "BU AY",
                            ),
                          ),
                          Container(
                            width: wsize.width / 3,
                            child: Tab(
                              text: "BU HAFTA",
                            ),
                          ),
                          Container(
                            width: wsize.width / 3,
                            child: Tab(
                              text: "BUGÜN",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /*    _isloading == true
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : */
                  Expanded(
                    child: Container(
                      color: Colors.grey[200],
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
                                  Obx(() {
                                    if (Get.find<Gunceldurumcontroller>()
                                        .isLoading
                                        .value) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return Tabbilgiwdg1(
                                        Get.find<Gunceldurumcontroller>()
                                            .gecicisat,
                                        Get.find<Gunceldurumcontroller>()
                                            .gecicigider,
                                        Get.find<Gunceldurumcontroller>()
                                            .bakiye);
                                  }),
                                  Obx(() {
                                    if (Get.find<Gdhaftacontroller>()
                                        .isLoading
                                        .value) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return Tabbuhafta(
                                        Get.find<Gdhaftacontroller>().gecicisat,
                                        Get.find<Gdhaftacontroller>().bakiye);
                                  }),
                                  Obx(() {
                                    if (Get.find<Gdbuguncontroller>()
                                        .isLoading
                                        .value) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return Tabbugun(
                                        Get.find<Gdbuguncontroller>().gecicisat,
                                        Get.find<Gdbuguncontroller>().bakiye);
                                  }),
                                ]),
                            //    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /*  Expanded(
                flex: 22,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: lis.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                color: lis[index].fatTur == 0
                                    ? Colors.red
                                    : Colors.green,
                                child: ListTile(
                                  title: Text(lis[index]
                                      .fatad), // Text(lis[index].fatTur == 0
                                  // ? "Ödemeler"
                                  //   : "Tahsilat"),
                                  subtitle: Text(lis[index].fatTur == 0
                                      ? lis[index].odenesi
                                      : lis[index].vadesi),
                                  trailing: Text(lis[index].fatTur == 0
                                      ? "{${Load.numfor.format(lis[index].odemtop)}  - ${Load.numfor.format(lis[index].odemod)}"
                                      : "{${Load.numfor.format(lis[index].tahsalin)}  - ${Load.numfor.format(lis[index].tahstop)}"),
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ))*/
          ],
        )
        // )
        );
  }
}

class Tabbilgiwdg extends StatefulWidget {
  final List<Gunceldurummod> guncel;
  final num bak;
  Tabbilgiwdg(this.guncel, this.bak);

  @override
  _TabbilgiwdgState createState() => _TabbilgiwdgState();
}

class _TabbilgiwdgState extends State<Tabbilgiwdg>
    with AutomaticKeepAliveClientMixin {
  List<Gunceldurummod> gecicisat = [];
  List<Gunceldurummod> gecicigider = [];
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("ccv");
    print(widget.guncel.length.toString());
    gecicisat = widget.guncel.length == 0
        ? [Gunceldurummod(22, 2, 2, 2, 1)]
        : widget.guncel.where((i) => i.tur == 1).toList();
    // print(gecicisat[0].fatsayisi);
    gecicigider = widget.guncel.length == 0
        ? [Gunceldurummod(22, 2, 2, 2, 1)]
        : widget.guncel.where((i) => i.tur == 0).toList();
  }

  @override
  Widget build(BuildContext context) {
    gecicisat = widget.guncel.length == 0
        ? [Gunceldurummod(22, 2, 2, 2, 1)]
        : widget.guncel.where((i) => i.tur == 1).toList();
    // print(gecicisat[0].fatsayisi);
    gecicigider = widget.guncel.length == 0
        ? [Gunceldurummod(22, 2, 2, 2, 1)]
        : widget.guncel.where((i) => i.tur == 0).toList();
    return Column(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height / 5,
      ),
      Buildsatbilgi(gecicisat: gecicisat, context: context),
      Buildgiderbilgi(gecicigider: gecicigider, context: context),
      Buildbakiye(context: context, bak: widget.bak),
      // buildsatiscont(context),
    ]);
    // );
  }
}

class Tabbuhafta extends StatefulWidget {
  final List<Gunceldurummod> guncel;
  final num bak;
  Tabbuhafta(this.guncel, this.bak);

  @override
  _TabbuhaftaState createState() => _TabbuhaftaState();
}

class _TabbuhaftaState extends State<Tabbuhafta>
    with AutomaticKeepAliveClientMixin {
  List<Gunceldurummod> gecicisat = [];
  List<Gunceldurummod> gecicigider = [];
  DateTime bugun;
  DateTime buhaftabas;
  DateTime buhaftason;
  bool _isloading = true;
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("xcv");
    bugun = DateTime.now();
    bugun = DateTime(bugun.year, bugun.month, bugun.day);
    buhaftabas =
        DateTime(bugun.year, bugun.month, bugun.day - bugun.weekday + 1);
    buhaftason =
        bugun.add(Duration(days: DateTime.daysPerWeek - bugun.weekday));
    print("haftadaa");
    APIServices.callstp(buhaftabas, buhaftason).then((value) {
      setState(() {
        gecicisat = widget.guncel.length == 0
            ? [Gunceldurummod(22, 2, 2, 2, 1)]
            : value.where((i) => i.tur == 1).toList();
        gecicigider = widget.guncel.length == 0
            ? [Gunceldurummod(22, 2, 2, 2, 1)]
            : value.where((i) => i.tur == 0).toList();
        print("jkl");
        _isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isloading,
      opacity: Load.opacit,
      progressIndicator: Load.prog,
      child: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 5,
        ),
        Buildsatbilgi(gecicisat: gecicisat, context: context),
        Buildgiderbilgi(gecicigider: gecicigider, context: context),
        Buildbakiye(
          context: context,
          bak: widget.bak,
        ),
        // buildsatiscont(context),
      ]),
    );
    // );
  }
}

class Tabbugun extends StatefulWidget {
  final List<Gunceldurummod> guncel;
  final num bak;
  Tabbugun(this.guncel, this.bak);

  @override
  _TabbugunState createState() => _TabbugunState();
}

class _TabbugunState extends State<Tabbugun>
    with AutomaticKeepAliveClientMixin {
  List<Gunceldurummod> gecicisat = [];
  List<Gunceldurummod> gecicigider = [];
  DateTime bugun;
  DateTime bugece;
  DateTime busabah;
  bool _isloading = true;
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bugun = DateTime.now();
    bugun = DateTime(bugun.year, bugun.month, bugun.day);
    bugece = DateTime(bugun.year, bugun.month, bugun.day + 1);
    busabah = DateTime(bugun.year, bugun.month, bugun.day, 0, 0, 0);
    print(busabah.toString());
    print(bugece.toString());
    APIServices.callstp(busabah, bugece).then((value) {
      setState(() {
        gecicisat = widget.guncel.length == 0
            ? [Gunceldurummod(22, 2, 2, 2, 1)]
            : value.where((i) => i.tur == 1).toList();
        gecicigider = widget.guncel.length == 0
            ? [Gunceldurummod(22, 2, 2, 2, 1)]
            : value.where((i) => i.tur == 0).toList();
        _isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isloading,
      opacity: Load.opacit,
      progressIndicator: Load.prog,
      child: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 5,
        ),
        Buildsatbilgi(gecicisat: gecicisat, context: context),
        Buildgiderbilgi(gecicigider: gecicigider, context: context),
        Buildbakiye(
          context: context,
          bak: widget.bak,
        ),
        // buildsatiscont(context),
      ]),
    );
    // );
  }
}

class Buildgiderbilgi extends StatelessWidget {
  Buildgiderbilgi({
    Key key,
    @required this.gecicigider,
    @required this.context,
  }) : super(key: key);

  final List<Gunceldurummod> gecicigider;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Card(
              elevation: 0,
              margin: new EdgeInsets.symmetric(vertical: 1.0 //horizontal:10
                  ),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200]), //Color.fromRGBO(64, 75, 96, .9)),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Alisfatli()),
                    );
                  },
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      FontAwesomeIcons.arrowUp,
                      size: 18,
                      color: Colors.red,
                    ),
                  ),
                  title: Text("GİDERLER", style: Load.font(2)),
                  subtitle: Text(gecicigider.length == 0
                      ? "0 FATURA"
                      : "${gecicigider[0].fatsayisi} FATURA"),

                  //  subtitle: ,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          gecicigider.length == 0
                              ? "0"
                              : Load.numfor.format((gecicigider[0].toplammiktar
                                  //+ gecicigider[1].toplammiktar
                                  )
                                  .round()), //"${gecicigider[0].toplammiktar + gecicigider[1].toplammiktar}",
                          style: Load.font(2)),
                      Icon(FontAwesomeIcons.liraSign,
                          size: 12, color: Colors.red)
                    ],
                  ),
                ),
              ))),
    );
  }
}

class Buildsatbilgi extends StatelessWidget {
  Buildsatbilgi({
    Key key,
    @required this.gecicisat,
    @required this.context,
  }) : super(key: key);

  final List<Gunceldurummod> gecicisat;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Card(
              elevation: 0,
              margin: new EdgeInsets.symmetric(vertical: 1.0 //horizontal:10
                  ),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200]), //Color.fromRGBO(64, 75, 96, .9)),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Satisfatli()),
                    );
                  },
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      FontAwesomeIcons.arrowDown,
                      size: 18,
                      color: Colors.blueAccent,
                    ),
                  ),
                  title: Text("SATIŞLAR", style: Load.font(3)),
                  subtitle: Text(gecicisat.length == 0
                      ? "0 FATURA"
                      : "${gecicisat[0].fatsayisi} FATURA"),

                  //  subtitle: ,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        gecicisat.length == 0
                            ? "0"
                            : Load.numfor.format((gecicisat[0].toplammiktar
                                // +    gecicisat[1].toplammiktar
                                )
                                .round()), //"${gecicisat[0].toplammiktar + gecicisat[1].toplammiktar}",
                        style: Load.font(3),
                      ),
                      Icon(FontAwesomeIcons.liraSign,
                          size: 12, color: Colors.blue)
                    ],
                  ),
                ),
              ))),
    );
  }
}

class Buildbakiye extends StatelessWidget {
  const Buildbakiye({
    Key key,
    @required this.context,
    @required this.bak,
  }) : super(key: key);

  final BuildContext context;

  final num bak;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Card(
              elevation: 0,
              margin: new EdgeInsets.symmetric(vertical: 1.0 //horizontal:10
                  ),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200]), //Color.fromRGBO(64, 75, 96, .9)),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Kasali()),
                    );
                  },
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      FontAwesomeIcons.moneyBill,
                      size: 18,
                      color: Colors.green,
                    ),
                  ),
                  title: Text("GÜNCEL BAKİYE",
                      style: TextStyle(color: Colors.green)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "$bak",
                        style: TextStyle(color: Colors.green),
                      ),
                      Icon(FontAwesomeIcons.liraSign,
                          size: 12, color: Colors.green)
                    ],
                  ),
                ),
              ))),
    );
  }
}
/*

  AspectRatio buildpiechart(String text, num a, num b) {
    String k = "$a";
    String l = "$b";
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Text(text),
            Expanded(
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    height: 9,
                  ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                            pieTouchData:
                                PieTouchData(touchCallback: (pieTouchResponse) {
                              setState(() {
                                final desiredTouch = pieTouchResponse.touchInput
                                        is! PointerExitEvent &&
                                    pieTouchResponse.touchInput
                                        is! PointerUpEvent;
                                if (desiredTouch &&
                                    pieTouchResponse.touchedSection != null) {
                                  touchedIndex =
                                      pieTouchResponse.touchedSectionIndex;
                                } else {
                                  touchedIndex = -1;
                                }
                              });
                            }),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            sections: showingSections(a.round(), b.round())),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Indicator(
                        color: Color(0xff0293ee),
                        text: "Toplam Tahsilat (${a.toInt()})",
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Color(0xfff8b250),
                        text: 'Gecikmiş (${b.toInt()})',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(num x, num y) {
    num z = x - y / x;
    num m = y / x;
    String k = "$z";
    String l = "$m";
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 20 : 15;
      switch (i) {
        case 0:
          return PieChartSectionData(
              color: const Color(0xff0293ee),
              value: x,
              title: "%${z.toInt()}",
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black) // const Color(0xffffffff)),
              );
        case 1:
          return PieChartSectionData(
              color: const Color(0xfff8b250),
              value: y,
              title: "%${m.toInt()}",
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black) //const Color(0xffffffff)),
              );

        default:
          return null;
      }
    });
  }

  AspectRatio buildpiechart1(String text, num a, num b) {
    String k = "$a";
    String l = "$b";
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Text(text),
            Expanded(
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    height: 9,
                  ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                            pieTouchData:
                                PieTouchData(touchCallback: (pieTouchResponse) {
                              setState(() {
                                final desiredTouch = pieTouchResponse.touchInput
                                        is! PointerExitEvent &&
                                    pieTouchResponse.touchInput
                                        is! PointerUpEvent;
                                if (desiredTouch &&
                                    pieTouchResponse.touchedSection != null) {
                                  touchedIndex =
                                      pieTouchResponse.touchedSectionIndex;
                                } else {
                                  touchedIndex = -1;
                                }
                              });
                            }),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            sections: showingSections1(a, b)),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Indicator(
                        color: Color(0xff0293ee),
                        text: "Toplam Ödeme (${a.toInt()})",
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Color(0xfff8b250),
                        text: 'Gecikmiş Ödeme (${b.toInt()})',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections1(num x, num y) {
    num z = x - y / x;
    num m = y / x;
    String k = "$z";
    String l = "$m";
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 20 : 15;
      switch (i) {
        case 0:
          return PieChartSectionData(
              color: const Color(0xff0293ee),
              value: x,
              title: "%${z.toInt()}",
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black) // const Color(0xffffffff)),
              );
        case 1:
          return PieChartSectionData(
              color: const Color(0xfff8b250),
              value: y,
              title: "%${m.toInt()}",
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black) //const Color(0xffffffff)),
              );

        default:
          return null;
      }
    });
  }
}
*/
