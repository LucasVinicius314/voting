import 'package:voting/models/responses/list_roles_response.dart';
import 'package:voting/utils/api.dart';

abstract class RoleRepository {
  Future<ListRolesResponse> listRoles();
}

class ApiRoleRepository extends RoleRepository {
  ApiRoleRepository({required this.api});

  final Api api;

  @override
  Future<ListRolesResponse> listRoles() async {
    // TODO: implement

    final req = api.get(
      path: '/...',
    );

    return ListRolesResponse.fromJson(await req);
  }
}

class MockRoleRepository extends RoleRepository {
  @override
  Future<ListRolesResponse> listRoles() async {
    return ListRolesResponse(president: [], mayor: []);
  }
}
