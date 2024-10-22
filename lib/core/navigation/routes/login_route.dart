import 'package:notes/core/navigation/routes/profile_route.dart';

class LoginRoute {
  static const String name = 'login';

  static String get navigateRoute => '${ProfileRoute.name}/$name';
}