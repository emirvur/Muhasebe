class Dtogunceldurum {
  int fatTur;

  String vadesi;
  String odenesi;

  num tahsalin;
  num tahstop;
  num odemod;
  num odemtop;

  Dtogunceldurum(
      this.fatTur,
      this.vadesi,
      this.odenesi,
      this.tahsalin,
      this.tahstop,
      this.odemod,
      this.odemtop); //kategori eklerken kullan, çünkü id db tarafından olusturuluyor

  Dtogunceldurum.fromMap(Map<String, dynamic> map) {
    // this.id = map['id'];
    this.fatTur = map['fatTur'];
    this.vadesi = map['vadesi'] ?? "";
    this.odenesi = map['odenesi'] ?? "";
    this.tahsalin = map['tahsalin'] ?? -1;
    this.tahstop = map['tahstop'] ?? -1;
    this.odemod = map['odemod'] ?? -1;
    this.odemtop = map['odemtop'] ?? -1;
  }
}
