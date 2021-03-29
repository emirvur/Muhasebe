class Postfatura {
  int fatTur;
  String fataciklama;
  int cariId;
  String duztarih;
  int katid;
  num aratop;
  num araind;
  num kdv;
  num geneltoplam;
  int odeid;
  int kasaid;
  int durum;
  String vadt;
  String tedt;
  String tahac;
  num alinm;
  num topm;
  Postfatura(
    this.fatTur,
    this.fataciklama,
    this.cariId,
    this.duztarih,
    this.katid,
    this.aratop,
    this.araind,
    this.kdv,
    this.geneltoplam,
    this.odeid,
    this.kasaid,
    this.durum,
    this.vadt,
    this.tedt,
    this.tahac,
    this.alinm,
    this.topm,
  );

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    //  map['cariId'] = cariId;

    map['fatTur'] = fatTur;
    map['fataciklama'] = fataciklama;
    map['cariId'] = cariId;
    map['duztarih'] = duztarih;
    map['katid'] = katid;
    map['aratop'] = aratop;
    map['araind'] = araind;
    map['kdv'] = kdv;
    map['geneltoplam'] = geneltoplam;
    map['odeid'] = odeid;

    map['kasaid'] = kasaid;
    map['durum'] = durum;
    map['vadt'] = vadt;
    map['tedt'] = tedt;
    map['tahac'] = tahac;
    map['alinm'] = alinm;
    map['topm'] = topm;

    return map;
  }
}
