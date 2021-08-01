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
import 'package:Muhasebe/models/gunceldurummod.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

class APIServices {
/* 
todo 1. kullanıcı eklede 500 status codeu duzelt
*/

  static String tok = "1";
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${APIServices.tok}'
  };

  /*static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };*/

  static String url = "https://localhost:44311";

  //   "https://192.168.1.101:45455";

  static Future tokenal() async {
    print("token al baslıyr");
    http.Response res =
        await http.get("$url/api/calisans/token", headers: header);
    print(res.statusCode.toString());
    if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);
    APIServices.tok = re;
    APIServices.header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $re'
    };
    print(re.toString());
    print("tokenaall bitii");
    return re;
  }

  static Future tokentest() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var re = sp.getString("token");

    header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $re'
    };
    http.Response res = await http.get("$url/weatherforecast", headers: header);
    print("yy");
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      return -1;
    } else if (res.statusCode == 200) {
      print(res.statusCode.toString());
      return 0;
    } else {
      print(res.statusCode.toString());
      return 1;
    }
  }

  static Future<bool> urunekle(Urun urun) async {
    var maps = json.encode(urun.toMap());
    print(maps.toString());

    var res = await http.post("$url/api/uruns", headers: header, body: maps);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;
        urunekle(urun);
        return;
      });
    } else
      print(res.statusCode.toString());
    if (res.statusCode != 201) {
      throw Exception;
    }
    return Future.value(
        res.statusCode == 200 || res.statusCode == 201 ? true : false);
  }

  static Future urungenelgecmisial() async {
    print("urungecmis al baslıyor");
    http.Response res =
        await http.get("$url/api/urunharekets/g", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;
        urungenelgecmisial();
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtostokgecmisi> list = [];
    for (var l in re) {
      list.add(Dtostokgecmisi.fromMap(l));
    }
    return list;
  }

  static Future detayirsal(int id) async {
    print("detay irsaliye al baslıyor");
    http.Response res =
        await http.get("$url/api/urunharekets/i/$id", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        detayirsal(id);
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtoirsurunhar> list = [];
    for (var l in re) {
      list.add(Dtoirsurunhar.fromMap(l));
    }
    return list;
  }

  static Future irsaliyeal() async {
    print("irsaliye al baslıyr");

    http.Response res = await http.get("$url/api/irsaliyes/i", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;
        irsaliyeal();
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtoirsaliye> list = [];
    for (var l in re) {
      list.add(Dtoirsaliye.fromMap(l));
    }
    return list;
  }

  static Future tarihliirsaliyeal(int id, String ilktar, String sontar) async {
    http.Response res = await http.get("$url/api/irsaliyes/$id/$ilktar/$sontar",
        headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        tarihliirsaliyeal(id, ilktar, sontar);
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtoirsaliye> list = [];
    for (var l in re) {
      list.add(Dtoirsaliye.fromMap(l));
    }
    return list;
  }

  static Future urungecmisial(String x) async {
    print("urungecmis al baslıyor");
    http.Response res =
        await http.get("$url/api/urunharekets/b/$x", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        urungecmisial(x);
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtourungecmisi> list = [];
    for (var l in re) {
      list.add(Dtourungecmisi.fromMap(l));
    }
    return list;
  }

  static Future carisatfatal(int id) async {
    http.Response res =
        await http.get("$url/api/faturas/c/$id", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        carisatfatal(id);
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }
    return list;
  }

  static Future carialfatal(int id) async {
    http.Response res =
        await http.get("$url/api/faturas/oc/$id", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        carialfatal(id);
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }
    return list;
  }

  static Future satfatal() async {
    http.Response res = await http.get("$url/api/faturas/lt", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        satfatal();
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }

    return list;
  }

  static Future satfatalacikfat() async {
    http.Response res =
        await http.get("$url/api/faturas/lt/at", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        satfatalacikfat();

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }

    return list;
  }

  static Future satfatalkapali() async {
    http.Response res =
        await http.get("$url/api/faturas/lt/kt", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        satfatalkapali();
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }
    return list;
  }

  static Future satfatalvadeac() async {
    http.Response res =
        await http.get("$url/api/faturas/lt/vt/ac", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        satfatalvadeac();
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }
    return list;
  }

  static Future satfatalvadca() async {
    http.Response res =
        await http.get("$url/api/faturas/lt/vt/ca", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        satfatalvadca();
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }
    print("sorual bitii");
    return list;
  }

  static Future satfatalduzac() async {
    http.Response res =
        await http.get("$url/api/faturas/lt/dt/ac", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print("rr");
        print(value);
        APIServices.tok = value;

        satfatalduzac();
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }
    return list;
  }

  static Future satfatalduzca() async {
    http.Response res =
        await http.get("$url/api/faturas/lt/dt/ca", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        satfatalduzca();
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }
    return list;
  }

  static Future satcarifatal(int id) async {
    http.Response res =
        await http.get("$url/api/faturas/lt/$id", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        satcarifatal(id);
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }
    return list;
  }

  static Future satcariacikfatal(int id) async {
    http.Response res =
        await http.get("$url/api/faturas/lt/a/$id", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        satcariacikfatal(id);
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }
    return list;
  }

  static Future odefatal() async {
    http.Response res = await http.get("$url/api/faturas/od", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        odefatal();
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }
    return list;
  }

  static Future odefatalacik() async {
    http.Response res =
        await http.get("$url/api/faturas/od/a", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        odefatalacik();
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }
    return list;
  }

  static Future odefatalkapali() async {
    http.Response res =
        await http.get("$url/api/faturas/od/k", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        odefatalkapali();
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }
    return list;
  }

  static Future odefatalduzac() async {
    http.Response res =
        await http.get("$url/api/faturas/od/dt/ac", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        odefatalduzac();

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);

    print("$re");
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }

    return list;
  }

  static Future odefatalduzca() async {
    http.Response res =
        await http.get("$url/api/faturas/od/dt/ca", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        odefatalduzca();

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);

    print("$re");
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }

    return list;
  }

  static Future odefataltedac() async {
    http.Response res =
        await http.get("$url/api/faturas/od/tt/ac", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        odefataltedac();
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);

    print("$re");
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }

    return list;
  }

  static Future odefataltedca() async {
    http.Response res =
        await http.get("$url/api/faturas/od/tt/ca", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        odefataltedca();

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }
    return list;
  }

  static Future odecarifatal(int id) async {
    http.Response res =
        await http.get("$url/api/faturas/od/$id", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        odecarifatal(id);
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);

    print("$re");
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }

    return list;
  }

  static Future odecariacikfatal(int id) async {
    http.Response res =
        await http.get("$url/api/faturas/od/a/$id", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        odecariacikfatal(id);

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }

    return list;
  }

  static Future fatuurundetay(int id) async {
    http.Response res =
        await http.get("$url/api/urunharekets/f/$id", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        fatuurundetay(id);

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtourunhareket> list = [];
    for (var l in re) {
      list.add(Dtourunhareket.fromMap(l));
    }

    return list;
  }

  static Future alfatdetayal(int id) async {
    http.Response res =
        await http.get("$url/api/faturas/o/$id", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        alfatdetayal(id);

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);

    return Dtofatode.fromMap(re);
  }

  static Future satfatdetayal(int id) async {
    http.Response res =
        await http.get("$url/api/faturas/t/$id", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        satfatdetayal(id);

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);

    return Dtofattahs.fromMap(re);
  }

  static Future raporsatfattaral(DateTime bir, DateTime iki) async {
    http.Response res =
        await http.get("$url/api/faturas/rap/$bir/$iki", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        raporsatfattaral(bir, iki);

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);

    print(re.toString());
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }

    return list;
  }

  static Future raporalfattaral(DateTime bir, DateTime iki) async {
    http.Response res =
        await http.get("$url/api/faturas/alrap/$bir/$iki", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        raporalfattaral(bir, iki);
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);
    print(re.toString());
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }

    return list;
  }

  static Future stokraporal() async {
    http.Response res = await http.get("$url/api/uruns/r", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        stokraporal();
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }

    var re = json.decode(res.body);

    print("$re");

    return Stokrapor.fromMap(re);
  }

  static Future urunal() async {
    http.Response res = await http.get("$url/api/uruns", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;
        APIServices.header = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${APIServices.tok}'
        };
        urunal();

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtourun> list = [];
    for (var l in re) {
      list.add(Dtourun.fromMap(l));
    }
    return list;
  }

  static Future urunalazdancoga() async {
    http.Response res = await http.get("$url/api/uruns/ac", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        urunalazdancoga();

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtourun> list = [];
    for (var l in re) {
      list.add(Dtourun.fromMap(l));
    }

    return list;
  }

  static Future urunalcoktanaza() async {
    http.Response res = await http.get("$url/api/uruns/ca", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        urunalcoktanaza();

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);

    print("$re");
    List<Dtourun> list = [];
    for (var l in re) {
      list.add(Dtourun.fromMap(l));
    }

    return list;
  }

  static Future kasalistal() async {
    http.Response res = await http.get("$url/api/kasas", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        kasalistal();

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);

    print("$re");
    List<Kasa> list = [];
    for (var l in re) {
      list.add(Kasa.fromMap(l));
    }

    return list;
  }

  static Future kasahar(int id) async {
    http.Response res =
        await http.get("$url/api/kasahars/t/$id", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        kasahar(id);

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);

    print("$re");
    List<Dtokasahar> list = [];
    for (var l in re) {
      list.add(Dtokasahar.fromMap(l));
    }

    return list;
  }

  static Future tahsharfaticin(int id) async {
    http.Response res =
        await http.get("$url/api/tahshars/f/$id", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        tahsharfaticin(id);

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);

    print("$re");
    List<Dtotahsharfat> list = [];
    for (var l in re) {
      list.add(Dtotahsharfat.fromMap(l));
    }

    return list;
  }

  static Future odeharfaticin(int id) async {
    http.Response res =
        await http.get("$url/api/odehars/f/$id", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        odeharfaticin(id);

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);

    print("$re");
    List<Dtoodeharfat> list = [];
    for (var l in re) {
      list.add(Dtoodeharfat.fromMap(l));
    }

    return list;
  }

  static Future callstp(DateTime ilk, DateTime son) async {
    print(header.toString());
    http.Response res =
        await http.get("$url/api/calisans/sp/$ilk/$son", headers: header);

    print(header.toString());
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value.toString());
        APIServices.tok = value;
        callstp(ilk, son);
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);

    print("$re");
    List<Gunceldurummod> list = [];
    for (var l in re) {
      list.add(Gunceldurummod.fromMap(l));
    }

    return list;
  }

  static Future kasabakiye() async {
    http.Response res = await http.get("$url/api/kasas/b", headers: header);

    print(header.toString());
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        APIServices.tok = value;
        kasabakiye();
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);

    return re;
  }

  static Future mustara(String ara) async {
    http.Response res =
        await http.get("$url/api/caris/m/$ara", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        mustara(ara);

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);

    print("$re");
    List<Cari> list = [];
    for (var l in re) {
      list.add(Cari.fromMap(l));
    }

    return list;
  }

  static Future tedara(String ara) async {
    http.Response res =
        await http.get("$url/api/caris/t/$ara", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        tedara(ara);

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Cari> list = [];
    for (var l in re) {
      list.add(Cari.fromMap(l));
    }

    return list;
  }

  static Future carisatara(int id, String ara) async {
    http.Response res =
        await http.get("$url/api/faturas/c/$id/$ara", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        carisatara(id, ara);
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);

    print("$re");
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }

    return list;
  }

  static Future satfatara(String ara) async {
    http.Response res =
        await http.get("$url/api/faturas/s/$ara", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        satfatara(ara);

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);

    print("$re");
    List<Dtofattahs> list = [];
    for (var l in re) {
      list.add(Dtofattahs.fromMap(l));
    }

    return list;
  }

  static Future alisfatara(String ara) async {
    http.Response res =
        await http.get("$url/api/faturas/a/$ara", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        alisfatara(ara);

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);

    print("$re");
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }

    return list;
  }

  static Future carialara(int id, String ara) async {
    http.Response res =
        await http.get("$url/api/faturas/a/$id/$ara", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        carialara(id, ara);

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("$re");
    List<Dtofatode> list = [];
    for (var l in re) {
      list.add(Dtofatode.fromMap(l));
    }

    return list;
  }

  static Future urunara(String ara) async {
    print("urun ara baslıyr");

    http.Response res =
        await http.get("$url/api/uruns/a/$ara", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        urunara(ara);

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);

    print("$re");
    List<Dtourun> list = [];
    for (var l in re) {
      list.add(Dtourun.fromMap(l));
    }

    return list;
  }

  static Future<bool> kasaharekle(Kasahar pf) async {
    var maps = json.encode(pf.toMap());
    print(maps.toString());

    var res = await http.post("$url/api/kasahars", headers: header, body: maps);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        kasaharekle(pf);

        return;
      });
    } else
      print(res.statusCode.toString());
    debugPrint("resten sonra");
    if (res.statusCode != 201) {
      throw Exception;
    }
    return Future.value(
        res.statusCode == 200 || res.statusCode == 201 ? true : false);
  }

  static Future<List<int>> faturaekle(Postfatura pf) async {
    //  var maps = json.encode(pf.toMap());
    var maps = json.encode(pf.toJson());
    print(maps.toString());

    var res = await http.post("$url/api/faturas", headers: header, body: maps);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print("rr");
        print(value);
        APIServices.tok = value;

        faturaekle(pf);

        return;
      });
    } else
      print(res.statusCode.toString());

    if (res.statusCode != 201) {
      throw Exception;
    }
    print(res.statusCode.toString());
    print(res.body);
    List<int> l;
    if (json.decode(res.body)['fatTur'] == 1) {
      print(json.decode(res.body)["tahs"]['tahsid'].toString());
      l = [
        json.decode(res.body)['fatid'],
        json.decode(res.body)["tahs"]['tahsid']
      ];
    } else {
      print(json.decode(res.body)["ode"]['odeid'].toString());
      l = [
        json.decode(res.body)['fatid'],
        json.decode(res.body)["ode"]['odeid']
      ];
    }

    return l;
  }

  static Future getcariris(int cid) async {
    http.Response res =
        await http.get("$url/api/irsaliyes/c/$cid", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        getcariris(cid);

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    print(res.body.toString());
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re");
    List<Dtoirsaliye> list = [];
    for (var l in re) {
      list.add(Dtoirsaliye.fromMap(l));
    }

    return list;
  }

  static Future<bool> irsaliyeekle(Postirsaliye pf) async {
    //  var maps = json.encode(pf.toMap());
    var maps = json.encode(pf.toJson());
    print(maps.toString());

    var res =
        await http.post("$url/api/irsaliyes", headers: header, body: maps);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        irsaliyeekle(pf);

        return;
      });
    } else
      print(res.statusCode.toString());

    if (res.statusCode != 200) {
      throw Exception;
    }
    return Future.value(
        res.statusCode == 200 || res.statusCode == 201 ? true : false);
  }

  static Future<bool> urunhareketekle(List<Urunhareket> pf) async {
    var maps = json.encode(List<dynamic>.from(pf.map((x) => x.toMap())));
    print(maps.toString());

    var res =
        await http.post("$url/api/urunharekets", headers: header, body: maps);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        urunhareketekle(pf);

        return;
      });
    } else
      print(res.statusCode.toString());

    if (res.statusCode != 200) {
      throw Exception;
    }
    return Future.value(
        res.statusCode == 200 || res.statusCode == 201 ? true : false);
  }

  static Future<bool> tahsharguncelle(Tahsput pf) async {
    var maps = json.encode(pf.toMap());
    print(maps.toString());

    var res = await http.put("$url/api/tahsilats", headers: header, body: maps);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        tahsharguncelle(pf);
        //.then((value) => value);
        return;
      });
    } else
      print(res.statusCode.toString());

    if (res.statusCode != 200) {
      throw Exception;
    }
    return Future.value(
        res.statusCode == 200 || res.statusCode == 201 ? true : false);
  }

  static Future<bool> urharfatidekle(int fid, int irsid) async {
    var x = Map<String, dynamic>();
    //  map['cariId'] = cariId;
    x['fid'] = fid;
    x['irsid'] = irsid;
    var maps = json.encode(x);
    print(maps.toString());

    var res = await http.put("$url/api/urunharekets/i/$fid/$irsid",
        headers: header, body: maps);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        urharfatidekle(fid, irsid);

        return;
      });
    } else
      print(res.statusCode.toString());

    if (res.statusCode != 200) {
      throw Exception;
    }
    return Future.value(
        res.statusCode == 200 || res.statusCode == 201 ? true : false);
  }

  static Future<List<int>> irsifatyap(int id) async {
    var x = Map<String, dynamic>();
    //  map['cariId'] = cariId;
    x['id'] = id;
    var maps = json.encode(x);
    print(maps.toString());

    var res =
        await http.put("$url/api/irsaliyes/$id", headers: header, body: maps);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print("rr");
        print(value);
        APIServices.tok = value;

        irsifatyap(id);

        return;
      });
    } else
      print(res.statusCode.toString());

    if (res.statusCode != 200) {
      throw Exception;
    }
    print("qq");
    print(json.decode(res.body)['fatid'].toString());
    print(res.body.toString());
    List<int> l = [
      json.decode(res.body)['fatid'],
      json.decode(res.body)["tahs"]['tahsid']
    ];
    return l;
  }

  static Future<bool> odeharguncelle(Odeput pf) async {
    var maps = json.encode(pf.toMap());
    print(maps.toString());

    var res = await http.put("$url/api/odemelers", headers: header, body: maps);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        odeharguncelle(pf);

        return;
      });
    } else
      print(res.statusCode.toString());

    if (res.statusCode != 200) {
      throw Exception;
    }
    return Future.value(
        res.statusCode == 200 || res.statusCode == 201 ? true : false);
  }

  static Future<bool> kasaekle(Kasa kasa) async {
    var maps = json.encode(kasa.toMap());
    print(maps.toString());

    var res = await http.post("$url/api/kasas", headers: header, body: maps);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        kasaekle(kasa);

        return;
      });
    } else
      print(res.statusCode.toString());

    if (res.statusCode != 201) {
      throw Exception;
    }
    return Future.value(
        res.statusCode == 200 || res.statusCode == 201 ? true : false);
  }

  static Future<bool> musteriekle(Cari kasa) async {
    var maps = json.encode(kasa.toMap(1));
    print(maps.toString());

    var res = await http.post("$url/api/caris", headers: header, body: maps);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        musteriekle(kasa);

        return;
      });
    } else
      print(res.statusCode.toString());

    if (res.statusCode != 201) {
      throw Exception;
    }
    return Future.value(
        res.statusCode == 200 || res.statusCode == 201 ? true : false);
  }

  static Future<bool> tedarekl(Cari kasa) async {
    var maps = json.encode(kasa.toMap(2));
    print(maps.toString());

    var res = await http.post("$url/api/caris", headers: header, body: maps);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        tedarekl(kasa);

        return;
      });
    } else
      print(res.statusCode.toString());

    if (res.statusCode != 201) {
      throw Exception;
    }
    return Future.value(
        res.statusCode == 200 || res.statusCode == 201 ? true : false);
  }

  static Future gunceldurumal() async {
    http.Response res = await http.get("$url/api/faturas/gd", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        gunceldurumal();

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);

    print("$re");
    List<Dtogunceldurum> list = [];
    for (var l in re) {
      list.add(Dtogunceldurum.fromMap(l));
    }

    return list;
  }

  static Future stokdetayfatsatis(String x) async {
    http.Response res =
        await http.get("$url/api/urunharekets/st/$x", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        stokdetayfatsatis(x);

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);

    print("$re");
    List<Dtostokdetay> list = [];
    for (var l in re) {
      list.add(Dtostokdetay.fromMap(l));
    }

    return list;
  }

  static Future stokdetayfatalis(String x) async {
    http.Response res =
        await http.get("$url/api/urunharekets/al/$x", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        stokdetayfatalis(x);

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);

    print("$re");
    List<Dtostokdetay> list = [];
    for (var l in re) {
      list.add(Dtostokdetay.fromMap(l));
    }

    return list;
  }

  static Future safcarial(int x) async {
    http.Response res = await http.get("$url/api/caris/$x", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        safcarial(x);

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    var re = json.decode(res.body);

    print("$re");
    /*  List<Cari> list = [];
    for (var l in re) {
      list.add(Cari.fromMap(l));
    }*/
    Cari ca = Cari.fromMap(re);

    return ca;
  }

  static Future musterial() async {
    http.Response res = await http.get("$url/api/caris/m", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        musterial();

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);

    print("$re");
    List<Dtocarilist> list = [];
    for (var l in re) {
      list.add(Dtocarilist.fromMap(l));
    }

    return list;
  }

  static Future msuterialca() async {
    http.Response res = await http.get("$url/api/caris/m/ca", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        msuterialca();

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);

    print("$re");
    List<Dtocarilist> list = [];
    for (var l in re) {
      list.add(Dtocarilist.fromMap(l));
    }

    return list;
  }

  static Future msuterialac() async {
    http.Response res = await http.get("$url/api/caris/m/ac", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        msuterialac();

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);

    print("$re");
    List<Dtocarilist> list = [];
    for (var l in re) {
      list.add(Dtocarilist.fromMap(l));
    }

    return list;
  }

  static Future tedaral() async {
    http.Response res = await http.get("$url/api/caris/t", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        tedaral();

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);

    print("$re");
    List<Dtocarilist> list = [];
    for (var l in re) {
      list.add(Dtocarilist.fromMap(l));
    }
    return list;
  }

  static Future tedaralca() async {
    http.Response res = await http.get("$url/api/caris/t/ca", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        tedaralca();

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);

    print("$re");
    List<Dtocarilist> list = [];
    for (var l in re) {
      list.add(Dtocarilist.fromMap(l));
    }
    return list;
  }

  static Future tedaralac() async {
    http.Response res = await http.get("$url/api/caris/t/ac", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        tedaralac();

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);

    print("$re");
    List<Dtocarilist> list = [];
    for (var l in re) {
      list.add(Dtocarilist.fromMap(l));
    }

    return list;
  }

  static Future kasaal() async {
    http.Response res = await http.get("$url/api/kasas", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print(value);
        APIServices.tok = value;

        kasaal();

        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);

    print("$re");
    List<Kasa> list = [];
    for (var l in re) {
      list.add(Kasa.fromMap(l));
    }

    return list;
  }
}

  /*static Future getvt(String ad, String sifre) async {
    http.Response res =
        await http.get("$url/api/calisans/b/$ad/$sifre", headers: header);
    if (res.statusCode == 401) {
      print(res.statusCode.toString());
      tokenal().then((value) {
        print("rr");
        print(value);
        APIServices.tok = value;

        getvt(ad, sifre);
        //.then((value) => value);
        return;
      });
    } else if (res.statusCode != 200) {
      print(res.statusCode.toString());
      throw Exception;
    }
    List re = json.decode(res.body);
    print("ikinci sama");
    print("$re" ?? "null");
    re == null ? print("aaa") : print("sss");

    /*List<Dtostokgecmisi> list = [];
    for (var l in re) {
      list.add(Dtostokgecmisi.fromMap(l));
    }
    print("sorual bitii");*/
    return re.length == 0 ? -1 : 0; //list;

    // return List<Kullaniciliste>.from(re.map((x) => Kullaniciliste.fromMap(x)));
  }
*/