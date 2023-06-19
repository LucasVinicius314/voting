import 'package:voting/models/candidate.dart';
import 'package:voting/models/party.dart';
import 'package:voting/utils/enums.dart';

class VoteEvent {}

class SubmitVoteEvent extends VoteEvent {
  SubmitVoteEvent({
    required this.president,
    required this.presidentParty,
    required this.mayor,
    required this.mayorParty,
    required this.cpf,
    required this.gender,
    required this.birthDate,
    required this.latitude,
    required this.longitude,
  });

  final Candidate president;
  final Party presidentParty;
  final Candidate mayor;
  final Party mayorParty;
  final String cpf;
  final Gender gender;
  final DateTime birthDate;
  final double latitude;
  final double longitude;
}
