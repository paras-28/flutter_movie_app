import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/config/routes/app_routes_name.dart';
import 'package:movie_app/core/utils/app_strings.dart';
import 'package:movie_app/core/utils/debug_logger.dart';
import 'package:movie_app/core/utils/responsive_util.dart';
import 'package:movie_app/core/utils/validator.dart';
import 'package:movie_app/presentation/common_widgets/app_text_field.dart';
import 'package:movie_app/presentation/common_widgets/common_widgets.dart';
import 'package:movie_app/presentation/common_widgets/snackbar/error_snackbar_view.dart';
import 'package:movie_app/presentation/feature/auth/controller/login_bloc.dart';

import '../../../data/data_utility/api_end_points.dart';
import '../home/controller/get_popular_movies/get_movies_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _textEditingControllerEmail;
  late TextEditingController _textEditingControllerPassword;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _textEditingControllerEmail = TextEditingController();
    _textEditingControllerPassword = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingControllerEmail.dispose();
    _textEditingControllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
     child: Scaffold(
       body: BlocListener<LoginBloc, LoginState>(
         listener: (context, state) {
           debuggerAdvance(tag: "state is", value: state);
           if (state is ErrorLoginState) {
             ScaffoldMessenger.of(context)
                 .showSnackBar(errorSnackBarView(message: state.error));
           } else if (state is LoadedLoginState) {
             // ScaffoldMessenger.of(context).showSnackBar(
             //     infoSnackBarView(message: AppStrings.successfullyLogin));
             context.read<GetMoviesBloc>().add(GetMoviesEvent.getNowPlayingApiRequestEvent(
                 pageNo: 1,
                 language: 'en-us',
                 apiPath: ApiEndPoints.popularMovies));

             context.goNamed(AppRoutesName.homePage);
           }
         },
         child: Form(
           key: _formKey,
           child: Center(
             child: SizedBox(
               width: Responsive.setWidthByPercentage(90),
               child: Column(
                 children: [
                   Spacer(),
                   Icon(
                     Icons.slow_motion_video_sharp,
                     size: 50,
                   ),
                   const TextView(
                     title: AppStrings.movieu,
                     fontSize: 32,
                     fontWeight: FontWeight.bold,
                     fontStyle: FontStyle.italic,
                   ),
                   const Spacer(),
                   AppTextField(
                     controller: _textEditingControllerEmail,
                     context: context,
                     validator: Validator.validateEmail,
                     headingText: AppStrings.emailAddress,
                   ),
                   AppTextField(
                     controller: _textEditingControllerPassword,
                     context: context,
                     validator: Validator.validateEmpty,
                     headingText: AppStrings.password,
                     margin: EdgeInsets.only(top: 20),
                   ),
                   const Spacer(),
                   BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                     if (state is LoadingLoginState) {
                       return CustomLoader();
                     } else {
                       return AppButton(
                           title: AppStrings.login,
                           onPressed: () {
                             if (_formKey.currentState!.validate()) {
                               context.read<LoginBloc>().add(LoginRequestEvent(
                                   email: _textEditingControllerEmail.text,
                                   password:
                                   _textEditingControllerPassword.text));
                             }
                           });
                     }
                   }),
                   Spacer(
                     flex: 2,
                   ),
                 ],
               ),
             ),
           ),
         ),
       ),
     ),
    );
  }
}
