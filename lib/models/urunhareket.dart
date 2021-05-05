class Urunhareket {
  int urharid;
  int fatid;
  int barkodno;
  num miktar;
  num brfiyat;
  num vergi;
  Urunhareket(
    this.urharid,
    this.fatid,
    this.barkodno,
    this.miktar,
    this.brfiyat,
    this.vergi,
  );

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    //  map['cariId'] = cariId;
    map['urharid'] = urharid;
    map['fatid'] = fatid;
    map['barkodno'] = barkodno;
    map['miktar'] = miktar;
    map['brfiyat'] = brfiyat;
    map['vergi'] = vergi;
    return map;
  }

  Urunhareket.fromMap(Map<String, dynamic> map) {
    // this.id = map['id'];
    this.urharid = map['urharid'];
    this.fatid = map['fatid'] ?? -1;
    this.barkodno = map['barkodno'];
    this.miktar = map['miktar'];
    this.brfiyat = map['brfiyat'] ?? -1;
    this.vergi = map['vergi'] ?? -1;
  }
  Urunhareket.fromIrsaliyeMap(Map<String, dynamic> map) {
    // this.id = map['id'];
    this.urharid = map['urharid'];
    this.fatid = map['irsid'] ?? -1;
    this.barkodno = map['barkodno'];
    this.miktar = map['miktar'];
    this.brfiyat = map['brfiyat'] ?? -1;
    this.vergi = map['vergi'] ?? -1;
  }
}
