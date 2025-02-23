part of 'splash_bloc.dart';

@freezed
class SplashState with _$SplashState {
  const factory SplashState.initial() = _Initial;
  const factory SplashState.unAuthorisedState() = _UnAuthorisedState;
  const factory SplashState.authorisedState() = _AuthorisedState;
  const factory SplashState.dataGetsLoadedState() = _DataLoadedState;
}
