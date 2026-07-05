import 'package:dio/dio.dart' as dio;
import 'package:get_it/get_it.dart';
import 'package:movie_app/data/data_utility/api_end_points.dart';
import 'package:movie_app/data/repositories/app_repo/app_repo_impl.dart';
import 'package:movie_app/domain/repositories/app_repo/app_repo.dart';
import 'package:movie_app/domain/use_cases/get_popular_movies_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';



final di = GetIt.instance;

// curl --request GET \
// --url 'https://api.themoviedb.org' \
// --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiOWZhNDUzMjhmZmZlMzdhZjg2YmUwZmIwMTNhNmZkZCIsIm5iZiI6MTczODU2ODE0Mi4wNDEsInN1YiI6IjY3YTA3MWNlYWM1YTc5NTFiOWNiODYyZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.uDR9157Qqdyyyobqt_KusXhK_BXtbUfUrgnrqM6O-W8' \
// --header 'accept: application/json'

Future<void> setup() async {
  di.registerSingleton<dio.Dio>(dio.Dio(dio.BaseOptions(
       baseUrl: ApiEndPoints.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10))));

  di.registerSingleton<AppRepo>(AppRepoImpl(dioInst: di()));

  di.registerSingleton<GetPopularMoviesUseCase>(
    GetPopularMoviesUseCase(appRepo: di()),
  );

  di.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });

}


//di<AppRepo>().update