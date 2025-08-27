import 'dart:io';
import 'package:flutter/material.dart';
import 'package:online/data/api_service/api_service.dart';
import 'package:online/models/book_details_model/book_details_model.dart';
import 'package:online/models/book_list_model/book_list_model.dart';
import 'package:online/models/common_response_model/common_response_model.dart';
import 'package:online/models/course_detail_model/course_detail_model.dart';
import 'package:online/models/live_class_model/live_class_model.dart';
import 'package:online/models/notification_model/notification_model.dart';
import 'package:online/models/orders_model/orders_model.dart';
import 'package:online/models/payment_model/payment_model.dart';
import 'package:online/models/profile_model/profile_model.dart';
import 'package:online/models/std_fet_courses_model/std_fet_courses_model.dart';
import 'package:online/models/student_lectures_model/student_lectures_model.dart';
import 'package:online/models/submit_model/submit_model.dart';
import 'package:online/models/take_test_series_model/take_test_series_model.dart';
import 'package:online/models/test_series_detail_model/test_series_detail_model.dart';
import 'package:online/models/test_series_model/test_series_model.dart';
import 'package:online/models/user_signin_model/user_signin_model.dart';
import 'package:online/models/wish_list_model/wish_list_model.dart';
import 'package:online/models/you_tube_url_model/you_tube_url_model.dart';
import 'package:online/models/edit_profile_modal/edit_profile_modal.dart';

import '../../models/order_book_model/order_book_model.dart';
import '../../models/review_model/review_model.dart';
import '../../models/search_model/search_model.dart';
import '../../models/submit_response_model/submit_response_model.dart';
import '../../models/support_query_model/support_query_model.dart';
import '../../models/test_progress_model/test_progress_model.dart';

class ApiController{
  final ApiServices _apiServices = ApiServices();


  /// Method For Login User By Mobile Otp
  Future<dynamic> authentication({String apiUrl = "", Map<String, dynamic> data = const {}}) async{
    try {
      var results = await _apiServices.post<SignInModel>(apiUrl: apiUrl, data: data,);
      debugPrint("request Api res: ${results?.message.toString()}");

      if (results != null) {
        return results;
      }
      else {
        return results;
      }
    }catch (error) {
      print("Error");
      debugPrint(error.toString());
    }
  }

  /// Method For Access Student Features Courses
  Future<dynamic> featureCourses({String apiUrl = ""}) async{
    try {
      var results = await _apiServices.post<StdFetCoursesModel>(apiUrl: apiUrl);
      debugPrint("request Api res: ${results?.message.toString()}");

      if (results != null) {
        return results;
      }
      else {
        return results;
      }
    }catch (error) {
      print("Error");
      debugPrint(error.toString());
    }
  }

  /// Method For Access Student courses details
  Future<dynamic> coursesDetail({String apiUrl = "", Map<String, dynamic> data = const {}}) async{
    try {
      var results = await _apiServices.post<CoursesDetailModel>(apiUrl: apiUrl, data: data);
      debugPrint("request Api res: ${results?.message.toString()}");

      if (results != null) {
        return results;
      }
      else {
        return results;
      }
    }catch (error) {
      print("Error");
      debugPrint(error.toString());
    }
  }

  /// Method For Access Student Book List details
  Future<dynamic> studentBookList({String apiUrl = "", Map<String, dynamic> data = const {}}) async{
    try {
      var results = await _apiServices.post<BookListModel>(apiUrl: apiUrl, data: data);
      debugPrint("request Api res: ${results?.message.toString()}");

      if (results != null) {
        return results;
      }
      else {
        return results;
      }
    }catch (error) {
      print("Error");
      debugPrint(error.toString());
    }
  }

  /// Method For Access Student Test Series List details
  Future<dynamic> studentTestSeriesList({String apiUrl = "", Map<String, dynamic> data = const {}}) async{
    try {
      var results = await _apiServices.post<TestSeriesModel>(apiUrl: apiUrl);
      debugPrint("request Api res: ${results?.message.toString()}");

      if (results != null) {
        return results;
      }
      else {
        return results;
      }
    }catch (error) {
      print("Error");
      debugPrint(error.toString());
    }
  }

  /// Method For Access Student Test Series Detail  List
  Future<dynamic> studentTestSeriesDetail({String apiUrl = "", Map<String, dynamic> data = const {}}) async{
    try {
      var results = await _apiServices.post<TestSeriesDetailModel>(apiUrl: apiUrl, data: data);
      debugPrint("request Api res: ${results?.message.toString()}");

      if (results != null) {
        return results;
      }
      else {
        return results;
      }
    }catch (error) {
      print("Error");
      debugPrint(error.toString());
    }
  }

