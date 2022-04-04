import 'package:get/get.dart';
import 'package:testing_api/pages/detail_page.dart';
import 'package:testing_api/pages/home_page.dart';

class RouteHelper {
  static String home = '/';
  static String detail = '/detail';

  static List<GetPage> routes = [
    GetPage(
      name: home,
      page: () => HomePage(),
    ),
    GetPage(
      name: detail,
      page: () => DetailPage(),
    ),
  ];
}
