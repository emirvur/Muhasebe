import 'package:Muhasebe/models/dtocarilist.dart';
import 'package:Muhasebe/services/apiservices.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Tedarliscontroller extends GetxController {
  var isLoading = true.obs;
  var listdtofatta = List<Dtocarilist>().obs;
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
      var todos = await APIServices.tedaral();
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

  void tedarbakguncel(int index, num deg) async {
    isLoading(true);

    try {
      for (var i in listdtofatta) {
        if (i.cariId == index) {
          i.bakiye = i.bakiye - deg;
        }
      }
      tahsmik = tahsmik - deg;
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

  void yenitedar(Dtocarilist yeni) async {
    isLoading(true);

    try {
      listdtofatta.add(yeni);
    } finally {
      isLoading(false);
    }
  }
}
