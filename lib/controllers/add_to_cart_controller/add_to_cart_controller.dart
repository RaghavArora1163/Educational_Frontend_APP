import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddToCartController extends GetxController{

  ScrollController scrollController = ScrollController();

  TextEditingController bottomSheetTextFieldController = TextEditingController();

  String? selectedState;

  final List<String> states = ["Karnataka", "Maharashtra", "Delhi", "Tamil Nadu"];

}