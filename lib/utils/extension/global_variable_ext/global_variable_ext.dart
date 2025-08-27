import 'package:get_it/get_it.dart';
import 'package:online/utils/global_variables/global_variables.dart';

extension GetItExtensions on GetIt {
  GlobalVariables get globalVariable => get<GlobalVariables>();
}