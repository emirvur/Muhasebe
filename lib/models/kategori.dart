class Kategori {
  int katid;
  String katadi;
  int hangikat;

  Kategori(
    this.katid,
    this.katadi,
    this.hangikat,
  );

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    //  map['cariId'] = cariId;
    map['katid'] = katid;
    map['katadi'] = katadi;
    map['hangikat'] = hangikat;

    return map;
  }

  Kategori.fromMap(Map<String, dynamic> map) {
    // this.id = map['id'];
    this.katadi = map['katadi'];
    this.katadi = map['katadi'];
    this.hangikat = map['hangikat'];
  }
}
