import 'package:Muhasebe/models/dtocarilist.dart';
import 'package:Muhasebe/models/dtoirsaliye.dart';
import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/postirsaliye.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:get/get.dart';

class Irsaliyeliscontroller extends GetxController {
  var isLoading = true.obs;
  var listdtofatta = List<Dtoirsaliye>().obs;
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
      var todos = await APIServices.irsaliyeal();
      if (todos != null) {
        listdtofatta.value = todos;
      }
    } finally {
      isLoading(false);
    }
  }

  void guncelle(int index, num deg) async {
    isLoading(true);

    try {} finally {
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

  void yeniurun(Postirsaliye yeni) async {
    isLoading(true);

    try {
      //  listdtofatta.add(yeni);
    } finally {
      isLoading(false);
    }
  }
}
