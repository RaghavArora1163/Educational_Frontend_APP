import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/data/api_controller/api_controller.dart';
import 'package:online/data/api_url/api_url.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentController extends GetxController {
  late Razorpay _razorpay;
  String id = "";
  String type = "";
  Map<String, dynamic>? address;

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }

  void pay({
    required int amount,
    required String name,
    required String description,
    required String contact,
    required String email,
    Map<String, dynamic>? address,
  }) {
    this.address = address;

    final options = {
      'key': 'rzp_test_8KFmE8jDFo6mWU',
      'amount': amount * 100,
      'name': name,
      'description': description,
      'prefill': {'contact': contact, 'email': email},
      'external': {'wallets': ['paytm']},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error opening Razorpay: $e");
    }
  }

  void Function()? onPaymentSuccessCallback;

  void paymentApi({required String paymentId}) {
    Map<String, dynamic> data = {
      'id': id,
      'type': type,
      'paymentId': paymentId,
    };
    ApiController().callPaymentMethod(apiUrl: ApiUrl.payment, data: data).then((response) {
      if (response != null) {
        if (response.success == true) {
          onPaymentSuccessCallback?.call();
        }
      }
    });
  }

  void orderPhysicalBookApi({
    required String bookId,
    required int quantity,
    required Map<String, dynamic> address,
    required String razorpayOrderId,
  }) {
    Map<String, dynamic> data = {
      'bookId': bookId,
      'quantity': quantity,
      'address': address,
    };

    ApiController().orderPhysicalBook(
      apiUrl: ApiUrl.orderBook,
      data: data,
    ).then((response) {
      if (response != null && response.success == true) {
        onPaymentSuccessCallback?.call();
        Get.snackbar(
          'Success',
          'Book order initiated successfully',
          backgroundColor: Colors.white,
          colorText: AppColor.textClr,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    if (type == "physical_book" && address != null) {
      orderPhysicalBookApi(
        bookId: id,
        quantity: 1,
        address: address!,
        razorpayOrderId: response.orderId ?? "",
      );
    } else {
      paymentApi(paymentId: response.paymentId ?? "");
    }

    Get.snackbar(
      'Success',
      'Payment ID: ${response.paymentId}',
      backgroundColor: Colors.white,
      colorText: AppColor.textClr,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar(
      'Failed',
      'Payment ID: ${response.code} - ${response.message}',
      backgroundColor: Colors.white,
      colorText: AppColor.textClr,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar(
      'Wallet',
      '${response.walletName}',
      backgroundColor: Colors.white,
      colorText: AppColor.textClr,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}