import 'package:voting/models/responses/get_results_response.dart';
import 'package:voting/models/result.dart';
import 'package:voting/models/vote_results.dart';
import 'package:voting/utils/api.dart';

abstract class ResultsRepository {
  Future<GetResultsResponse> getResults();
}

class ApiResultsRepository extends ResultsRepository {
  ApiResultsRepository({required this.api});

  final Api api;

  @override
  Future<GetResultsResponse> getResults() async {
    final req = api.get(
      path: '/api/results',
    );

    return GetResultsResponse.fromJson(await req);
  }
}

class MockResultsRepository extends ResultsRepository {
  @override
  Future<GetResultsResponse> getResults() async {
    await Future.delayed(const Duration(seconds: 1));

    return GetResultsResponse(
      mayorVoteResults: VoteResults(
        voteCount: 24,
        votesByCandidate: [],
        votesByParty: [],
        votesByAge: [],
        votesByGender: [],
      ),
      presidentVoteResults: VoteResults(
        voteCount: 24,
        votesByCandidate: [
          Result(
            primaryLabel: 'Carlos massa',
            secondaryLabel: 'Partido A',
            value: 4,
          ),
          Result(
            primaryLabel: 'Carlos legal',
            secondaryLabel: 'Partido B',
            value: 40,
          ),
          Result(
            primaryLabel: 'Vanessa',
            secondaryLabel: 'Partido B',
            value: 26,
          ),
          Result(
            primaryLabel: 'Vandelei',
            secondaryLabel: 'Partido C',
            value: 10,
          ),
          Result(
            primaryLabel: 'Caio',
            secondaryLabel: 'Partido C',
            value: 14,
          ),
          Result(
            primaryLabel: 'Fred',
            secondaryLabel: 'Partido A',
            value: 34,
          ),
          Result(
            primaryLabel: 'marcos',
            secondaryLabel: 'Partido A',
            value: 34,
          ),
          Result(
            primaryLabel: 'Caique',
            secondaryLabel: 'Partido A',
            value: 34,
          ),
        ],
        votesByParty: [],
        votesByAge: [],
        votesByGender: [],
      ),
    );
  }
}
