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
    this.odenmistar = map['odenmistar'] ?? "null";
    this.kasaid = map['kasaid'];
    this.aciklama = map['aciklama'] ?? "null";
    this.odendimik = map['odendimik'] ?? "null";
    this.topmik = map['topmik'];
    this.fatad = map['fatad'] ?? "null";
    this.duzt = map['duzt'] ?? "null";
  }
}
