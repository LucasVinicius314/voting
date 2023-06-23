import 'package:voting/blocs/vote/vote_event.dart';
import 'package:voting/utils/api.dart';

abstract class VoteRepository {
  Future<void> sumbitVote({
    required SubmitVoteEvent event,
  });
}

class ApiVoteRepository extends VoteRepository {
  ApiVoteRepository({required this.api});

  final Api api;

  @override
  Future<void> sumbitVote({required SubmitVoteEvent event}) async {
    await api.post(
      path: '/api/vote',
      body: {
        'presidentId': event.president.id,
        'mayorId': event.mayor.id,
        'cpf': event.cpf,
        'gender': event.gender.toString(),
        'latitude': event.latitude,
        'longitude': event.longitude,
        'birthDate': event.birthDate.toUtc().toIso8601String(),
      },
    );
  }
}

class MockVoteRepository extends VoteRepository {
  @override
  Future<void> sumbitVote({required SubmitVoteEvent event}) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
