import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online/controllers/profile_controller/profile_controller.dart';
import 'package:online/data/api_controller/api_controller.dart';
import 'package:online/data/api_url/api_url.dart';
import 'package:online/models/edit_profile_modal/edit_profile_modal.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class EditProfileController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<StudentProfileData?> studentData = StudentProfileData().obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController biographyController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  Rx<TextEditingController> languageController = TextEditingController().obs;
  RxBool notificationEnabled = false.obs;
  RxString avatarUrl = ''.obs;
  final avatarFile = Rx<File?>(null);
  final List<String> languages = ['English', 'Hindi'];
  RxBool isProfileUpdate = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStudentProfile();
  }


  void checkPermission() async{
    PermissionStatus status = await Permission.photos.request();
    if(_isGalleryPermission(status)){
      _pickUpImageFromGallery();
    }else{
      _pickUpImageFromGallery();
      //AppSettings.openAppSettings(type: AppSettingsType.settings);
    }
  }

  bool _isGalleryPermission(status){
    return status == PermissionStatus.granted;
  }


  void _pickUpImageFromGallery() async{
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery,imageQuality: 75);
    if(image != null){
      avatarFile.value = File(image.path);
    }
  }

  void fetchStudentProfile() {
    ApiController().getStudentProfile(apiUrl: ApiUrl.getStudentProfileForEdit).then((response){
      if(response != null){
        if(response.success == true){
          studentData.value = response.data;
          studentData.update((value){
            nameController.text = value?.fullName ?? "";
            emailController.text = value?.emailAddress ?? "";
            biographyController.text = value?.biography ?? "";
            avatarUrl.value = value?.avatarUrl ?? "";
            contactController.text = value?.phoneNumber ?? "";
            streetController.text = value?.shippingAddress?.street ?? "";
            cityController.text = value?.shippingAddress?.city ?? "";
            stateController.text = value?.shippingAddress?.state ?? "";
            postalCodeController.text = value?.shippingAddress?.postalCode ?? "";
            countryController.text = value?.shippingAddress?.country ?? "";
            languageController.value.text = value?.userPreferences?.language ?? "";
            notificationEnabled.value = value?.userPreferences?.notificationEnabled ?? false;
            });
        }else{
        }
      }

    });
  }

  void updateProfile(){
    final profileController = Get.find<ProfileController>();
    isProfileUpdate.value = true;
    Map<String,dynamic> body = {
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "bio": biographyController.text.trim(),
      "contactNumber": contactController.text.trim(),
      "street": streetController.text.trim(),
      "city": cityController.text.trim(),
      "state": stateController.text.trim(),
      "postalCode": postalCodeController.text.trim(),
      "country":  countryController.text.trim(),
      "language": languageController.value.text.trim(),
      "notificationEnabled": notificationEnabled.value.toString(),
    };
    ApiController().updateStudentProfileDetails(apiUrl: ApiUrl.updateStudentProfile,data: body, file: (avatarFile.value != null) ? avatarFile.value : null).then((response){
      Future.delayed(const Duration(seconds: 1),(){
        isProfileUpdate.value = false;

      });
      if(response != null) {
        if (response.success == true) {
          avatarFile.value = null;
          profileController.fetchProfileData();
        }
      }
    });

  }

  /*void updateStudentProfile(StudentProfileData updatedData, File? profilePicture) async {
    isLoading.value = true;
    var response = await _apiController.postStudentProfileDetails(
      apiUrl: ApiUrl.updateStudentProfile,
      data: updatedData.toJson(),
      profilePicture: profilePicture,
    );
    if (response != null && response.success == true && response.data != null) {
      studentData.value = response.data;
      Get.snackbar('Success', 'Profile updated successfully');
    } else {
      Get.snackbar('Error', 'Failed to update profile');
    }
    isLoading.value = false;
  }*/

  @override
  void onClose() {
    // Dispose controllers to prevent memory leaks
    nameController.dispose();
    emailController.dispose();
    contactController.dispose();
    biographyController.dispose();
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    postalCodeController.dispose();
    countryController.dispose();
    languageController.value.dispose();
    super.onClose();
  }
}