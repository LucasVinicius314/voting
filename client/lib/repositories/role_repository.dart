import 'package:voting/models/candidate.dart';
import 'package:voting/models/party.dart';
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
    await Future.delayed(const Duration(seconds: 1));

    return ListRolesResponse(
      president: [
        Party(
          acronym: 'PA',
          name: 'Partido A',
          candidates: [
            Candidate(
              code: 043,
              name: 'Pedro Algo',
            ),
            Candidate(
              code: 072,
              name: 'Marcelo Alguma Coisa',
            ),
          ],
        ),
        Party(
          acronym: 'PB',
          name: 'Partido B',
          candidates: [
            Candidate(
              code: 563,
              name: 'Caio',
            ),
            Candidate(
              code: 102,
              name: 'Caique Legal',
            ),
          ],
        ),
      ],
      mayor: [
        Party(
          acronym: 'PG',
          name: 'Partido G',
          candidates: [
            Candidate(
              code: 057,
              name: 'Pedrinho Álvares',
            ),
            Candidate(
              code: 742,
              name: 'Lucas Casca',
            ),
          ],
        ),
        Party(
          acronym: 'PO',
          name: 'Partido O',
          candidates: [
            Candidate(
              code: 956,
              name: 'Kleber',
            ),
            Candidate(
              code: 102,
              name: 'Fred Brabo',
            ),
          ],
        ),
      ],
    );
  }
}
