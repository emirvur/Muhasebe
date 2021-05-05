import 'dart:convert';
import 'dart:io';
import 'package:Muhasebe/models/cari.dart';
import 'package:Muhasebe/models/dtocarilist.dart';
import 'package:Muhasebe/models/dtofatode.dart';
import 'package:Muhasebe/models/dtofattahs.dart';
import 'package:Muhasebe/models/dtogunceldurum.dart';
import 'package:Muhasebe/models/dtoirsaliye.dart';
import 'package:Muhasebe/models/dtoirsurunhar.dart';
import 'package:Muhasebe/models/dtokasahars.dart';
import 'package:Muhasebe/models/dtoodeharfat.dart';
import 'package:Muhasebe/models/dtostokdetay.dart';
import 'package:Muhasebe/models/dtostokgecmisi.dart';
import 'package:Muhasebe/models/dtotahsharfat.dart';
import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/dtourungecmisi.dart';
import 'package:Muhasebe/models/dtourunhareket.dart';
import 'package:Muhasebe/models/fatura.dart';
import 'package:Muhasebe/models/kasa.dart';
import 'package:Muhasebe/models/kasahar.dart';
import 'package:Muhasebe/models/odeput.dart';
import 'package:Muhasebe/models/postfat.dart';
import 'package:Muhasebe/models/postirsaliye.dart';
import 'package:Muhasebe/models/stokrapor.dart';
import 'package:Muhasebe/models/tahsilat.dart';
import 'package:Muhasebe/models/tahsput.dart';
import 'package:Muhasebe/models/urun.dart';
import 'package:Muhasebe/models/urunhareket.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class APIServices {
/* 
todo 1. kullanıcı eklede 500 status codeu duzelt
*/

  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  static String url =
      // Platform.isAndroid
      //? "https://192.168.1.103:45455"
      //:
      //  "https://localhost:44311";
      "https://192.168.1.103:45455";
  //"https://localhost:44311";

  static Future<bool> urunekle(Urun urun) async {
    print("girdiii urun ekleye");
    var maps = json.encode(urun.toMap());
    print(maps.toString());

    var res = await http.post("$url/api/uruns", headers: header, body: maps);
    print(res.statusCode.toString());
    debugPrint("resten sonra");
    if (res.statusCode != 201) {
      throw Exception;
    }
    return Future.value(
        res.statusCode == 200 || res.statusCode == 201 ? true : false);
  }

  static Future urungenelgecmisial() async {
    print("urungecmis al baslıyr");

    http.Response res = await http.get("$url/api/urunharekets/g");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtostokgecmisi> list = [];
    for (var l in re) {
      list.add(Dtostokgecmisi.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future detayirsal(int id) async {
    print("rsaliye al baslıyr");

    http.Response res = await http.get("$url/api/urunharekets/i/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtoirsurunhar> list = [];
    for (var l in re) {
      list.add(Dtoirsurunhar.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future irsaliyeal() async {
    print("rsaliye al baslıyr");

    http.Response res = await http.get("$url/api/irsaliyes/i");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtoirsaliye> list = [];
    for (var l in re) {
      list.add(Dtoirsaliye.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future tarihliirsaliyeal(String ilktar, String sontar) async {
    print("rsaliye al baslıyr");

    http.Response res = await http.get("$url/api/irsaliyes/$ilktar/$sontar");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtoirsaliye> list = [];
    for (var l in re) {
      list.add(Dtoirsaliye.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future urungecmisial(int x) async {
    print("urungecmis al baslıyr");

    http.Response res = await http.get("$url/api/urunharekets/b/$x");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtourungecmisi> list = [];
    for (var l in re) {
      list.add(Dtourungecmisi.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future carisatfatal(int id) async {
    print("satfatall al baslıyr");

    http.Response res = await http.get("$url/api/faturas/c/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future carialfatal(int id) async {
    print("satfatall al baslıyr");

    http.Response res = await http.get("$url/api/faturas/oc/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future satfatal() async {
    print("satfatall al baslıyr");

    http.Response res = await http.get("$url/api/faturas/lt");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future satfatalacikfat() async {
    print("satfatall al baslıyr");

    http.Response res = await http.get("$url/api/faturas/lt/at");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future satfatalkapali() async {
    print("satfatall al baslıyr");

    http.Response res = await http.get("$url/api/faturas/lt/kt");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future satfatalvadeac() async {
    print("satfatall al baslıyr");

    http.Response res = await http.get("$url/api/faturas/lt/vt/ac");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future satfatalvadca() async {
    print("satfatall al baslıyr");

    http.Response res = await http.get("$url/api/faturas/lt/vt/ca");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future satfatalduzac() async {
    print("satfatall al baslıyr");

    http.Response res = await http.get("$url/api/faturas/lt/dt/ac");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future satfatalduzca() async {
    print("satfatall al baslıyr");

    http.Response res = await http.get("$url/api/faturas/lt/dt/ca");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future satcarifatal(int id) async {
    print("satfatall al baslıyr");

    http.Response res = await http.get("$url/api/faturas/lt/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future satcariacikfatal(int id) async {
    print("satfatall al baslıyr");

    http.Response res = await http.get("$url/api/faturas/lt/a/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future odefatal() async {
    print("satfatall al baslıyr");

    http.Response res = await http.get("$url/api/faturas/od");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future odefatalacik() async {
    print("satfatall al baslıyr");

    http.Response res = await http.get("$url/api/faturas/od/a");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future odefatalkapali() async {
    print("satfatall al baslıyr");

    http.Response res = await http.get("$url/api/faturas/od/k");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future odefatalduzac() async {
    print("satfatall al baslıyr");

    http.Response res = await http.get("$url/api/faturas/od/dt/ac");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future odefatalduzca() async {
    print("satfatall al baslıyr");

    http.Response res = await http.get("$url/api/faturas/od/dt/ca");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future odefataltedac() async {
    print("satfatall al baslıyr");

    http.Response res = await http.get("$url/api/faturas/od/tt/ac");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future odefataltedca() async {
    print("satfatall al baslıyr");

    http.Response res = await http.get("$url/api/faturas/od/tt/ca");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future odecarifatal(int id) async {
    print("satfatall al baslıyr");

    http.Response res = await http.get("$url/api/faturas/od/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future odecariacikfatal(int id) async {
    print("satfatall al baslıyr");

    http.Response res = await http.get("$url/api/faturas/od/a/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future fatuurundetay(int id) async {
    print("fayurungdd al baslıyr");

    http.Response res = await http.get("$url/api/urunharekets/f/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtourunhareket> list = [];
    for (var l in re) {
      list.add(Dtourunhareket.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future alfatdetayal(int id) async {
    print("satfatall al baslıyr");

    http.Response res = await http.get("$url/api/faturas/o/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);
    print("ikinci sama");

    print("sorual bitii");
    return Dtofatode.fromMap(re);

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future satfatdetayal(int id) async {
    print("satfatall al baslıyr");

    http.Response res = await http.get("$url/api/faturas/t/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);
    print("ikinci sama");

    print("sorual bitii");
    return Dtofattahs.fromMap(re);

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future raporsatfattaral(DateTime bir, DateTime iki) async {
    print("satfatall al baslıyr");

    http.Response res = await http.get("$url/api/faturas/rap/$bir/$iki");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);
    print("ikinci sama");
    print(re.toString());
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }

    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future raporalfattaral(DateTime bir, DateTime iki) async {
    print("satfatall al baslıyr");

    http.Response res = await http.get("$url/api/faturas/alrap/$bir/$iki");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);
    print("ikinci sama");
    print(re.toString());
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }

    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future stokraporal() async {
    print("strap al baslıyr");

    http.Response res = await http.get("$url/api/uruns/r");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    //  List re = json.decode(res.body);
    var re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    //  List<Stokrapor> list = [];
    //for (var l in re) {
    //  list.add(Stokrapor.fromMap(l));
    //}
    return Stokrapor.fromMap(re);
    //print("sorual bitii");
    //  return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future urunal() async {
    print("urun al baslıyr");

    http.Response res = await http.get("$url/api/uruns");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtourun> list = [];
    for (var l in re) {
      list.add(Dtourun.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future urunalazdancoga() async {
    print("urun al baslıyr");

    http.Response res = await http.get("$url/api/uruns/ac");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtourun> list = [];
    for (var l in re) {
      list.add(Dtourun.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future urunalcoktanaza() async {
    print("urun al baslıyr");

    http.Response res = await http.get("$url/api/uruns/ca");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtourun> list = [];
    for (var l in re) {
      list.add(Dtourun.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future kasalistal() async {
    print("kas al baslıyr");

    http.Response res = await http.get("$url/api/kasas");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Kasa> list = [];
    for (var l in re) {
      list.add(Kasa.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future kasahar(int id) async {
    print("kasahar ara baslıyr");

    http.Response res = await http.get("$url/api/kasahars/t/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtokasahar> list = [];
    for (var l in re) {
      list.add(Dtokasahar.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future tahsharfaticin(int id) async {
    print("ctahsfssari ara baslıyr");

    http.Response res = await http.get("$url/api/tahshars/f/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtotahsharfat> list = [];
    for (var l in re) {
      list.add(Dtotahsharfat.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future odeharfaticin(int id) async {
    print("odeharfaticin ara baslıyr");

    http.Response res = await http.get("$url/api/odehars/f/$id");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("testt sama");
    print("$re");
    List<Dtoodeharfat> list = [];
    for (var l in re) {
      list.add(Dtoodeharfat.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future mustara(String ara) async {
    print("cari ara baslıyr");

    http.Response res = await http.get("$url/api/caris/m/$ara");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Cari> list = [];
    for (var l in re) {
      list.add(Cari.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future tedara(String ara) async {
    print("cari ara baslıyr");

    http.Response res = await http.get("$url/api/caris/t/$ara");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Cari> list = [];
    for (var l in re) {
      list.add(Cari.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future carisatara(int id, String ara) async {
    print("fat ara baslıyr");

    http.Response res = await http.get("$url/api/faturas/c/$id/$ara");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future satfatara(String ara) async {
    print("fat ara baslıyr");

    http.Response res = await http.get("$url/api/faturas/s/$ara");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future alisfatara(String ara) async {
    print("fat ara baslıyr");

    http.Response res = await http.get("$url/api/faturas/a/$ara");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future carialara(int id, String ara) async {
    print("fat ara baslıyr");

    http.Response res = await http.get("$url/api/faturas/a/$id/$ara");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future urunara(String ara) async {
    print("urun ara baslıyr");

    http.Response res = await http.get("$url/api/uruns/a/$ara");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtourun> list = [];
    for (var l in re) {
      list.add(Dtourun.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future<bool> kasaharekle(Kasahar pf) async {
    print("girdiii fat ekleye");
    var maps = json.encode(pf.toMap());
    print(maps.toString());

    var res = await http.post("$url/api/kasahars", headers: header, body: maps);
    print(res.statusCode.toString());
    debugPrint("resten sonra");
    if (res.statusCode != 201) {
      throw Exception;
    }
    return Future.value(
        res.statusCode == 200 || res.statusCode == 201 ? true : false);
  }

  static Future<bool> faturaekle(Postfatura pf) async {
    print("girdiii fat ekleye");
    //  var maps = json.encode(pf.toMap());
    var maps = json.encode(pf.toJson());
    print(maps.toString());

    var res = await http.post("$url/api/faturas", headers: header, body: maps);
    print(res.statusCode.toString());
    debugPrint("resten sonra");
    if (res.statusCode != 201) {
      throw Exception;
    }
    return Future.value(
        res.statusCode == 200 || res.statusCode == 201 ? true : false);
  }

  static Future<bool> irsaliyeekle(Postirsaliye pf) async {
    print("girdiii fat ekleye");
    //  var maps = json.encode(pf.toMap());
    var maps = json.encode(pf.toJson());
    print(maps.toString());

    var res =
        await http.post("$url/api/irsaliyes", headers: header, body: maps);
    print(res.statusCode.toString());
    debugPrint("resten sonra");
    if (res.statusCode != 200) {
      throw Exception;
    }
    return Future.value(
        res.statusCode == 200 || res.statusCode == 201 ? true : false);
  }

  static Future<bool> urunhareketekle(List<Urunhareket> pf) async {
    print("girdiii fat ekleye");
    var maps = json.encode(List<dynamic>.from(pf.map((x) => x.toMap())));
    print(maps.toString());

    var res =
        await http.post("$url/api/urunharekets", headers: header, body: maps);
    print(res.statusCode.toString());
    debugPrint("resten sonra");
    if (res.statusCode != 200) {
      throw Exception;
    }
    return Future.value(
        res.statusCode == 200 || res.statusCode == 201 ? true : false);
  }

  static Future<bool> tahsharguncelle(Tahsput pf) async {
    print("girdiii fat ekleye");
    var maps = json.encode(pf.toMap());
    print(maps.toString());

    var res = await http.put("$url/api/tahsilats", headers: header, body: maps);
    print(res.statusCode.toString());
    debugPrint("resten sonra");
    if (res.statusCode != 200) {
      throw Exception;
    }
    return Future.value(
        res.statusCode == 200 || res.statusCode == 201 ? true : false);
  }

  static Future<bool> urharfatidekle(int fid, int irsid) async {
    print("girdiii fat ekleye");
    var x = Map<String, dynamic>();
    //  map['cariId'] = cariId;
    x['fid'] = fid;
    x['irsid'] = irsid;
    var maps = json.encode(x);
    print(maps.toString());

    var res = await http.put("$url/api/urunharekets/i/$fid/$irsid",
        headers: header, body: maps);
    print(res.statusCode.toString());
    debugPrint("resten sonra");
    if (res.statusCode != 200) {
      throw Exception;
    }
    return Future.value(
        res.statusCode == 200 || res.statusCode == 201 ? true : false);
  }

  static Future<int> irsifatyap(int id, String ilkt, String sont) async {
    print("girdiii fat ekleye");
    var x = Map<String, dynamic>();
    //  map['cariId'] = cariId;
    x['id'] = id;
    var maps = json.encode(x);
    print(maps.toString());

    var res = await http.put("$url/api/irsaliyes/$id/$ilkt/$sont",
        headers: header, body: maps);
    print(res.statusCode.toString());
    debugPrint("resten sonra");
    if (res.statusCode != 200) {
      throw Exception;
    }
    print(res.body.toString());
    print("fff");

    return Future.value(res.statusCode == 200 || res.statusCode == 201
        ? 1 //int.tryParse(res.body)
        : -1);
  }

  static Future<bool> odeharguncelle(Odeput pf) async {
    print("girdiii fat ekleye");
    var maps = json.encode(pf.toMap());
    print(maps.toString());

    var res = await http.put("$url/api/odemelers", headers: header, body: maps);
    print(res.statusCode.toString());
    debugPrint("resten sonra");
    if (res.statusCode != 200) {
      throw Exception;
    }
    return Future.value(
        res.statusCode == 200 || res.statusCode == 201 ? true : false);
  }

  static Future<bool> kasaekle(Kasa kasa) async {
    print("girdiii kasa ekleye");
    var maps = json.encode(kasa.toMap());
    print(maps.toString());

    var res = await http.post("$url/api/kasas", headers: header, body: maps);
    print(res.statusCode.toString());
    debugPrint("resten sonra");
    if (res.statusCode != 201) {
      throw Exception;
    }
    return Future.value(
        res.statusCode == 200 || res.statusCode == 201 ? true : false);
  }

  static Future<bool> musteriekle(Cari kasa) async {
    print("girdiii kasa ekleye");
    var maps = json.encode(kasa.toMap(1));
    print(maps.toString());

    var res = await http.post("$url/api/caris", headers: header, body: maps);
    print(res.statusCode.toString());
    debugPrint("resten sonra");
    if (res.statusCode != 201) {
      throw Exception;
    }
    return Future.value(
        res.statusCode == 200 || res.statusCode == 201 ? true : false);
  }

  static Future<bool> tedarekl(Cari kasa) async {
    print("girdiii kasa ekleye");
    var maps = json.encode(kasa.toMap(2));
    print(maps.toString());

    var res = await http.post("$url/api/caris", headers: header, body: maps);
    print(res.statusCode.toString());
    debugPrint("resten sonra");
    if (res.statusCode != 201) {
      throw Exception;
    }
    return Future.value(
        res.statusCode == 200 || res.statusCode == 201 ? true : false);
  }

  static Future gunceldurumal() async {
    print("musteri al baslıyr");

    http.Response res = await http.get("$url/api/faturas/gd");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtogunceldurum> list = [];
    for (var l in re) {
      list.add(Dtogunceldurum.fromMap(l));
    }

    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future stokdetayfatsatis(int x) async {
    print("musteri al baslıyr");

    http.Response res = await http.get("$url/api/urunharekets/st/$x");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtostokdetay> list = [];
    for (var l in re) {
      list.add(Dtostokdetay.fromMap(l));
    }

    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future stokdetayfatalis(int x) async {
    print("musteri al baslıyr");

    http.Response res = await http.get("$url/api/urunharekets/al/$x");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtostokdetay> list = [];
    for (var l in re) {
      list.add(Dtostokdetay.fromMap(l));
    }

    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future safcarial(int x) async {
    print("musteri al baslıyr");

    http.Response res = await http.get("$url/api/caris/$x");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    /*  List<Cari> list = [];
    for (var l in re) {
      list.add(Cari.fromMap(l));
    }*/
    Cari ca = Cari.fromMap(re);
    print("sorual bitii");
    return ca;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future msuterial() async {
    print("musteri al baslıyr");

    http.Response res = await http.get("$url/api/caris/m");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtocarilist> list = [];
    for (var l in re) {
      list.add(Dtocarilist.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future msuterialca() async {
    print("musteri al baslıyr");

    http.Response res = await http.get("$url/api/caris/m/ca");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtocarilist> list = [];
    for (var l in re) {
      list.add(Dtocarilist.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future msuterialac() async {
    print("musteri al baslıyr");

    http.Response res = await http.get("$url/api/caris/m/ac");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtocarilist> list = [];
    for (var l in re) {
      list.add(Dtocarilist.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future tedaral() async {
    print("musteri al baslıyr");

    http.Response res = await http.get("$url/api/caris/t");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtocarilist> list = [];
    for (var l in re) {
      list.add(Dtocarilist.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future tedaralca() async {
    print("musteri al baslıyr");

    http.Response res = await http.get("$url/api/caris/t/ca");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtocarilist> list = [];
    for (var l in re) {
      list.add(Dtocarilist.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future tedaralac() async {
    print("musteri al baslıyr");

    http.Response res = await http.get("$url/api/caris/t/ac");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtocarilist> list = [];
    for (var l in re) {
      list.add(Dtocarilist.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }

  static Future kasaal() async {
    print("kasa al baslıyr");

    http.Response res = await http.get("$url/api/kasas");
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Kasa> list = [];
    for (var l in re) {
      list.add(Kasa.fromMap(l));
    }
    print("sorual bitii");
    return list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }
}
