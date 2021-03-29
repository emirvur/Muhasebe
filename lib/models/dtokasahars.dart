class Dtokasahar {
  num netbakiye;
  int durum;
  num miktar;
  String miktaraciklamasi;
  int tahsid;
  String tediltar;
  int tahskasaid;
  String tahsaciklama;
  num alinmismik;
  int odeid;
  String odenmistar;
  int odkasaid;
  String odaciklama;
  num odendimik;
  Dtokasahar(
    this.netbakiye,
    this.durum,
    this.miktar,
    this.miktaraciklamasi,
    this.tahsid,
    this.tediltar,
    this.tahskasaid,
    this.tahsaciklama,
    this.alinmismik,
    this.odeid,
    this.odenmistar,
    this.odkasaid,
    this.odaciklama,
    this.odendimik,
  );
  Dtokasahar.fromMap(Map<String, dynamic> map) {
    // this.id = map['id'];
    this.netbakiye = map['netbakiye'];
    this.durum = map['durum'];
    this.miktar = map['miktar'] ?? -1;
    this.miktaraciklamasi = map['miktaraciklamasi'] ?? "null";
    this.tahsid = map['tahsid'] ?? -1;
    this.tediltar = map['tediltar'] ?? "null";
    this.tahskasaid = map['tahskasaid'] ?? -1;
    this.tahsaciklama = map['tahsaciklama'] ?? "null";
    this.odeid = map['odeid'] ?? -1;
    this.odenmistar = map['odenmistar'] ?? "null";
    this.odkasaid = map['odkasaid'] ?? -1;
    this.odaciklama = map['odaciklama'] ?? "null";
    this.odendimik = map['odendimik'] ?? -1;
  }
}
