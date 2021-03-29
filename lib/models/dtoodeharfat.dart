class Dtoodeharfat {
  int ohid;
  int odeid;
  String odenmistar;
  int kasaid;
  String aciklama;
  num odendimik;
  String ad;

  Dtoodeharfat(this.ohid, this.odeid, this.odenmistar, this.kasaid,
      this.aciklama, this.odendimik, this.ad);

  Dtoodeharfat.fromMap(Map<String, dynamic> map) {
    // this.id = map['id'];
    this.ohid = map['ohid'];
    print("vvv");
    print(ohid.toString());
    this.odeid = map['odeid'];
    this.odenmistar = map['odenmistar'];
    print(odenmistar.toString());
    this.kasaid = map['kasaid'];
    this.aciklama = map['aciklama'];
    this.odendimik = map['odendimik'];
    this.ad = map['ad'];
  }
}
