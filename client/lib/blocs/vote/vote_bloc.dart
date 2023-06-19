import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting/blocs/vote/vote_event.dart';
import 'package:voting/blocs/vote/vote_state.dart';
import 'package:voting/repositories/vote_repository.dart';

class VoteBloc extends Bloc<VoteEvent, VoteState> {
  VoteBloc({
    required this.voteRepository,
  }) : super(InitialVoteState()) {
    on<SubmitVoteEvent>((event, emit) async {
      try {
        emit(SubmitVoteLoadingState());

        await voteRepository.sumbitVote(event: event);

        emit(SubmitVoteDoneState());
      } catch (e) {
        emit(SubmitVoteErrorState(message: e.toString()));
      }
    });
  }

  final VoteRepository voteRepository;
}
