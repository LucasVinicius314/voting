import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voting/blocs/vote/vote_event.dart';
import 'package:voting/blocs/vote/vote_state.dart';

class VoteBloc extends Bloc<VoteEvent, VoteState> {
  VoteBloc() : super(InitialVoteState()) {
    on<SubmitVoteEvent>((event, emit) async {
      // TODO: fix
      // emit(NotificationState(
      //   title: event.title,
      //   body: event.body,
      // ));
    });
  }
}
