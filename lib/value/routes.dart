import 'package:get/get.dart';
import 'package:skill_test_assignment/screen/screen_home.dart';

class Routes {
  static const String home = '/';

  static List<GetPage<dynamic>> getPages = [
    GetPage(name: home, page: (() => const HomeScreen()))
  ];
}
