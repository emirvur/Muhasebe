class Fathareket {
  Fathareket(
      {this.ad,
      this.barkodno,
      this.birim,
      this.miktar,
      this.brfiyat,
      this.vergi,
      this.toplfiy});
  String ad;
  String barkodno;
  String birim;
  int miktar;
  num brfiyat;
  num vergi;
  num toplfiy;

  Map<String, dynamic> toJson() => {
        "ad": ad,
        "barkodno": barkodno,
        "birim": birim,
        "miktar": miktar,
        "brfiyat": brfiyat,
        "vergi": vergi,
        "toplfiy": toplfiy,
      };
}
