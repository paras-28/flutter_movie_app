import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/config/routes/app_routes_name.dart';
import 'package:movie_app/core/utils/is_list_exist.dart';
import 'package:movie_app/data/data_utility/api_end_points.dart';
import 'package:movie_app/presentation/feature/home/controller/get_popular_movies/get_movies_bloc.dart';

import 'controller/splash_bloc.dart';

class SplashInterceptorPage extends StatefulWidget {
  const SplashInterceptorPage({super.key});

  @override
  State<SplashInterceptorPage> createState() => _SplashInterceptorPageState();
}

class _SplashInterceptorPageState extends State<SplashInterceptorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(listeners: [
        BlocListener<GetMoviesBloc, GetMoviesState>(listener: (BuildContext context ,
            GetMoviesState  state){
            if (state.movieResModel != null || stringHasValue(state.hasError)) {
              FlutterNativeSplash.remove();
              context.goNamed(AppRoutesName.homePage);
            }
          })
      ], child: BlocBuilder<SplashBloc,
          SplashState>(
        builder: (context, state) {
          return state.when(initial: () {
            return CircularProgressIndicator();
          }, unAuthorisedState: () {
            FlutterNativeSplash.remove();
            context.goNamed(AppRoutesName.loginPage);
            return CircularProgressIndicator();
          }, authorisedState: () {
            context.read<GetMoviesBloc>().add(GetMoviesEvent.getNowPlayingApiRequestEvent(
                pageNo: 1,
                language: 'en-us',
                apiPath: ApiEndPoints.popularMovies));
            return CircularProgressIndicator();
          }, dataGetsLoadedState: () {
            return CircularProgressIndicator();
          });
        },
      ),),
    );
  }
}
