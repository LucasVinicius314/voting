import 'package:json_annotation/json_annotation.dart';
import 'package:voting/models/result.dart';
import 'package:voting/utils/parsing.dart';

part 'vote_results.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class VoteResults {
  VoteResults({
    required this.voteCount,
    required this.votesByCandidate,
    required this.votesByParty,
    required this.votesByAge,
    required this.votesByGender,
  });

  @JsonKey(fromJson: Parsing.parseInt)
  int voteCount;
  List<Result>? votesByCandidate;
  List<Result>? votesByParty;
  List<Result>? votesByAge;
  List<Result>? votesByGender;

  factory VoteResults.fromJson(Map<String, dynamic> json) =>
      _$VoteResultsFromJson(json);

  Map<String, dynamic> toJson() => _$VoteResultsToJson(this);
}
