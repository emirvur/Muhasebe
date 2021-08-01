import 'package:Muhasebe/controller/alisfatcontroller.dart';
import 'package:Muhasebe/controller/degisiklik.dart';
import 'package:Muhasebe/controller/gdhafta.controller.dart';
import 'package:Muhasebe/controller/gdnuguncontroller.dart';
import 'package:Muhasebe/controller/gunceldurumcontroller.dart';
import 'package:Muhasebe/controller/irsaliyelistcontroller.dart';
import 'package:Muhasebe/controller/kasacontroller.dart';
import 'package:Muhasebe/controller/mustlistcontroller.dart';
import 'package:Muhasebe/controller/satisfatcontroller.dart';
import 'package:Muhasebe/controller/stgecmiscontroller.dart';
import 'package:Muhasebe/controller/tedarliscontroller.dart';
import 'package:Muhasebe/controller/uruncontroller.dart';
import 'package:get/get.dart';

class AllControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Satisfatcontroller>(
      () => Satisfatcontroller(),
    );
    Get.lazyPut<Alisfatcontroller>(
      () => Alisfatcontroller(),
    );
    Get.lazyPut<KasaController>(
      () => KasaController(),
    );
    Get.lazyPut<Mustliscontroller>(
      () => Mustliscontroller(),
    );
    Get.lazyPut<Tedarliscontroller>(() => Tedarliscontroller());
    Get.lazyPut<Irsaliyeliscontroller>(() => Irsaliyeliscontroller());
    Get.lazyPut<Urunliscontroller>(() => Urunliscontroller());
    Get.lazyPut<Degisiklikcontroller>(() => Degisiklikcontroller());
    Get.lazyPut<Stgecmiscontroller>(() => Stgecmiscontroller());
    Get.lazyPut<Gunceldurumcontroller>(() => Gunceldurumcontroller());
    Get.lazyPut<Gdhaftacontroller>(() => Gdhaftacontroller());
    Get.lazyPut<Gdbuguncontroller>(() => Gdbuguncontroller());
  }
}