  /// Method For Access Student Take Test Series
  Future<dynamic> studentTakeTestSeries({String apiUrl = "", Map<String, dynamic> data = const {}}) async{
    try {
      var results = await _apiServices.post<TakeTestSeriesModel>(apiUrl: apiUrl, data: data);
      debugPrint("request Api res: ${results?.message.toString()}");

      if (results != null) {
        return results;
      }
      else {
        return results;
      }
    }catch (error) {
      print("Error");
      debugPrint(error.toString());
    }
  }

  Future<dynamic> submitTakeTestSeries({String apiUrl = "", Map<String, dynamic> data = const {}}) async {
    try {
      var results = await _apiServices.post<SubmitResponseModel>(apiUrl: apiUrl, data: data);
      debugPrint("request Api res: ${results?.message.toString()}");

      if (results != null) {
        return results;
      } else {
        return results;
      }
    } catch (error) {
      print("Error");
      debugPrint(error.toString());
    }
  }
  /// Method For Access Student Book Details
  Future<dynamic> bookDetails({String apiUrl = "", Map<String, dynamic> data = const {}}) async{
    try {
      var results = await _apiServices.post<BookDetailsModel>(apiUrl: apiUrl, data: data);
      debugPrint("request Api res: ${results?.message.toString()}");

      if (results != null) {
        return results;
      }
      else {
        return results;
      }
    }catch (error) {
      print("Error");
      debugPrint(error.toString());
    }
  }

  /// Method For Access Student WishList Detail
  Future<dynamic> wishListDetail({String apiUrl = "", Map<String, dynamic> data = const {}}) async{
    try {
      var results = await _apiServices.post<WishListModel>(apiUrl: apiUrl, data: data);
      debugPrint("request Api res: ${results?.message.toString()}");

      if (results != null) {
        return results;
      }
      else {
        return results;
      }
    }catch (error) {
      print("Error");
      debugPrint(error.toString());
    }
  }

  /// Method For Access Student Lectures Detail
  Future<dynamic> studentLecturesDetail({String apiUrl = "", Map<String, dynamic> data = const {}}) async{
    try {
      var results = await _apiServices.post<StudentLecturesModel>(apiUrl: apiUrl, data: data);
      debugPrint("request Api res: ${results?.message.toString()}");

      if (results != null) {
        return results;
      }
      else {
        return results;
      }
    }catch (error) {
      print("Error");
      debugPrint(error.toString());
    }
  }


  /// Method For Access Student Profile Detail
  Future<dynamic> studentProfileDetail({String apiUrl = "", Map<String, dynamic> data = const {}}) async{
    try {
      var results = await _apiServices.get<ProfileModel>(apiUrl: apiUrl);
      debugPrint("request Api res: ${results?.message.toString()}");

      if (results != null) {
        return results;
      }
      else {
        return results;
      }
    }catch (error) {
      print("Error");
      debugPrint(error.toString());
    }
  }

  /// Method For Payment
  Future<dynamic> callPaymentMethod({String apiUrl = "", Map<String, dynamic> data = const {}}) async{
    try {
      var results = await _apiServices.post<PaymentModel>(apiUrl: apiUrl,data: data);
      debugPrint("request Api res: ${results?.message.toString()}");

      if (results != null) {
        return results;
      }
      else {
        return results;
      }
    }catch (error) {
      print("Error");
      debugPrint(error.toString());
    }
  }

  Future<dynamic> liveClassMethod({String apiUrl = "", Map<String, dynamic> data = const {}}) async{
    try {
      var results = await _apiServices.post<LiveClassModel>(apiUrl: apiUrl,data: data);
      debugPrint("request Api res: ${results?.message.toString()}");

      if (results != null) {
        return results;
      }
      else {
        return results;
      }
    }catch (error) {
      print("Error");
      debugPrint(error.toString());
    }
  }


  Future<dynamic> showYouTubeThumbNail({String apiUrl = "", Map<String, dynamic> data = const {}}) async{
    try {
      var results = await _apiServices.get<YouTubeUrlModel>(apiUrl: apiUrl);
      debugPrint("request Api res: ${results?.message.toString()}");

      if (results != null) {
        return results;
      }
      else {
        return results;
      }
    }catch (error) {
      print("Error");
      debugPrint(error.toString());
    }
  }

  /// Method For Getting Student Profile
  Future<dynamic> getStudentProfile({String apiUrl = "", Map<String, dynamic> data = const {}}) async{
    try {
      var results = await _apiServices.get<StudentProfileModel>(apiUrl: apiUrl);
      debugPrint("request Api res: ${results?.message.toString()}");

      if (results != null) {
        return results;
      }
      else {
        return results;
      }
    }catch (error) {
      print("Error");
      debugPrint(error.toString());
    }
  }

