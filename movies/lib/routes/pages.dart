import 'package:flutter/cupertino.dart';
import 'package:movies/routes/routes.dart';
import 'package:movies/screens/screens.dart';

abstract class Pages {
  static Map<String, Widget Function(BuildContext)> routes = {
    Routes.home     : (_) => const HomePage(),
    Routes.details  : (_) => const DetailPage(),
    Routes.viewMore : (_) => const ViewMorePage(),
  };
}
