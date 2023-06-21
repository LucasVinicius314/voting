import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting/blocs/results/results_event.dart';
import 'package:voting/blocs/results/results_state.dart';
import 'package:voting/repositories/results_repository.dart';

class ResultsBloc extends Bloc<ResultsEvent, ResultsState> {
  ResultsBloc({
    required this.resultsRepository,
  }) : super(InitialResultsState()) {
    on<GetResultsEvent>((event, emit) async {
      try {
        emit(GetResultsLoadingState());

        final res = await resultsRepository.getResults();

        if (res.presidentVoteResults != null && res.mayorVoteResults != null) {
          emit(GetResultsDoneState(
            mayorVoteResults: res.mayorVoteResults!,
            presidentVoteResults: res.presidentVoteResults!,
          ));
        } else {
          emit(GetResultsErrorState(message: 'Algo deu errado.'));
        }
      } catch (e) {
        emit(GetResultsErrorState(message: e.toString()));
      }
    });
  }

  final ResultsRepository resultsRepository;
}