  /// Method For Update Student Profile
  Future<dynamic> updateStudentProfileDetails({String apiUrl = "", Map<String, dynamic> data = const {},File? file}) async{
    try {
      var results = await _apiServices.postMultipart<StudentProfileModel>(apiUrl: apiUrl,data: data, imageFile: file);
      debugPrint("request Api res: ${results?.message.toString()}");

      if (results != null) {
        return results;
      }
      else {
        return results;
      }
    }catch (error) {
      print("Error");
      debugPrint(error.toString());
    }
  }

  /// Method General Common Resposne Model
  Future<dynamic> generalResponse({String apiUrl = "", Map<String, dynamic> data = const {},File? file}) async{
    try {
      var results = await _apiServices.post<CommonResposneModel>(apiUrl: apiUrl,data: data);
      debugPrint("request Api res: ${results?.message.toString()}");

      if (results != null) {
        return results;
      }
      else {
        return results;
      }
    }catch (error) {
      print("Error");
      debugPrint(error.toString());
    }
  }

  /// Method For Access Notifications
  Future<dynamic> notifications({String apiUrl = ""}) async {
    try {
      var results = await _apiServices.get<NotificationModel>(apiUrl: apiUrl);
      debugPrint("Notifications API res: ${results?.message.toString()}");

      if (results != null) {
        return results;
      } else {
        return results;
      }
    } catch (error) {
      print("Error in notifications");
      debugPrint(error.toString());
    }
  }
  /// Method For Access All Orders
  Future<dynamic> getAllOrders({String apiUrl = ""}) async {
    try {
      var results = await _apiServices.post<OrdersModel>(apiUrl: apiUrl);
      debugPrint("Orders API res: ${results?.message.toString()}");

      if (results != null) {
        return results;
      } else {
        return results;
      }
    } catch (error) {
      print("Error in getAllOrders");
      debugPrint(error.toString());
    }
  }
  /// Method For Access Student Test Progress
  Future<dynamic> testProgress({String apiUrl = "", Map<String, dynamic> data = const {}}) async {
    try {
      var results = await _apiServices.post<TestProgressModel>(apiUrl: apiUrl, data: data);
      debugPrint("Test Progress API res: ${results?.message.toString()}");
      return results;
    } catch (error) {
      debugPrint("Error in testProgress: $error");
      return null;
    }
  }

  // Add this method to ApiController class
  Future<OrderBookModel?> orderPhysicalBook({
    String apiUrl = "",
    Map<String, dynamic> data = const {},
  }) async {
    try {
      final response = await _apiServices.post(
        apiUrl: apiUrl,
        data: data,
      );
      debugPrint("Order Physical Book API response: ${response.toString()}");

      if (response != null) {
        // If response is a Map, convert it to OrderBookModel
        if (response is Map<String, dynamic>) {
          return OrderBookModel.fromJson(response);
        } else if (response is OrderBookModel) {
          return response;
        }
      }
      return null;
    } catch (error) {
      debugPrint("Error in orderPhysicalBook: $error");
      return null;
    }
  }

  Future<ReviewModel?> submitReview({
    String apiUrl = "",
    Map<String, dynamic> data = const {},
  }) async {
    try {
      var results = await _apiServices.post<ReviewModel>(
        apiUrl: apiUrl,
        data: data,
      );
      debugPrint("Submit Review API res: ${results?.message.toString()}");

      if (results != null) {
        return results;
      } else {
        return results;
      }
    } catch (error) {
      print("Error in submitReview");
      debugPrint(error.toString());
      return null;
    }
  }
  Future<SupportQueryModel?> submitSupportQuery({
    String apiUrl = "",
    Map<String, dynamic> data = const {},
  }) async {
    try {
      var results = await _apiServices.post<SupportQueryModel>(
        apiUrl: apiUrl,
        data: data,
      );
      debugPrint("Submit Support Query API res: ${results?.message.toString()}");

      if (results != null) {
        return results;
      } else {
        return results;
      }
    } catch (error) {
      print("Error in submitSupportQuery");
      debugPrint(error.toString());
      return null;
    }
  }


  /// Method For Search
  Future<SearchModel?> search({String apiUrl = "", Map<String, dynamic> data = const {}}) async {
    try {
      var results = await _apiServices.post<SearchModel>(apiUrl: apiUrl, data: data);
      debugPrint("Search API res: ${results?.message.toString()}");

      if (results != null) {
        return results;
      } else {
        return results;
      }
    } catch (error) {
      print("Error in search");
      debugPrint(error.toString());
      return null;
    }
  }

}