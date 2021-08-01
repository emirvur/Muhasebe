import 'package:Muhasebe/models/dtofatode.dart';
import 'package:Muhasebe/models/dtourun.dart';
import 'package:Muhasebe/models/stokrapor.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:get/get.dart';

class Degisiklikcontroller extends GetxController {
  var isLoading = true.obs;
  Stokrapor st = Stokrapor(0, 0).obs();
  bool sira = false.obs();
  var listdtofatta = List<Dtourun>().obs;
  @override
  void onInit() {
    fetchfinaltodo();
    super.onInit();
  }

  void fetchfinaltodo() async {
    isLoading(true);
    try {
      var todos = await APIServices.stokraporal();
      var todos1 = await APIServices.urunal();
      if (todos != null) {
        st = todos;
      }
      if (todos1 != null) {
        listdtofatta.value = todos1;
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
      //  st.tahsat = 1;
    } finally {
      isLoading(false);
    }
  }
}
