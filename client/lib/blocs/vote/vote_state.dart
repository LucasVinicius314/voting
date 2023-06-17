class VoteState {}

class InitialVoteState extends VoteState {}

// SubmitVote

class SubmitVoteLoadingState extends VoteState {}

class SubmitVoteDoneState extends VoteState {}

class SubmitVoteErrorState extends VoteState {
  SubmitVoteErrorState({
    required this.message,
  });

  final String message;
}
