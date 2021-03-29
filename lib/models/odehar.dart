class Odehar {
  int ohid;
  int odeid;
  String odenmistar;
  int kasaid;
  String aciklama;
  num odendimikmik;

  Odehar(this.ohid, this.odeid, this.odenmistar, this.kasaid, this.aciklama,
      this.odendimikmik);

  Odehar.fromMap(Map<String, dynamic> map) {
    // this.id = map['id'];
    this.ohid = map['ohid'];
    this.odeid = map['odeid'];
    this.odenmistar = map['odenmistar'] ?? "null";
    this.kasaid = map['kasaid'];
    this.aciklama = map['aciklama'] ?? "null";
    this.odendimikmik = map['odendimikmik'];
  }
}
