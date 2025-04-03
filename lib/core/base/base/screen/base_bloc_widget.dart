import 'package:employee_hub/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/api_base_bloc/api_base_bloc.dart';
import '../bloc/api_base_bloc/api_base_bloc_state.dart';
import 'base_screen.dart';

abstract class BaseBlocWidget extends BaseScreen {
  const BaseBlocWidget({Key? key}) : super(key: key);
}

abstract class BaseBlocWidgetState<T extends BaseBlocWidget>
    extends BaseScreenState<T> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColors.darkPrimaryColor));
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) => super.build(context);

  @override
  Widget body(BuildContext context) => MultiBlocListener(
        listeners: [
          BlocListener<ApiBaseBloc, ApiBaseBlocState>(
            listenWhen: (prevState, curState) => prevState != curState,
            listener: (ctx, state) {
              if (state is ApiErrorState) {
              } else if (state is ApiLoadingState) {
              } else if (state is ApiLoadedState) {}
            },
          ),
        ],
        child: getCustomBloc(),
      );

  Widget getCustomBloc();
}
