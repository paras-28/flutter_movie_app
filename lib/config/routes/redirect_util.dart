import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/config/dependency_injection/di.dart';
import 'package:movie_app/core/utils/shared_prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RedirectUtil {
  static Future<String?> redirect(
      BuildContext context, GoRouterState state) async {
    debugPrint("redirect for auth working");
    bool userAuthenticated =
        di<SharedPreferences>().getBool(SharedPrefsKeys.isAuthenticated) ??
            false;

    String path = state.uri.toString();

    debugPrint("userAuthenticated $userAuthenticated");
    debugPrint("path $path");
    if (userAuthenticated == false) {
      return '/login';
    } else {
      return null;
    }
  }
}
