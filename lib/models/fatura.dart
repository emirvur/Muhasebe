class Fatura {
  int fatid;
  int fatTur;
  String fataciklama;
  int cariId;
  int tahsid;
  String duztarih;
  int katid;
  num aratop;
  num araind;
  num kdv;
  num geneltoplam;
  int odeid;
  Fatura(
    this.fatid,
    this.fatTur,
    this.fataciklama,
    this.cariId,
    this.tahsid,
    this.duztarih,
    this.katid,
    this.aratop,
    this.araind,
    this.kdv,
    this.geneltoplam,
    this.odeid,
  );

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    //  map['cariId'] = cariId;
    map['fatid'] = fatid;
    map['fatTur'] = fatTur;
    map['fataciklama'] = fataciklama;
    map['cariId'] = cariId;
    map['tahsid'] = tahsid;
    map['duztarih'] = duztarih;
    map['katid'] = katid;
    map['aratop'] = aratop;
    map['araind'] = araind;
    map['kdv'] = kdv;
    map['geneltoplam'] = geneltoplam;
    map['odeid'] = odeid;

    return map;
  }

  Fatura.fromMap(Map<String, dynamic> map) {
    // this.id = map['id'];
    this.fatid = map['fatid'];
    this.fatTur = map['fatTur'];
    this.fataciklama = map['fataciklama'] ?? "null";
    this.cariId = map['cariId'];
    this.tahsid = map['tahsid'] ?? -1;
    this.duztarih = map['duztarih'];
    this.katid = map['katid'];
    this.aratop = map['aratop'] ?? -1;
    this.araind = map['araind'] ?? -1;
    this.kdv = map['kdv'] ?? -1;
    this.geneltoplam = map['geneltoplam'];
    this.odeid = map['odeid'] ?? -1;
  }
}
