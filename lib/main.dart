import 'package:Muhasebe/ui/addproduct_ui.dart';
import 'package:Muhasebe/ui/product_detail_ui.dart';
import 'package:Muhasebe/ui/urunler_ui.dart';
import 'package:flutter/material.dart';
import 'package:vertical_navigation_bar/vertical_navigation_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vertical navigation bar demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final pageController = PageController(initialPage: 0, keepPage: true);

  final navItems = [
    SideNavigationItem(icon: Icons.ac_unit, title: "Hizmet ve Ürünler"),
    SideNavigationItem(icon: Icons.access_alarm_rounded, title: "Ürün Ekle "),
    SideNavigationItem(
        icon: Icons.access_alarm_rounded, title: "Ürün Ayrıntıları"),
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
              children: [UrunlerUi(), AddProdForm(), ProdDetailui()],
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
