import 'package:movie_app/data/data_utility/api_end_points.dart';
import 'package:movie_app/domain/models/movie_res_model.dart';
import 'package:movie_app/domain/repositories/app_repo/app_repo.dart';
import 'package:movie_app/domain/use_cases/use_case.dart';

class GetPopularMoviesParams {
  final int pageNo;
  final String language;

  const GetPopularMoviesParams({required this.pageNo, required this.language});
}

class GetPopularMoviesUseCase extends UseCase<MovieResModel, GetPopularMoviesParams> {
  final AppRepo appRepo;

  GetPopularMoviesUseCase({required this.appRepo});

  @override
  Future<MovieResModel> call(GetPopularMoviesParams params) {
    return appRepo.getMovies(
      pageNo: params.pageNo,
      language: params.language,
      path: ApiEndPoints.popularMovies,
    );
  }
}