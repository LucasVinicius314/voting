import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting/blocs/role/role_event.dart';
import 'package:voting/blocs/role/role_state.dart';
import 'package:voting/repositories/role_repository.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  RoleBloc({
    required this.roleRepository,
  }) : super(InitialRoleState()) {
    on<ListRolesEvent>((event, emit) async {
      try {
        emit(ListRolesLoadingState());

        final res = await roleRepository.listRoles();

        emit(ListRolesDoneState(
          mayor: res.mayor ?? [],
          president: res.president ?? [],
        ));
      } catch (e) {
        emit(ListRolesErrorState(message: e.toString()));
      }
    });
  }

  final RoleRepository roleRepository;
}
