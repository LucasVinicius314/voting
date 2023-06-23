import 'package:json_annotation/json_annotation.dart';
import 'package:voting/utils/parsing.dart';

part 'candidate.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class Candidate {
  Candidate({
    required this.id,
    required this.partyId,
    required this.name,
    required this.code,
    required this.role,
  });

  @JsonKey(fromJson: Parsing.parseString, name: '_id')
  String id;
  @JsonKey(fromJson: Parsing.parseString)
  String partyId;
  @JsonKey(fromJson: Parsing.parseString)
  String name;
  @JsonKey(fromJson: Parsing.parseInt)
  int code;
  @JsonKey(fromJson: Parsing.parseString)
  String role;

  String get getCode => code.toStringAsFixed(0).padLeft(3, '0');

  factory Candidate.fromJson(Map<String, dynamic> json) =>
      _$CandidateFromJson(json);

  Map<String, dynamic> toJson() => _$CandidateToJson(this);
}
