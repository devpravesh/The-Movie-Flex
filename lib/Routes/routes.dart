import 'package:get/get.dart';
import 'package:themovieflex/View/detail_page.dart';

import '../View/homepage.dart';
import 'binding.dart';

class AppRoutes {
  static const homePage = '/homepage';
  static const movieDetail = '/movieDetail';
  static final routes = [
    GetPage(
        name: homePage, page: () => const Homepage(), binding: HomeBinding()),
    GetPage(
        name: movieDetail, page: () => MovieDetailScreen()),
  ];
}
