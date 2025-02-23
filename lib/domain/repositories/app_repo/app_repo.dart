import 'package:movie_app/domain/models/movie_res_model.dart';

abstract class AppRepo {
  Future<MovieResModel> getAllPopularMovies(
      {required int pageNo, required String language});

  Future<MovieResModel> getMovies(
      {required int pageNo, required String language , required String path});

  Future<MovieResModel> getTopRatedMovies(
      {required int pageNo, required String language});

  Future<MovieResModel> getNowPlayingMovies(
      {required int pageNo, required String language});

  Future<MovieResModel> getUpcomingMovies(
      {required int pageNo, required String language});
}
