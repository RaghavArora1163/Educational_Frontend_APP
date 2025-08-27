import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:online/data/api_url/api_url.dart';
import 'package:online/data/app_environment/environment/environment.dart';
import 'package:online/data/app_environment/main.dart';
import 'package:online/data/status_code/status_code.dart';
import 'package:online/models/book_details_model/book_details_model.dart';
import 'package:online/models/book_list_model/book_list_model.dart';
import 'package:online/models/common_response_model/common_response_model.dart';
import 'package:online/models/course_detail_model/course_detail_model.dart';
import 'package:online/models/edit_profile_modal/edit_profile_modal.dart';
import 'package:online/models/live_class_model/live_class_model.dart';
import 'package:online/models/payment_model/payment_model.dart';
import 'package:online/models/profile_model/profile_model.dart';
import 'package:online/models/resources_data_model/resouces_data_model.dart';
import 'package:online/models/std_fet_courses_model/std_fet_courses_model.dart';
import 'package:online/models/student_assignment_model/student_assignment_model.dart';
import 'package:online/models/student_lectures_model/student_lectures_model.dart';
import 'package:online/models/student_quizzes_model/student_quizzes_model.dart';
import 'package:online/models/submit_model/submit_model.dart';
import 'package:online/models/take_test_series_model/take_test_series_model.dart';
import 'package:online/models/test_series_detail_model/test_series_detail_model.dart';
import 'package:online/models/test_series_model/test_series_model.dart';
import 'package:online/models/user_signin_model/user_signin_model.dart';
import 'package:online/models/wish_list_model/wish_list_model.dart';
import 'package:online/models/you_tube_url_model/you_tube_url_model.dart';
import 'package:online/utils/shared_preferences/shared_pref.dart';

import '../../models/notification_model/notification_model.dart';
import '../../models/order_book_model/order_book_model.dart';
import '../../models/orders_model/orders_model.dart';
import '../../models/review_model/review_model.dart';
import '../../models/search_model/search_model.dart';
import '../../models/submit_response_model/submit_response_model.dart';
import '../../models/support_query_model/support_query_model.dart';
import '../../models/test_progress_model/test_progress_model.dart';

http.Client client = http.Client();

class ApiServices {
  String baseUrl = '';

  ApiServices() {
    switch (appEnv) {
      case Environment.local:
        baseUrl = ApiUrl.devBaseUrl;
        break;
      case Environment.prod:
        baseUrl = ApiUrl.prodBaseUrl;
        break;
      case Environment.dev:
        baseUrl = ApiUrl.localBaseUrl;
        break;
    }
  }

  static terminatedApi(){
    client.close();
  }

