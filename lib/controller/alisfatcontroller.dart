import 'package:Muhasebe/models/dtofatode.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:get/get.dart';

class Alisfatcontroller extends GetxController {
  var isLoading = true.obs;
  var listdtofatta = List<Dtofatode>().obs;

  num tahsmik = 0.obs();
  int sira = 0.obs();
  @override
  void onInit() {
    fetchfinaltodo();
    super.onInit();
  }

  void fetchfinaltodo() async {
    isLoading(true);
    try {
      var todos = await APIServices.odefatal();
      if (todos != null) {
        listdtofatta.value = todos;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> siradegistir(int x) async {
    isLoading(true);

    try {
      await Future.delayed(Duration(milliseconds: 1));
      sira = x;
    } finally {
      isLoading(false);
    }
  }

  void guncelle(int index, num deg) async {
    isLoading(true);

    try {
      for (var i in listdtofatta) {
        if (i.fatid == index) {
          if (i.geneltoplam - i.odendimik == deg) {
            i.durum = 1;
            //sattahsta kaldır
            //   listdtofatta.removeWhere((item) => item.fatid == '001');
            // listdtofatta.remove(i);
          }
          i.odendimik = i.odendimik + deg;
        }
      }
      tahsmik = tahsmik - deg;
    } finally {
      isLoading(false);
    }
  }

  void alisffattumekleyeni(Dtofatode yeni) async {
    isLoading(true);

    try {
      listdtofatta.insert(0, yeni);
      tahsmik = tahsmik + yeni.geneltoplam;
    } finally {
      isLoading(false);
    }
  }

  void alisfftumkleyeni(Dtofatode yeni) async {
    isLoading(true);

    try {
      ;

      listdtofatta.add(yeni);
      tahsmik = tahsmik + yeni.geneltoplam;
    } finally {
      isLoading(false);
    }
  }

  Future<void> sirafiltre(int x) async {
    isLoading(true);
    try {
      sira = x;
    } finally {
      isLoading(false);
    }
  }
}
