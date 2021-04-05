import 'dart:math';
import 'package:Muhasebe/models/dtourungecmisi.dart';
import 'package:Muhasebe/ui/satisfaticinurun.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class Satfatrapor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SatfatraporState();
}

class SatfatraporState extends State with TickerProviderStateMixin {
  int touchedIndex;
  static const double barWidth = 22;
  DateTime baslangictar = DateTime.now();
  DateTime bitistar = DateTime.now();
  List<charts.Series> seriesList;
  List<Dtourungecmisi> lis = [];
  TabController _tabController;

  static List<charts.Series<Sales, String>> _createRandomData() {
    final random = Random();

    final desktopSalesData = [
      Sales('2015', random.nextInt(100)),
      Sales('2016', random.nextInt(100)),
      Sales('2017', random.nextInt(100)),
      Sales('2018', -12),
      Sales('2019', random.nextInt(100)),
    ];

    return [
      charts.Series<Sales, String>(
        id: 'Sales',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: desktopSalesData,
        fillColorFn: (Sales sales, _) {
          return charts.MaterialPalette.blue.shadeDefault;
        },
      )
    ];
  }

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
    super.initState();
    seriesList = _createRandomData();
    _tabController = new TabController(length: 3, vsync: this);
  }

  barChart() {
    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: true,
    );
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
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey.shade300,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: "Satışlar Raporu",
                  style: TextStyle(color: Colors.grey, fontSize: 24),
                  children: <TextSpan>[
                    TextSpan(
                        text: "",
                        style: TextStyle(color: Colors.black, fontSize: 24)
                        //       fontWeight:
                        //              FontWeight.w300)
                        ),
                  ],
                ),
              ),
              Text(
                "Ahmet Seç",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0, // fontWeight: FontWeight.bold
                ),
              ),
            ],
          )),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
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
                        "Satış Faturaları",
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
                          onPressed: () {},
                          child: Text(
                            "Uygula",
                            style: TextStyle(fontSize: 18),
                          ))
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
                height: 175,
                child: Row(
                  children: [
                    Expanded(child: buildpiechart("Fatura Kategorileri")),
                    Expanded(child: buildpiechart("Müşteri Kategorileri")),
                    Expanded(child: buildpiechart("Ürün Kategorileri")),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Satışların Dağılımı",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
                height: 250,
                child: barChart(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${baslangictar.year}, ${baslangictar.month}, ${baslangictar.day} - ${bitistar.year}, ${bitistar.month}, ${bitistar.day} ",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.grey.shade100),
                        //  height: 60,
                        width: wsize / 2,
                        //      margin: EdgeInsets.only(left: 60),
                        child: TabBar(
                          tabs: [
                            Container(
                              width: 35.0,
                              child: Text(
                                'Faturalar',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Container(
                              width: 35.0,
                              child: Text(
                                'Müşteriler',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Container(
                              width: 35.0,
                              child: Text(
                                'Ürünler',
                                style: TextStyle(fontSize: 12),
                              ),
                            )
                          ],
                          unselectedLabelColor:
                              Colors.grey, //   const Color(0xffacb3bf),
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
                                        MaterialStateColor.resolveWith(
                                            (states) => Colors.grey.shade200),
                                    columns: const <DataColumn>[
                                      DataColumn(
                                        label: Text(
                                          'Fatura Açıklaması',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Düzenlenme Tarihi',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Bakiye',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
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
                                                              Satfatdetailicinurun(
                                                                  e.fatid)),
                                                    );
                                                  },
                                                  child: Text(
                                                      e.fattur.toString()))),
                                              DataCell(Text(
                                                e.cariad.toString(),
                                                style: TextStyle(),
                                              )),
                                              DataCell(Text(
                                                e.duzenlemetarih.toString(),
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
            )
          ],
        ),
      ),
    );
  }

  AspectRatio buildpiechart(String text) {
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
                            sections: showingSections()),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Indicator(
                        color: Color(0xff0293ee),
                        text: 'Kategori 1',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Color(0xfff8b250),
                        text: 'Kategori 2',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Color(0xff845bef),
                        text: 'Kategori 3',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Color(0xff13d38e),
                        text: 'Kategori 4',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 9,
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

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 20 : 15;
      switch (i) {
        case 0:
          return PieChartSectionData(
              color: const Color(0xff0293ee),
              value: 40,
              title: '40%',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black) // const Color(0xffffffff)),
              );
        case 1:
          return PieChartSectionData(
              color: const Color(0xfff8b250),
              value: 30,
              title: '30%',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black) //const Color(0xffffffff)),
              );
        case 2:
          return PieChartSectionData(
              color: const Color(0xff845bef),
              value: 15,
              title: '15%',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black) //const Color(0xffffffff)),
              );
        case 3:
          return PieChartSectionData(
              color: const Color(0xff13d38e),
              value: 15,
              title: '15%',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black) // const Color(0xffffffff)),
              );
        default:
          return null;
      }
    });
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key key,
    this.color,
    this.text,
    this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 4, //size,
          height: 4, //size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}

class Sales {
  final String year;
  final int sales;

  Sales(this.year, this.sales);
}
