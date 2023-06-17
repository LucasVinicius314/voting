import 'package:voting/models/party.dart';

class RoleState {}

class InitialRoleState extends RoleState {}

// ListRoles

class ListRolesLoadingState extends RoleState {}

class ListRolesDoneState extends RoleState {
  ListRolesDoneState({
    required this.president,
    required this.mayor,
  });

  final List<Party> president;
  final List<Party> mayor;
}

class ListRolesErrorState extends RoleState {
  ListRolesErrorState({
    required this.message,
  });

  final String message;
}
