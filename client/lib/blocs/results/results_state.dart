import 'package:voting/models/vote_results.dart';

class ResultsState {}

class InitialResultsState extends ResultsState {}

// GetResults

class GetResultsLoadingState extends ResultsState {}

class GetResultsDoneState extends ResultsState {
  GetResultsDoneState({
    required this.presidentVoteResults,
    required this.mayorVoteResults,
  });

  final VoteResults presidentVoteResults;
  final VoteResults mayorVoteResults;
}

class GetResultsErrorState extends ResultsState {
  GetResultsErrorState({
    required this.message,
  });

  final String message;
}
