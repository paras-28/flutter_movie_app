import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_event.dart';
part 'splash_state.dart';
part 'splash_bloc.freezed.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState.initial()) {
    on<_RouteTransferEvent>((event, emit) {
      if(event.isUserAuthenticated == false)
        {
        emit(const SplashState.unAuthorisedState());
        }
      else
        {
         emit(const SplashState.authorisedState());
        }
    });

    // on<_RouteTransferEvent>((event, emit) {
    //   if(event.isUserAuthenticated == false)
    //     {
    //     emit(const SplashState.unAuthorisedState());
    //     }
    //   else
    //     {
    //      emit(const SplashState.dataGetsLoadedState());
    //     }
    // });
  }
}
