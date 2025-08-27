import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_it/get_it.dart';
import 'package:get/get.dart';
import 'package:online/data/firebase_service/firebase_notification_service.dart';
import 'package:online/firebase_options.dart';
import 'package:online/utils/app_routes/route_pages.dart';
import 'package:online/utils/app_routes/routes.dart';
import 'package:online/utils/global_variables/global_variables.dart';
import 'package:online/controllers/home_controller/home_controller.dart';
import 'package:online/controllers/test_controller/test_controller.dart';
import 'package:online/controllers/shop_controller/shop_controller.dart';

import '../../controllers/dashboard_controller/dashboard_controller.dart';

String appEnv = "";

Future<void> mainCommon(String env) async {
  WidgetsFlutterBinding.ensureInitialized();
  appEnv = env;
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('firebase error $e');
  }

  FirebaseNotificationServices notificationServices = FirebaseNotificationServices();
  notificationServices.requestNotificationPermission();
  notificationServices.initLocalNotifications();

  ///handle foreground notifications
  notificationServices.firebaseInit();

  setupLocator();
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler() async{
  await Firebase.initializeApp();
}

final getIt = GetIt.instance;
void setupLocator() {
  getIt.registerLazySingleton<GlobalVariables>(() => GlobalVariables());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,]);
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Inter'
      ),
      debugShowCheckedModeBanner: false,
      title: 'Online',
      initialRoute: RoutesName.splashViewScreen,
      getPages: RoutePages.pages(),
    );
  }
}
