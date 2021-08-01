import 'package:Muhasebe/models/dtofatode.dart';
import 'package:Muhasebe/models/dtostokgecmisi.dart';
import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/stokrapor.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:get/get.dart';

class Stgecmiscontroller extends GetxController {
  var isLoading = true.obs;
  bool sira = false.obs();
  var listdtofatta = List<Dtostokgecmisi>().obs;
  @override
  void onInit() {
    fetchfinaltodo();
    super.onInit();
  }

  void fetchfinaltodo() async {
    isLoading(true);
    try {
      var todos = await APIServices.urungenelgecmisial();

      if (todos != null) {
        listdtofatta.value = todos;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> siradegistir(bool x) async {
    isLoading(true);

    try {
      // ignore: await_only_futures
      await fetchfinaltodo();
      sira = x;
    } finally {
      isLoading(false);
    }
  }
}
