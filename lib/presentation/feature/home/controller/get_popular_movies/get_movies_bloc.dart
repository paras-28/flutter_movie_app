import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_app/config/dependency_injection/di.dart';
import 'package:movie_app/data/data_utility/api_end_points.dart';
import 'package:movie_app/domain/models/movie_res_model.dart';
import 'package:movie_app/domain/repositories/app_repo/app_repo.dart';

part 'get_movies_event.dart';

part 'get_movies_state.dart';
part 'get_movies_bloc.freezed.dart';

class GetMoviesBloc
    extends Bloc<GetMoviesEvent, GetMoviesState> {
  GetMoviesBloc()
      : super(GetMoviesState.initial()) {
    on<_GetNowPlayingApiRequestEvent>((event, emit) async {
      try {
        emit(state.copyWith(
            showLoader: true,
            hasMessage: '',
            hasError: '',
            movieResModel: null));

        await Future.delayed(Duration(seconds: 3));
        MovieResModel popularMoviesResModel = await di<AppRepo>()
            .getMovies(
            language: event.language,
            pageNo: event.pageNo,
            path: ApiEndPoints.popularMovies);
        emit(state.copyWith(
            showLoader: false, movieResModel: popularMoviesResModel));
      } catch (e) {
        emit(state.copyWith(showLoader: false, hasError: e.toString()));
      }

    });


  }
}
