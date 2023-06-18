import 'package:json_annotation/json_annotation.dart';

part 'candidate.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class Candidate {
  Candidate({
    required this.code,
    required this.name,
  });

  int? code;
  String? name;

  String get getCode => (code ?? 0).toStringAsFixed(0).padLeft(3, '0');

  factory Candidate.fromJson(Map<String, dynamic> json) =>
      _$CandidateFromJson(json);

  Map<String, dynamic> toJson() => _$CandidateToJson(this);
}
