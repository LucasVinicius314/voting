import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting/blocs/role/role_event.dart';
import 'package:voting/blocs/role/role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  // TODO: fix, colocar repository
  RoleBloc() : super(InitialRoleState()) {
    on<ListRolesEvent>((event, emit) async {
      // TODO: fix
      // emit(NotificationState(
      //   title: event.title,
      //   body: event.body,
      // ));
    });
  }
}
