import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movie_app/config/dependency_injection/di.dart'
    as serviceLocator;
import 'package:movie_app/config/routes/app_router.dart';
import 'package:movie_app/core/utils/responsive_util.dart';
import 'package:movie_app/presentation/feature/home/controller/get_popular_movies/get_movies_bloc.dart';
import 'package:movie_app/presentation/feature/splash_interceptor/controller/splash_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/dependency_injection/di.dart';
import 'core/utils/shared_prefs_keys.dart';
import 'data/data_utility/api_end_points.dart';

main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load(fileName: ".env");
  serviceLocator.setup();
  await di.allReady();

  bool userAuthenticated =
      di<SharedPreferences>().getBool(SharedPrefsKeys.isAuthenticated) ?? false;

  // GetMoviesBloc getMoviesBloc = GetMoviesBloc();

/*  /// if user is already authorised then load home page content
  if (userAuthenticated) {
    getMoviesBloc.add(GetMoviesEvent.getNowPlayingApiRequestEvent(
        pageNo: 1, language: 'en-us', apiPath: ApiEndPoints.popularMovies));

    getMoviesBloc.stream.listen((value) {
      if (value.movieResModel != null) {
        FlutterNativeSplash.remove();
        runApp(MultiBlocProvider(providers: [
          BlocProvider.value(value: getMoviesBloc),
          // Blocs which have single instance all over the app
          // BlocProvider(
          //     create: (context) => GetPopularMoviesBloc()..add(GetPopularMoviesAPIRequestEvent(pageNo: 1, language: 'en-us'))),
        ], child: MyApp()));
      }
    });
  }*/

  // FlutterNativeSplash.remove();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => GetMoviesBloc()),
    BlocProvider(create: (context) => SplashBloc()..add(SplashEvent
        .routeDecider(
      isUserAuthenticated: userAuthenticated
    ))),


        /*
    *
    *
    * */
  ], child: MyApp(
    isAuthenticated: userAuthenticated,
  )));

}

class MyApp extends StatefulWidget {
  const MyApp({super.key , required this.isAuthenticated});

  final bool isAuthenticated;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Responsive.size = MediaQuery.sizeOf(context);
    return MaterialApp.router(
      routerConfig: AppRouter.routers,
      title: 'Movie app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
    );
  }
}
