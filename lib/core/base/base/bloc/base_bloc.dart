import 'package:bloc/bloc.dart';
import 'package:employee_hub/core/base/base/bloc/api_base_bloc/api_base_bloc.dart';


abstract class BaseBloc<Event, State> extends Bloc<Event, State> {
  BaseBloc(this.apiBaseBlocObject, State initialState) : super(initialState);

  final ApiBaseBloc apiBaseBlocObject;

  Future<void> addDelayForDialogPopAndScreenNavigation() async =>
      await Future.delayed(
        Duration(
          milliseconds: 20,
        ),
      );

  Future<void> mockAPIDelay() async => await Future.delayed(
        Duration(
          milliseconds: 300,
        ),
      );
}
