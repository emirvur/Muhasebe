class Tahshar {
  int thid;
  int tahsid;
  String tediltar;
  int kasaid;
  String aciklama;
  num alinmismik;

  Tahshar(this.thid, this.tahsid, this.tediltar, this.kasaid, this.aciklama,
      this.alinmismik);

  Tahshar.fromMap(Map<String, dynamic> map) {
    // this.id = map['id'];
    this.thid = map['thid'];
    this.tahsid = map['tahsid'];
    this.tediltar = map['tediltar'] ?? "null";
    this.kasaid = map['kasaid'];
    this.aciklama = map['aciklama'] ?? "null";
    this.alinmismik = map['alinmismik'] ?? "null";
  }
}
