class Stokrapor {
  num tahalis;
  num tahsat;

  Stokrapor(
    this.tahalis,
    this.tahsat,
  );

  Stokrapor.fromMap(Map<String, dynamic> map) {
    // this.id = map['id'];
    this.tahalis = map['tahalis'];
    this.tahsat = map['tahsat'];
  }
}
