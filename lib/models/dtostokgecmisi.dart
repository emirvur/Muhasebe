class Dtostokgecmisi {
  int fatid;
  String fattur;
  String duzenlemetarih;
  num miktar;
  String cariad;
  String urunad;

  Dtostokgecmisi(this.fatid, this.fattur, this.duzenlemetarih, this.miktar,
      this.cariad, this.urunad);
  Dtostokgecmisi.fromMap(Map<String, dynamic> map) {
    // this.id = map['id'];
    this.fatid = map['fatid'] ?? -1;
    this.fattur = map['fatTur'] == 0 ? "Stok Giriş" : "Stok Çıkış";
    this.duzenlemetarih = map['duzenlemetarih'];
    this.miktar = map['miktar'];

    this.cariad = map['cariad'];
    this.urunad = map['urunad'];
  }
}
