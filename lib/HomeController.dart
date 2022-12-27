import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/Name.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<List<Name>> names = Rx<List<Name>>([]);
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController updateTextEditingController = TextEditingController();

  late Name nameModel;
  var itemCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    nameTextEditingController.dispose();
  }

  addName(String name) {
    nameModel = Name(name: name);
    names.value.add(nameModel);
    itemCount.value = names.value.length;

    nameTextEditingController.clear();
  }

  // updateName(int index) {
  //   names.value.setAll(index, iterable);
  // }

  removeName(int index) {
    names.value.removeAt(index);
    itemCount.value = names.value.length;
  }
}
