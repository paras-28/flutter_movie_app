import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_app/config/dependency_injection/di.dart';
import 'package:movie_app/domain/models/movie_res_model.dart';
import 'package:movie_app/domain/use_cases/get_popular_movies_use_case.dart';

part 'get_movies_event.dart';

part 'get_movies_state.dart';
part 'get_movies_bloc.freezed.dart';

class GetMoviesBloc extends Bloc<GetMoviesEvent, GetMoviesState> {
  GetMoviesBloc() : super(GetMoviesState.initial()) {
    on<_GetNowPlayingApiRequestEvent>((event, emit) async {
      try {
        emit(state.copyWith(
            showLoader: true, hasMessage: '', hasError: '', movieResModel: null));

        await Future.delayed(Duration(seconds: 3));

        MovieResModel result = await di<GetPopularMoviesUseCase>()(
          GetPopularMoviesParams(language: event.language, pageNo: event.pageNo),
        );

        emit(state.copyWith(showLoader: false, movieResModel: result));
      } catch (e) {
        emit(state.copyWith(showLoader: false, hasError: e.toString()));
      }
    });
  }
}
