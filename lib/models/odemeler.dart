import 'package:intl/intl.dart';

class Odemeler {
  int odeid;
  int durum;
  String odenecektar;
  String odenmistar;
  int kasaid;
  String aciklama;
  num odendimik;
  num topmik;
  String fatad;
  String duzt;
  Odemeler(
      this.odeid,
      this.durum,
      this.odenecektar,
      this.odenmistar,
      this.kasaid,
      this.aciklama,
      this.odendimik,
      this.topmik,
      this.fatad,
      this.duzt);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    //  map['cariId'] = cariId;
    map['odeid'] = odeid;
    map['durum'] = durum;
    map['odenecektar'] = odenecektar;
    map['odenmistar'] = odenmistar;
    map['kasaid'] = kasaid;
    map['aciklama'] = aciklama;
    map['odendimik'] = odendimik;
    map['topmik'] = topmik;
    map['fatad'] = fatad;
    map['duzt'] = duzt;
    return map;
  }

  Odemeler.fromMap(Map<String, dynamic> map) {
    // this.id = map['id'];
    this.odeid = map['odeid'];
    this.durum = map['durum'];
    this.odenecektar = map['odenecektar'] ?? "null";
    if (this.odenecektar != "null") {
      var saat = DateFormat.jm('tr_TR').format(DateTime.parse(odenecektar));
      var yil = DateFormat.yMMMEd('tr_TR').format(DateTime.parse(odenecektar));
      this.odenecektar = yil + "-" + saat;
    }
    this.odenmistar = map['odenmistar'] ?? "null";
    if (this.odenmistar != "null") {
      var saat1 = DateFormat.jm('tr_TR').format(DateTime.parse(odenmistar));
      var yil1 = DateFormat.yMMMEd('tr_TR').format(DateTime.parse(odenmistar));
      this.odenmistar = yil1 + "-" + saat1;
    }
    this.kasaid = map['kasaid'];
    this.aciklama = map['aciklama'] ?? "null";
    this.odendimik = map['odendimik'] ?? "null";
    this.topmik = map['topmik'];
    this.fatad = map['fatad'] ?? "null";
    this.duzt = map['duzt'] ?? "null";
    if (this.duzt != "null") {
      var saat3 = DateFormat.jm('tr_TR').format(DateTime.parse(duzt));
      var yil3 = DateFormat.yMMMEd('tr_TR').format(DateTime.parse(duzt));
      this.duzt = yil3 + "-" + saat3;
    }
  }
}
