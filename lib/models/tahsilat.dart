class Tahsilat {
  int tahsid;
  int durum;
  String vadetarih;
  String tediltar;
  int kasaid;
  String aciklama;
  num alinmismik;
  num topmik;
  String fatad;
  String duzt;
  Tahsilat(this.tahsid, this.durum, this.vadetarih, this.tediltar, this.kasaid,
      this.aciklama, this.alinmismik, this.topmik, this.fatad, this.duzt);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    //  map['cariId'] = cariId;
    map['tahsid'] = tahsid;
    map['durum'] = durum;
    map['vadetarih'] = vadetarih;
    map['tediltar'] = tediltar;
    map['kasaid'] = kasaid;
    map['aciklama'] = aciklama;
    map['alinmismik'] = alinmismik;
    map['topmik'] = topmik;
    map['fatad'] = fatad;
    map['duzt'] = duzt;
    return map;
  }

  Tahsilat.fromMap(Map<String, dynamic> map) {
    // this.id = map['id'];
    this.tahsid = map['tahsid'];
    this.durum = map['durum'];
    this.vadetarih = map['vadetarih'] ?? "null";
    this.tediltar = map['tediltar'] ?? "null";
    this.kasaid = map['kasaid'];
    this.aciklama = map['aciklama'] ?? "null";
    this.alinmismik = map['alinmismik'] ?? "null";
    this.topmik = map['topmik'];
    this.fatad = map['fatad'] ?? "null";
    this.duzt = map['duzt'] ?? "null";
  }
}
