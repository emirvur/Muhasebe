import 'package:Muhasebe/models/dtofattahs.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:get/get.dart';

class Satisfatcontroller extends GetxController {
  var isLoading = true.obs;
  var listdtofatta = List<Dtofattahs>().obs;
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
      var todos = await APIServices.satfatal();
      if (todos != null) {
        listdtofatta.value = todos;
      }
    } finally {
      isLoading(false);
    }
  }

  void guncelle(int index, num deg) async {
    isLoading(true);

    try {
      for (var i in listdtofatta) {
        if (i.fatid == index) {
          if (i.geneltoplam - i.alinmism == deg) {
            i.durum = 1;
            //sattahsta kaldır
            //   listdtofatta.removeWhere((item) => item.fatid == '001');
            // listdtofatta.remove(i);
          }
          i.alinmism = i.alinmism + deg;
        }
      }
      tahsmik = tahsmik - deg;
    } finally {
      isLoading(false);
    }
  }

  void eklesatfat(Dtofattahs yeni) {
    isLoading(true);

    try {
      listdtofatta.insert(0, yeni);
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

  Future<void> sirafiltre(int x) async {
    isLoading(true);
    try {
      sira = x;
    } finally {
      isLoading(false);
    }
  }

  void satffattumekleyeni(Dtofattahs yeni) async {
    isLoading(true);

    try {
      listdtofatta.insert(0, yeni);
      tahsmik = tahsmik + yeni.geneltoplam;
    } finally {
      isLoading(false);
    }
  }
}
