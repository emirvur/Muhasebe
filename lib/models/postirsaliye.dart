import 'dart:convert';

String siparisToJson(Postirsaliye data) => json.encode(data.toJson());

class Postirsaliye {
  Postirsaliye1 sipa;
  List<Hareketirs> hareket;
  Postirsaliye(this.sipa, this.hareket);

  Map<String, dynamic> toJson() => {
        "sipa": sipa.toMap(),
        "hareket": List<dynamic>.from(hareket.map((x) => x.toJson())),
      };
}

class Hareketirs {
  Hareketirs({this.barkodno, this.miktar, this.brfiyat, this.vergi});

  String barkodno;
  int miktar;
  num brfiyat;
  num vergi;

  Map<String, dynamic> toJson() => {
        "barkodno": barkodno,
        "miktar": miktar,
        "brfiyat": brfiyat,
        "vergi": vergi,
      };
}

class Postirsaliye1 {
  int tur;
  String aciklama;
  int cariId;
  String tarih;

  num aratop;
  num araind;
  num kdv;
  num geneltop;

  int fatmi;

  Postirsaliye1(
    this.tur,
    this.aciklama,
    this.cariId,
    this.tarih,
    this.aratop,
    this.araind,
    this.kdv,
    this.geneltop,
  );

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    //  map['cariId'] = cariId;

    map['tur'] = tur;
    map['aciklama'] = aciklama;
    map['cariId'] = cariId;
    map['tarih'] = tarih;
    map['aratop'] = aratop;
    map['araind'] = araind;
    map['kdv'] = kdv;
    map['geneltop'] = geneltop;

    return map;
  }
}