  Future<T?> post<T>({String apiUrl = '', Map<String, dynamic> data = const {}}) async {
    try {
      client = http.Client();
      var headers = {
        "Content-Type": "application/json"
      };
      String token = await SharedPref.getToken() ?? "";
      if(token != "") {
        headers["Authorization"] = 'Bearer $token';
      }
      //Map<String, String> body = data.map((key, value) => MapEntry(key, value));
      //var response = await client.post(Uri.parse(baseUrl + apiUrl), headers: headers, body: jsonEncode(data)).timeout(const Duration(seconds: 60), onTimeout: () => http.Response('Error', 408));
      var response = await client.post(Uri.parse(baseUrl + apiUrl), headers: headers, body: jsonEncode(data)).timeout(const Duration(seconds: 60));
      var responseBody =  StatusCode.returnResponse(response);
      print("\nREQUEST METHOD : POST \nURL: ${baseUrl + apiUrl}");
      print('\nRESPONSE DATA (STATUS ${response.statusCode})');
      printBeautifiedJson(responseBody);
      print('\nREQUEST HEADER :');
      printBeautifiedJson(headers);
      print('\nREQUEST BODY : ');
      //Map<String, String> body = data.map((key, value) => MapEntry(key, value));
      //print(response.body);
      printBeautifiedJson(data);
      if(response.statusCode == 200||response.statusCode == 201){
        T apiResponse = fromJson<T>(responseBody);
        return apiResponse;
      }else{
        return responseBody;
      }
    }on SocketException{
      throw Get.snackbar("No Internet!", "Please turn on mobile data.",backgroundColor: Colors.redAccent,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
    } catch (error) {
      print("REQUEST\nMETHOD: POST \nURL: ${baseUrl + apiUrl}");
      print(error.toString());
    }
    return null;
  }

  Future<T?> get<T>({String apiUrl = '', Map<String, dynamic> data = const {}}) async {
    try {
      client = http.Client();
      var headers = {
        "Content-Type": "application/json"
      };
      String token = await SharedPref.getToken() ?? "";
      if(token != "") {
        headers["Authorization"] = 'Bearer $token';
      }
      var response = await client.get(Uri.parse(baseUrl + apiUrl), headers: headers,).timeout(const Duration(seconds: 60));
      var responseBody =  StatusCode.returnResponse(response);
      print("\nREQUEST METHOD : Get \nURL: ${baseUrl + apiUrl}");
      print('\nRESPONSE DATA (STATUS ${response.statusCode})');
      printBeautifiedJson(responseBody);
      print('\nREQUEST HEADER :');
      printBeautifiedJson(headers);
      if(response.statusCode == 200){
        T apiResponse = fromJson<T>(responseBody);
        return apiResponse;
      }else{
        return responseBody;
      }
    }on SocketException{
      throw Get.snackbar("No Internet!", "Please turn on mobile data.",backgroundColor: Colors.redAccent,colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
    } catch (error) {
      print("REQUEST\nMETHOD: POST \nURL: ${baseUrl + apiUrl}");
      print(error.toString());
    }
    return null;
  }

  Future<T?> postMultipart<T>({String apiUrl = '', Map<String, dynamic> data = const {}, File? imageFile}) async {
    try {
      debugPrint("REQUEST\nMETHOD : POST \nURL: ${baseUrl + apiUrl}");
      var headers = {
        "Content-Type": "application/json"
      };
      String token = await SharedPref.getToken() ?? "";
      if(token != "") {
        headers["Authorization"] = 'Bearer $token';
      }

      debugPrint('\nREQUEST HEADER : $headers');
      Map<String, String> body = data.map((key, value) => MapEntry(key, value));
      debugPrint('\nREQUEST BODY : $body');

      var request = http.MultipartRequest('POST', Uri.parse(baseUrl + apiUrl));
      request.fields.addAll(body);
      request.headers.addAll(headers);

      if(imageFile != null) {
        http.MultipartFile multipartFile;
        var stream = http.ByteStream((imageFile.openRead()));
        stream.cast();

        var length = await imageFile.length();
        multipartFile = http.MultipartFile("profilePicture", stream, length, filename: imageFile.path.split('/').last, contentType: MediaType('image', 'jpeg'));

        request.files.add(multipartFile);
      }

      client = http.Client();
      var response = await client.send(request).timeout(const Duration(seconds: 60), onTimeout:  () {
        throw "TimeOut";
      });
      var responseString =  await response.stream.bytesToString();
      if (response.statusCode == HttpStatus.ok) {
        debugPrint("REQUEST\nMETHOD: POST \nURL: ${baseUrl + apiUrl}");
        debugPrint('\nRESPONSE DATA (STATUS 200): $responseString');
        T apiResponse = fromJson<T>(jsonDecode(responseString));
        return apiResponse;
      } else if (response.statusCode == HttpStatus.unauthorized) {
        debugPrint("REQUEST\nMETHOD: POST \nURL: ${baseUrl + apiUrl}");
        debugPrint('\nRESPONSE DATA (STATUS 401) : $responseString');
      } else {
        debugPrint("REQUEST\nMETHOD: POST \nURL: ${baseUrl + apiUrl}");
        debugPrint('\nRESPONSE DATA (STATUS ${response.statusCode}) : $responseString');
        T apiResponse = fromJson<T>(jsonDecode(responseString));
        return apiResponse;
      }
    }on SocketException{
      throw Get.snackbar("No Internet!", "Please turn on mobile data.", backgroundColor: Colors.redAccent, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
    }
    catch (error) {
      debugPrint("REQUEST\nMETHOD: POST \nURL: ${baseUrl + apiUrl}");
      debugPrint(error.toString());
    }
  }

  T fromJson<T>(Map<String, dynamic> json) {
    switch (T) {
      case SignInModel:
        return SignInModel.fromJson(json) as T;
      case StdFetCoursesModel:
        return StdFetCoursesModel.fromJson(json) as T;
      case CoursesDetailModel:
        return CoursesDetailModel.fromJson(json) as T;
      case BookListModel:
        return BookListModel.fromJson(json) as T;
      case TestSeriesModel:
        return TestSeriesModel.fromJson(json) as T;
      case TestSeriesDetailModel:
        return TestSeriesDetailModel.fromJson(json) as T;
      case TakeTestSeriesModel:
        return TakeTestSeriesModel.fromJson(json) as T;
      case SubmitModel:
        return SubmitModel.fromJson(json) as T;
      case BookDetailsModel:
        return BookDetailsModel.fromJson(json) as T;
      case WishListModel:
        return WishListModel.fromJson(json) as T;
      case StudentLecturesModel:
        return StudentLecturesModel.fromJson(json) as T;
      case ProfileModel:
        return ProfileModel.fromJson(json) as T;
      case PaymentModel:
        return PaymentModel.fromJson(json) as T;
      case LiveClassModel:
        return LiveClassModel.fromJson(json) as T;
      case YouTubeUrlModel:
        return YouTubeUrlModel.fromJson(json) as T;
      case StudentProfileModel:
        return StudentProfileModel.fromJson(json) as T;
      case CommonResposneModel:
        return CommonResposneModel.fromJson(json) as T;
      case NotificationModel:
        return NotificationModel.fromJson(json) as T;
      case OrdersModel:
        return OrdersModel.fromJson(json) as T;
      case SubmitResponseModel:
        return SubmitResponseModel.fromJson(json) as T;
      case TestProgressModel:
        return TestProgressModel.fromJson(json) as T;
      case OrderBookModel:
        return OrderBookModel.fromJson(json) as T;
      case OrderBookModel:
        return OrderBookModel.fromJson(json) as T;
      case ReviewModel:
        return ReviewModel.fromJson(json) as T;
      case SupportQueryModel:
        return SupportQueryModel.fromJson(json) as T;
      case SearchModel:
        return SearchModel.fromJson(json) as T;
      default:
        throw "Model class not exist";
    }
  }
}

void printBeautifiedJson(dynamic data) {
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  String prettyJson = encoder.convert(data);
  print(prettyJson);
}