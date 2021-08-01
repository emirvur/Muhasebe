import 'package:intl/intl.dart';

class Odehar {
  int ohid;
  int odeid;
  String odenmistar;
  int kasaid;
  String aciklama;
  num odendimikmik;

  Odehar(this.ohid, this.odeid, this.odenmistar, this.kasaid, this.aciklama,
      this.odendimikmik);

  Odehar.fromMap(Map<String, dynamic> map) {
    // this.id = map['id'];
    this.ohid = map['ohid'];
    this.odeid = map['odeid'];
    this.odenmistar = map['odenmistar'] ?? "null";
    if (this.odenmistar != "null") {
      //  var saat1 = DateFormat.jm('tr_TR').format(DateTime.parse(odenmistar));
      var yil1 = DateFormat.yMMMEd('tr_TR').format(DateTime.parse(odenmistar));
      this.odenmistar = yil1; // + "-" + saat1;
    }
    this.kasaid = map['kasaid'];
    this.aciklama = map['aciklama'] ?? "null";
    this.odendimikmik = map['odendimikmik'];
  }
}
