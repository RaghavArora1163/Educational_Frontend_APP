import 'package:get/get.dart';
import 'package:online/controllers/add_to_cart_controller/add_to_cart_binding.dart';
import 'package:online/controllers/auth_controller/auth_controller_binding.dart';
import 'package:online/controllers/book_controller/book_controller_binding.dart';
import 'package:online/controllers/chat_controller/chat_controller_binding.dart';
import 'package:online/controllers/check_result_controller/check_result_binding.dart';
import 'package:online/controllers/dashboard_controller/dashboard_controller_binding.dart';
import 'package:online/controllers/edit_profile_controller/edit_profile_controller_binding.dart';
import 'package:online/controllers/enter_user_detail_controller/user_detail_controller_binding.dart';
import 'package:online/controllers/help_support_controller/help_support_binding.dart';
import 'package:online/controllers/home_controller/home_controller_binding.dart';
import 'package:online/controllers/live_classes_controller/live_classes_binding.dart';
import 'package:online/controllers/my_course_detail_controller/my_course_detail_binding.dart';
import 'package:online/controllers/notification_controller/notification_controller_binding.dart';
import 'package:online/controllers/profile_controller/profile_controller_binding.dart';
import 'package:online/controllers/quiz_controller/quiz_controller_binding.dart';
import 'package:online/controllers/recorded_classes_controller/recorded_classes_binding.dart';
import 'package:online/controllers/select_course_controller/select_course_binding.dart';
import 'package:online/controllers/setting_controller/setting_controller_binding.dart';
import 'package:online/controllers/shop_controller/shop_controller_binding.dart';
import 'package:online/controllers/test_controller/test_controller_binding.dart';
import 'package:online/controllers/test_series_controller/test_series_binding.dart';
import 'package:online/controllers/transfer_controller/transfer_controller_binding.dart';
import 'package:online/utils/app_routes/routes.dart';
import 'package:online/view/auth_view/mobile_number_view.dart';
import 'package:online/view/auth_view/otp_verify_view.dart';
import 'package:online/view/books_review_view/books_review_screen.dart';
import 'package:online/view/chat_view_screen/chat_screen.dart';
import 'package:online/view/check_result_view/check_result_view.dart';
import 'package:online/view/dashboard_page_view/dashboard_page_view.dart';
import 'package:online/view/enter_user_details_view/enter_user_details.dart';
import 'package:online/view/help_support_view/help_support_view_screen.dart';
import 'package:online/view/home_page_view/home_page_view_screen.dart';
import 'package:online/view/home_page_view/see_all_courses/see_all_courses_view.dart';
import 'package:online/view/intro_view/intro_view_screen.dart';
import 'package:online/view/live_classes_view/live_classes_view.dart';
import 'package:online/view/my_course_detail_view/my_course_detail_screen.dart';
import 'package:online/view/notification_view/notification_view_screen.dart';
import 'package:online/view/pdf_preview_page/pdf_view.dart';
import 'package:online/view/profile_view/profile_edit_screen.dart';
import 'package:online/view/profile_view/profile_view_screen.dart';
import 'package:online/view/quiz_view/quiz_view_screen.dart';
import 'package:online/view/recorded_classes_view/recorded_classes_view.dart';
import 'package:online/view/select_course_view/select_course_view.dart';
import 'package:online/view/setting_view/setting_view_screen.dart';
import 'package:online/view/shop_view/book_detail_view/add_to_cart.dart';
import 'package:online/view/shop_view/book_detail_view/bool_detail_view_screen.dart';
import 'package:online/view/shop_view/shop_view_screen.dart';
import 'package:online/view/splash_view/splash_view_screen.dart';
import 'package:online/view/test_view/test_series_view/test_series_view_screen.dart';
import 'package:online/view/transfer_course_view/transfer_view_screen.dart';
import 'package:online/view/your_order_view/your_order_screen.dart';

import '../../controllers/orders_controller/orders_controller_binding.dart';
import '../../view/result_screen/result_screen.dart';
import '../../view/search_view_screen/search_view_screen.dart';

class RoutePages{

static pages() => [

    GetPage(
        name: RoutesName.splashViewScreen,
        page: ()=> const SplashViewScreen(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.introViewScreen,
        page: ()=> const IntroViewScreen(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.mobileNumberView,
        page: ()=> MobileNumberView(),
        binding: AuthControllerBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.otpVerifyView,
        page: ()=> OtpVerifyView(),
        binding: AuthControllerBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.selectCourseView,
        page: ()=> SelectCourseView(),
        binding: SelectCourseBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.dashBoardPageView,
        page: ()=> DashBoardPageView(),
        bindings: [
            DashBoardControllerBinding(),
            ShopControllerBinding(),
            TestControllerBinding(),
            HomeControllerBinding(),
            ProfileControllerBinding()
        ],
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.settingView,
        page: ()=> SettingViewScreen(),
        binding: SettingControllerBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.helpSupportView,
        page: ()=> HelpSupportViewScreen(),
        binding: HelpSupportBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),


    GetPage(
        name: RoutesName.searchView,
        page: ()=> SearchViewScreen(),
        // binding: HelpSupportBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.profileView,
        page: ()=> ProfileViewScreen(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.notificationView,
        page: ()=> NotificationViewScreen(),
        binding: NotificationControllerBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.myCourseDetailView,
        page: ()=> MyCourseDetailScreen(),
        binding: MyCourseDetailBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.homeView,
        page: ()=> HomePageViewScreen(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.seeAllCoursesView,
        page: ()=> SeeAllCoursesView(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.testSeriesView,
        page: ()=> TestSeriesViewScreen(),
        binding: TestSeriesBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.shopViewScreen,
        page: ()=> ShopViewScreen(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.quizViewScreen,
        page: ()=> QuizViewScreen(),
        binding: QuizControllerBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.ResultScreen,
        page: ()=> ResultScreen(),
        // binding: QuizControllerBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.bookDetailScreen,
        page: ()=> BookDetailViewScreen(),
        binding: BookControllerBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.addToCartView,
        page: ()=> AddToCart(),
        binding: AddToCartBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.youOrderView,
        page: ()=> YourOrderScreen(),
        binding: OrdersControllerBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.booksReviewScreen,
        page: ()=> BooksReviewScreen(),
        binding: BookControllerBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.profileEditView,
        page: ()=> ProfileEditScreen(),
        binding: EditProfileControllerBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.transferCourseView,
        page: ()=> TransferViewScreen(),
        binding: TransferControllerBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.recordedClassesView,
        page: ()=> RecordedClassesView(),
        binding: RecordedClassesBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.pdfViewScreen,
        page: ()=> PdfView(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.checkResultViewScreen,
        page: ()=> CheckResultView(),
        binding: CheckResultBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.chatScreenView,
        page: ()=> ChatScreen(),
        binding: ChatControllerBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.liveClassesView,
        page: ()=> LiveClassesView(),
        binding: LiveClassesBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
        name: RoutesName.userDetailsView,
        page: ()=> EnterUserDetails(),
        binding: UserDetailControllerBinding(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 300),
    ),

  ];

}