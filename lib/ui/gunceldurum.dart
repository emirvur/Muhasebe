import 'package:Muhasebe/models/dtogunceldurum.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:Muhasebe/ui/satfatrapor.dart';
import 'package:Muhasebe/utils/Wdgdrawer.dart';
import 'package:Muhasebe/utils/wdgappbar.dart';
import 'package:Muhasebe/utils/wdgloadingalert.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Gunceldurum extends StatefulWidget {
  @override
  _GunceldurumState createState() => _GunceldurumState();
}

class _GunceldurumState extends State<Gunceldurum> {
  List<Dtogunceldurum> lis = [];
  bool _isloading = true;
  int touchedIndex;
  num toplamtahsilat = 0.10;
  num toplamodeme = 0.10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    APIServices.gunceldurumal().then((value) {
      print("yy");
      print(value.toString());
      print("qq");
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
    });
  }

  @override
  Widget build(BuildContext context) {
    final wsize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        /*   appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey.shade300,
            title: Wdgappbar("Güncel Durum", "", "Ahmet Seç")),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors
                .black87, //This will change the drawer background to blue.
            //other styles
          ),
          child: Drawer(child: Wdgdrawer()),
        ),*/
        body: LoadingOverlay(
            isLoading: _isloading,
            opacity: 0,
            progressIndicator: Wdgloadingalert(wsize: wsize),
            child: Row(
              children: [
                Container(
                    color: Colors.black87,
                    width: wsize.width / 5,
                    //    height: 500,
                    child: Wdgdrawer()),
                Expanded(
                  flex: 78,
                  child: Column(
                    children: [
                      Wdgappbar("wwww", "gggg", "qqqsw"),
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
                    ],
                  ),
                ),
                Expanded(
                    flex: 22,
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
                                    title: Text(lis[index].fatTur == 0
                                        ? "Ödemeler"
                                        : "Tahsilat"),
                                    subtitle: Text(lis[index].fatTur == 0
                                        ? lis[index].odenesi
                                        : lis[index].vadesi),
                                    trailing: Text(lis[index].fatTur == 0
                                        ? "${lis[index].odemtop - lis[index].odemod}"
                                        : "${lis[index].tahsalin - lis[index].tahstop}"),
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
                    ))
              ],
            )));
  }

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
