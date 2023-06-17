import 'package:json_annotation/json_annotation.dart';

part 'candidate.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class Candidate {
  Candidate({
    required this.name,
  });

  int? code;
  String? name;

  factory Candidate.fromJson(Map<String, dynamic> json) =>
      _$CandidateFromJson(json);

  Map<String, dynamic> toJson() => _$CandidateToJson(this);
}
