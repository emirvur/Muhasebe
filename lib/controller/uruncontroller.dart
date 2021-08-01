import 'package:Muhasebe/models/dtocarilist.dart';
import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:get/get.dart';

class Urunliscontroller extends GetxController {
  var isLoading = true.obs;
  var listdtofatta = List<Dtourun>().obs;
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
      APIServices.tokenal().then((value) async {
        var todos = await APIServices.urunal();
        if (todos != null) {
          listdtofatta.value = todos;
        }
      });
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
      var todos = await APIServices.urunal();
      sira = x;
      if (todos != null) {
        listdtofatta.value = todos;
      }
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

  void yeniurun(Dtourun yeni) async {
    isLoading(true);

    try {
      listdtofatta.add(yeni);
    } finally {
      isLoading(false);
    }
  }
}
