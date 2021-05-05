import 'dart:io';

import 'package:Muhasebe/ui/addproduct_ui.dart';
import 'package:Muhasebe/ui/gunceldurum.dart';
import 'package:Muhasebe/ui/irsaliyecarisec.dart';
import 'package:Muhasebe/ui/isloginui.dart';
import 'package:Muhasebe/ui/loginpage.dart';
import 'package:Muhasebe/ui/test.dart';
import 'package:Muhasebe/utils/createpdf.dart';
import 'package:Muhasebe/ui/kasalistesi.dart';
import 'package:Muhasebe/ui/product_detail_ui.dart';

import 'package:Muhasebe/ui/satisfatlist.dart';
import 'package:Muhasebe/ui/stokgecmisiui.dart';
import 'package:Muhasebe/ui/stokrapor.dart';
import 'package:Muhasebe/ui/urunler_ui.dart';
import 'package:Muhasebe/ui/yenikasaui.dart';
import 'package:Muhasebe/ui/satfatrapor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'dart:io' show Platform;
//import 'package:flutter/foundation.dart' show kIsWeb;

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

/*void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}*/
Future<void> main() async {
  HttpOverrides.global = new MyHttpOverrides();
  //WidgetsFlutterBinding.ensureInitialized();
  //SharedPreferences sp = await SharedPreferences.getInstance();
  // var islog = sp.getBool("islogin");

  runApp(MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('tr'), // English, no country code
      ],
      locale: const Locale('tr'),
      debugShowCheckedModeBanner: false,
      title: 'Muhasebe',
      //  initialRoute: '/urunler',
      //routes: {
      //  '/login': (context) => Loginpage(),
      //    '/urunler': (context) => UrunlerUi()
      //},
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UrunlerUi() //islog == true ? UrunlerUi() : Loginpage(),
      ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // initializeDateFormatting('tr');
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('tr'), // English, no country code
      ],
      locale: const Locale('tr'),
      debugShowCheckedModeBanner: false,
      title: 'Muhasebe',
      //  initialRoute: '/urunler',
      //routes: {
      //  '/login': (context) => Loginpage(),
      //    '/urunler': (context) => UrunlerUi()
      //},
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Islogin(),
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
