import 'dart:io';

import 'package:Muhasebe/ui/addproduct_ui.dart';
import 'package:Muhasebe/ui/gunceldurum.dart';
import 'package:Muhasebe/utils/createpdf.dart';
import 'package:Muhasebe/ui/dinamikui.dart';
import 'package:Muhasebe/ui/giderbuton.dart';
import 'package:Muhasebe/ui/kasalistesi.dart';
import 'package:Muhasebe/ui/nakitbuton.dart';
import 'package:Muhasebe/ui/product_detail_ui.dart';
import 'package:Muhasebe/ui/satisbuton.dart';
import 'package:Muhasebe/ui/satisfatlist.dart';
import 'package:Muhasebe/ui/stokbuton.dart';
import 'package:Muhasebe/ui/stokgecmisiui.dart';
import 'package:Muhasebe/ui/stokrapor.dart';
import 'package:Muhasebe/ui/urunler_ui.dart';
import 'package:Muhasebe/ui/yenikasaui.dart';
import 'package:Muhasebe/ui/satfatrapor.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:vertical_navigation_bar/vertical_navigation_bar.dart';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

/*
var platformName = '';
if (kIsWeb) {
  platformName = "Web";
} else {
  if (Platform.isAndroid) {
    platformName = "Android";
  } else if (Platform.isIOS) {
    platformName = "IOS";
  } else if (Platform.isFuchsia) {
    platformName = "Fuchsia";
  } else if (Platform.isLinux) {
    platformName = "Linux";
  } else if (Platform.isMacOS) {
    platformName = "MacOS";
  } else if (Platform.isWindows) {
    platformName = "Windows";
  }
}
print("platformName :- "+platformName.toString())*/

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('tr');
    return MaterialApp(
      title: 'Vertical navigation bar demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Gunceldurum(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final pageController = PageController(initialPage: 0, keepPage: true);

  final navItems = [
    SideNavigationItem(icon: Icons.ac_unit, title: "Faturalar"),
    SideNavigationItem(icon: Icons.access_alarm_rounded, title: "Giderler "),
    SideNavigationItem(icon: Icons.access_alarm_rounded, title: "Nakitler"),
    SideNavigationItem(
        icon: Icons.access_alarm_rounded, title: "Hizmet ve Ürünler")
  ];
  final initialTab = 0;

  @override
  Widget build(BuildContext context) {
    print("buildde");
    return Scaffold(
      body: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 6,
            child: SideNavigation(
              navItems: this.navItems,
              itemSelected: (index) {
                pageController.animateToPage(index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear);
              },
              initialIndex: 0,
              actions: <Widget>[],
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              children: [Satisbuton(), Giderbuton(), Nakitbuton(), Stokbuton()],
            ),
          )
        ],
      ),
    );
  }
}

class Syf1 extends StatefulWidget {
  const Syf1({
    Key key,
  }) : super(key: key);

  @override
  _Syf1State createState() => _Syf1State();
}

class _Syf1State extends State<Syf1> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    print("fsdd");
    return Container(
        color: Colors.blueGrey.withOpacity(0.1),
        child: Center(
          child: Text("Page 1"),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

class Syf2 extends StatefulWidget {
  const Syf2({
    Key key,
  }) : super(key: key);

  @override
  _Syf2State createState() => _Syf2State();
}

class _Syf2State extends State<Syf2> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    print("hgjhg");
    return Container(
        color: Colors.blueGrey.withOpacity(0.1),
        child: Center(
          child: Text("Page 2"),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
