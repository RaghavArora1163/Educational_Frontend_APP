import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpSupportController extends GetxController {
  final ScrollController scrollController = ScrollController();
  RxDouble scrollOffset = 0.0.obs;
  double maxScrollValue = 0.0;

  final Rx<String?> _selectedState = Rx<String?>(null);
  final Rx<String?> _selectedDistrict = Rx<String?>(null);

  Rx<String?> get selectedState {
    print("Accessing selectedState: $_selectedState");
    return _selectedState;
  }

  Rx<String?> get selectedDistrict {
    print("Accessing selectedDistrict: $_selectedDistrict");
    return _selectedDistrict;
  }

  final List<String> states = ["Karnataka", "Maharashtra", "Delhi", "Tamil Nadu"];
  final List<String> districts = [
    "Mumbai",
    "Pune",
    "Nagpur",
    "Bangalore",
    "Chennai",
    "New Delhi",
  ];

  @override
  void onInit() {
    super.onInit();
    print("HelpSupportController initialized");
    scrollController.addListener(scrollListener);
  }

  @override
  void onClose() {
    super.onClose();
    print("HelpSupportController disposed");
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
  }

  void scrollListener() {
    maxScrollValue = scrollController.position.maxScrollExtent;
    scrollOffset.value = scrollController.offset;
    print("Max Scroll Position: $maxScrollValue");
    print("Scroll Position: $scrollOffset");
  }
}