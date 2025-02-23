import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/config/routes/app_router_navigator_key.dart';
import 'package:movie_app/config/routes/app_router_observer.dart';
import 'package:movie_app/config/routes/app_routes_name.dart';
import 'package:movie_app/config/routes/redirect_util.dart';
import 'package:movie_app/presentation/feature/auth/login_page.dart';
import 'package:movie_app/presentation/feature/home/home_page.dart';
import 'package:movie_app/presentation/feature/splash_interceptor/splash_interceptor_page.dart';


class AppRouter {


  static final routers = GoRouter(
      observers: [
        GoRouterObserver(),
      ],
      debugLogDiagnostics: true,
      navigatorKey: AppRouterNavigatorKey.rootNavigatorKey,
      initialLocation: '/splash',
      routes: [
        GoRoute(
          path: '/login',
          name: AppRoutesName.loginPage,
          builder: (context, state) => LoginPage(),
          redirect: (context , state)
          {
            return RedirectUtil.redirect(context, state);
          },
        ),
        GoRoute(
          path: '/splash',
          name: AppRoutesName.splashPage,
          builder: (context, state) => SplashInterceptorPage(),
          // redirect: (context , state)
          // {
          //   return RedirectUtil.redirect(context, state);
          // },
        ),
        GoRoute(
          path: '/home',
          name: AppRoutesName.homePage,
          builder: (context, state) => HomePage(),
          redirect: RedirectUtil.redirect,
        ),
      ]);
}


