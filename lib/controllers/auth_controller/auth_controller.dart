import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/data/api_controller/api_controller.dart';
import 'package:online/data/api_url/api_url.dart';
import 'package:online/models/user_signin_model/user_signin_model.dart';
import 'package:online/utils/app_routes/routes.dart';
import 'package:online/utils/shared_preferences/shared_pref.dart';

class AuthController extends GetxController{

  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController otpPinController = TextEditingController();
  RxBool isKeyBoardAppear = false.obs;
  RxBool isMobileNumberValid = true.obs;
  RxBool isOtpValid = true.obs;

  String firebaseVerifyId = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool isVerifyUser = false.obs;

  String getFirebaseIdToken = "";

  SignInModel signInModel = SignInModel();

  /// Verify Mobile Through FireBase
  void verifyMobileNumber(){
    isVerifyUser.value = true;
    _auth.verifyPhoneNumber(
        phoneNumber: "+91${mobileNumberController.text}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          isVerifyUser.value = false;
          print("verifyMobileNumber ${await _auth.currentUser?.getIdToken()}");
        },
        verificationFailed: (FirebaseAuthException e) {
          isVerifyUser.value = false;
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
        },
        codeSent: (verificationId, forceResendingToken) {
          firebaseVerifyId = verificationId;
          Get.toNamed(RoutesName.otpVerifyView);
        },
        codeAutoRetrievalTimeout: (verificationId) {
          isVerifyUser.value = false;
          firebaseVerifyId = verificationId;
        },
    );
  }


  void checkOTPVerify() async {
    final credential = PhoneAuthProvider.credential(
      verificationId: firebaseVerifyId,
      smsCode: otpPinController.text,
    );
    await _auth.signInWithCredential(credential);
    userSignInApi(await _auth.currentUser?.getIdToken() ?? "");
  }

  void userSignInApi(String value) {
    print("firebase ID Token $value");
    Map<String,dynamic> data = {
      'firebaseToken' : value,
    };
    ApiController().authentication(apiUrl: ApiUrl.signIn, data:data).then((response){
      if(response != null){
        if(response.success == true){
          SharedPref.saveToken(response.data?.token);
          SharedPref.setUserIsLogin(true);
          Get.offAllNamed(RoutesName.dashBoardPageView);
        }else{
        }
      }

    });
  }

}