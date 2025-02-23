part of 'get_movies_bloc.dart';

@freezed
class GetMoviesState with _$GetMoviesState {
  factory GetMoviesState({
    bool? showLoader,
    String? hasMessage,
    String? hasError,
    MovieResModel? movieResModel,
  }) = _GetMoviesState;

  factory GetMoviesState.initial() {
    return GetMoviesState(hasError: '', hasMessage: '', showLoader: true);
  }
}
