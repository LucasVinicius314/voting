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
    // TODO: implement

    await api.get(
      path: '/...',
    );
  }
}

class MockVoteRepository extends VoteRepository {
  @override
  Future<void> sumbitVote({required SubmitVoteEvent event}) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
