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
    final req = api.get(
      path: '/api/candidates',
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
          id: '',
          acronym: 'PA',
          name: 'Partido A',
          candidates: [
            Candidate(
              id: '',
              partyId: '',
              role: '',
              code: 043,
              name: 'Pedro Algo',
            ),
            Candidate(
              id: '',
              partyId: '',
              role: '',
              code: 072,
              name: 'Marcelo Alguma Coisa',
            ),
          ],
        ),
        Party(
          id: '',
          acronym: 'PB',
          name: 'Partido B',
          candidates: [
            Candidate(
              id: '',
              partyId: '',
              role: '',
              code: 563,
              name: 'Caio',
            ),
            Candidate(
              id: '',
              partyId: '',
              role: '',
              code: 102,
              name: 'Caique Legal',
            ),
          ],
        ),
      ],
      mayor: [
        Party(
          id: '',
          acronym: 'PG',
          name: 'Partido G',
          candidates: [
            Candidate(
              id: '',
              partyId: '',
              role: '',
              code: 057,
              name: 'Pedrinho Álvares',
            ),
            Candidate(
              id: '',
              partyId: '',
              role: '',
              code: 742,
              name: 'Lucas Casca',
            ),
          ],
        ),
        Party(
          id: '',
          acronym: 'PO',
          name: 'Partido O',
          candidates: [
            Candidate(
              id: '',
              partyId: '',
              role: '',
              code: 956,
              name: 'Kleber',
            ),
            Candidate(
              id: '',
              partyId: '',
              role: '',
              code: 102,
              name: 'Fred Brabo',
            ),
          ],
        ),
      ],
    );
  }
}
