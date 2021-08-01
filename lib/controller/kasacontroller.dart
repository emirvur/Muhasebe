import 'package:Muhasebe/models/dtokasahars.dart';
import 'package:Muhasebe/models/kasa.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:get/get.dart';

class KasaController extends GetxController {
  var isLoading = true.obs;
  var todoList = List<Kasa>().obs;

  @override
  void onInit() {
    fetchfinaltodo();
    super.onInit();
  }

  void fetchfinaltodo() async {
    isLoading(true);
    try {
      var todos = await APIServices.kasaal();
      if (todos != null) {
        todoList.value = todos;
      }
    } finally {
      isLoading(false);
    }
  }

  void guncelle(int index, num bak) async {
    isLoading(true);
    print(todoList[0].kasaAd);
    try {
      for (var i in todoList) {
        if (i.kasaid == index) {
          i.bakiye = i.bakiye + bak;
        }
      }
    } finally {
      isLoading(false);
    }
  }

  void eklekasa(Kasa yeni) {
    isLoading(true);

    try {
      todoList.insert(0, yeni);
    } finally {
      isLoading(false);
    }
  }
}
