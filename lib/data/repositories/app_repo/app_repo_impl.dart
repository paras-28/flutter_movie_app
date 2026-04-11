import 'package:dio/dio.dart' as dio;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/data/data_utility/api_end_points.dart';
import 'package:movie_app/data/data_utility/exception_handler.dart';
import 'package:movie_app/data/rest_client/dio_base.dart';
import 'package:movie_app/domain/models/movie_res_model.dart';
import 'package:movie_app/domain/repositories/app_repo/app_repo.dart';

class AppRepoImpl implements AppRepo {
  dio.Dio dioInst;

  AppRepoImpl({required this.dioInst});

  Map<String, String> getHTTPHeader() {
    return {
      "Authorization": 'Bearer ${dotenv.env['TMDBI_KEY']}',
      'Content-type': 'application/json',
    };
  }

  @override
  Future<MovieResModel> getAllPopularMovies(
      {required int pageNo, required String language}) async {
    dioInst.options.headers = getHTTPHeader();
    dio.BaseOptions options = dioInst.options;
    dioInst.options = options;
    try {
      var response = await DioClient(dioInst).get(
          url: ApiEndPoints.popularMovies,
          uniqueKey: "getAllPopularMovies",
          queryParameters: {'language': language, 'page': pageNo});
      return MovieResModel.fromJson(response.data);
    } on dio.DioException catch (e) {
      throw DioExceptions.fromDioError(
              dioError: e, errorFrom: "getAllPopularMovies")
          .errorMessage();
      // if you want to customize the  error message
      //  int statusCode =  DioExceptions.fromDioError(dioError: e, errorFrom: "login").errorStatusCode();
      //  if(statusCode == 400)
      //  {
      //    throw "Incorrect Email Password";
      //  }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MovieResModel> getMovies(
      {required int pageNo,
      required String language,
      required String path}) async {
    dioInst.options.headers = getHTTPHeader();
    dio.BaseOptions options = dioInst.options;
    dioInst.options = options;
    try {
      var response = await DioClient(dioInst).get(
        url: ApiEndPoints.basePath + path,
        uniqueKey: ApiEndPoints.basePath + path,
        queryParameters: {'language': language, 'page': pageNo},
      );
      return MovieResModel.fromJson(response.data);
    } on dio.DioException catch (e) {
      throw DioExceptions.fromDioError(
              dioError: e, errorFrom: ApiEndPoints.basePath + path)
          .errorMessage();
      // if you want to customize the error message
      //  int statusCode =  DioExceptions.fromDioError(dioError: e, errorFrom: "login").errorStatusCode();
      //  if(statusCode == 400)
      //  {
      //    throw "Incorrect Email Password";
      //  }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MovieResModel> getNowPlayingMovies(
      {required int pageNo, required String language}) async {
    dioInst.options.headers = getHTTPHeader();
    dio.BaseOptions options = dioInst.options;
    dioInst.options = options;
    try {
      var response = await DioClient(dioInst).get(
          url: ApiEndPoints.popularMovies,
          uniqueKey: "getNowPlayingMovies",
          queryParameters: {'language': language, 'page': pageNo});
      return MovieResModel.fromJson(response.data);
    } on dio.DioException catch (e) {
      throw DioExceptions.fromDioError(
              dioError: e, errorFrom: "getNowPlayingMovies")
          .errorMessage();
      // if you want to customize the error message
      //  int statusCode =  DioExceptions.fromDioError(dioError: e, errorFrom: "login").errorStatusCode();
      //  if(statusCode == 400)
      //  {
      //    throw "Incorrect Email Password";
      //  }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MovieResModel> getTopRatedMovies(
      {required int pageNo, required String language}) async {
    dioInst.options.headers = getHTTPHeader();
    dio.BaseOptions options = dioInst.options;
    dioInst.options = options;
    try {
      var response = await DioClient(dioInst).get(
          url: ApiEndPoints.topRatedMovies,
          uniqueKey: "getTopRatedMovies",
          queryParameters: {'language': language, 'page': pageNo});
      return MovieResModel.fromJson(response.data);
    } on dio.DioException catch (e) {
      throw DioExceptions.fromDioError(
              dioError: e, errorFrom: "getTopRatedMovies")
          .errorMessage();
      // if you want to customize the error message
      //  int statusCode =  DioExceptions.fromDioError(dioError: e, errorFrom: "login").errorStatusCode();
      //  if(statusCode == 400)
      //  {
      //    throw "Incorrect Email Password";
      //  }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MovieResModel> getUpcomingMovies(
      {required int pageNo, required String language}) async {
    dioInst.options.headers = getHTTPHeader();
    dio.BaseOptions options = dioInst.options;
    dioInst.options = options;
    try {
      var response = await DioClient(dioInst).get(
          url: ApiEndPoints.upcomingMovies,
          uniqueKey: "getUpcomingMovies",
          queryParameters: {'language': language, 'page': pageNo});
      return MovieResModel.fromJson(response.data);
    } on dio.DioException catch (e) {
      throw DioExceptions.fromDioError(
              dioError: e, errorFrom: "getUpcomingMovies")
          .errorMessage();
      // if you want to customize the error message
      //  int statusCode =  DioExceptions.fromDioError(dioError: e, errorFrom: "login").errorStatusCode();
      //  if(statusCode == 400)
      //  {
      //    throw "Incorrect Email Password";
      //  }
    } catch (e) {
      rethrow;
    }
  }
}
