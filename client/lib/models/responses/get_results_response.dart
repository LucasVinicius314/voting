import 'package:json_annotation/json_annotation.dart';
import 'package:voting/models/vote_results.dart';

part 'get_results_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class GetResultsResponse {
  GetResultsResponse({
    required this.presidentVoteResults,
    required this.mayorVoteResults,
  });

  final VoteResults? presidentVoteResults;
  final VoteResults? mayorVoteResults;

  factory GetResultsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetResultsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetResultsResponseToJson(this);
}
