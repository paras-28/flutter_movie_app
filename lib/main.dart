import 'dart:async';
import 'dart:ui';

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

main() async {
  // Shows layout boundaries with colored borders
  // debugPaintSizeEnabled = true;

  // Shows baseline alignments
  // debugPaintBaselinesEnabled = true;

  // Shows pointer tap areas
  // debugPaintPointersEnabled = true;

  /// if we want to show colors on each repaint then we can enable this flag
  // debugRepaintRainbowEnabled = true; and wrap target widget with RepaintBoundary()
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

  // Catches Flutter framework errors (widget build errors, etc.)
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details); // Default behavior
    // Custom logging
    debugPrint('Flutter error: ${details.exception}');
  };

  // Catches errors not handled by Flutter (platform errors)
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('Platform error: $error');
    return true; // Prevents app crash
  };

  /// Async errors require special handling because
  /// they don’t propagate through normal try-catch if not awaited properly.
  runZonedGuarded(
    () => runApp(MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GetMoviesBloc()),
          BlocProvider(
              create: (context) => SplashBloc()
                ..add(SplashEvent.routeDecider(
                    isUserAuthenticated: userAuthenticated))),
        ],
        child: MyApp(
          isAuthenticated: userAuthenticated,
        ))),
    (error, stackTrace) {
      // Catches all unhandled async errors
      debugPrint('Caught error: $error');
      debugPrint('Stack trace: $stackTrace');
      // Send to crash reporting service (e.g., Firebase Crashlytics)
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.isAuthenticated});

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
      // showPerformanceOverlay: true,  // Shows frame rendering graph
      // checkerboardRasterCacheImages: true,  // Highlights cached images
      // checkerboardOffscreenLayers: true,  // Shows offscreen rendering
      routerConfig: AppRouter.routers,
      title: 'Movie app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
    );
  }
}
