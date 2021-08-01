import 'package:Muhasebe/utils/load.dart';
import 'package:intl/intl.dart';

class Dtogunceldurum {
  String fatad;
  int fatTur;

  String vadesi;
  String odenesi;

  num tahsalin;
  num tahstop;
  num odemod;
  num odemtop;

  Dtogunceldurum(this.fatad, this.fatTur, this.vadesi, this.odenesi,
      this.tahsalin, this.tahstop, this.odemod, this.odemtop);

  Dtogunceldurum.fromMap(Map<String, dynamic> map) {
    // this.id = map['id'];
    this.fatad = map['fatad'];
    this.fatTur = map['fatTur'];
    this.vadesi = map['vadesi'] ?? "";
    if (vadesi != "") {
      var yil1 = DateFormat.yMMMEd('tr_TR').format(DateTime.parse(vadesi));
      this.vadesi = yil1;
    }
    this.odenesi = map['odenesi'] ?? "";
    if (odenesi != "") {
      var yil1 = DateFormat.yMMMEd('tr_TR').format(DateTime.parse(odenesi));
      this.odenesi = yil1;
    }
    this.tahsalin = map['tahsalin'] ?? -1;
    /*if (tahsalin != -1) {
      this.tahsalin = int.tryParse((Load.numfor.format(this.tahsalin)));
    }*/
    this.tahstop = map['tahstop'] ?? -1;
    /*if (tahsalin != -1) {
      this.tahstop = int.tryParse((Load.numfor.format(this.tahstop)));
    }*/
    this.odemod = map['odemod'] ?? -1;
    /* if (tahsalin != -1) {
      this.odemod = int.tryParse((Load.numfor.format(this.odemod)));
    }*/
    this.odemtop = map['odemtop'] ?? -1;
    /*if (odemtop != -1) {
      this.odemtop = int.tryParse((Load.numfor.format(this.odemtop)));
    }*/
  }
}
