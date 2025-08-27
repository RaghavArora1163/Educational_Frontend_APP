import 'dart:io';
import 'package:online/data/app_environment/environment/environment.dart';
import 'package:online/data/http_override_client/my_http_override.dart';
import 'main.dart';

void main(){
  HttpOverrides.global = MyHttpOverride();
   mainCommon(Environment.dev);
 }