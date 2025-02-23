part of 'get_movies_bloc.dart';

/*sealed class GetMoviesEvent extends Equatable {
  const GetMoviesEvent();
}

class GetPopularMoviesAPIRequestEvent extends GetMoviesEvent {
  final String language;
  final int pageNo;
  final String apiPath;

  const GetPopularMoviesAPIRequestEvent(
      {required this.language, required this.pageNo, required this.apiPath});

  @override
  List<Object?> get props => [language, pageNo, apiPath];
}*/

/*
class GetNowPlayingApiRequestEvent extends GetMoviesEvent {
  final String language;
  final int pageNo;
  final String apiPath;

  const GetNowPlayingApiRequestEvent(
      {required this.language, required this.pageNo, required this.apiPath});

  @override
  List<Object?> get props => [language, pageNo, apiPath];
}

class GetTopRatedMoviesApiRequestEvent extends GetMoviesEvent {
  final String language;
  final int pageNo;
  final String apiPath;

  const GetTopRatedMoviesApiRequestEvent(
      {required this.language, required this.pageNo, required this.apiPath});

  @override
  List<Object?> get props => [language, pageNo, apiPath];
}

class GetUpcomingMoviesApiRequestEvent extends GetMoviesEvent {
  final String language;
  final int pageNo;

  const GetUpcomingMoviesApiRequestEvent(
      {required this.language, required this.pageNo});

  @override
  List<Object?> get props => [language, pageNo];
}
*/


@freezed
class GetMoviesEvent with _$GetMoviesEvent {
  const factory GetMoviesEvent.getNowPlayingApiRequestEvent(
  {
    required String language,
    required int pageNo,
    required String apiPath
}
      ) =_GetNowPlayingApiRequestEvent;
  // const factory GetMoviesEvent.decrementButtonPressed() = _DecrementButtonPressed;
}