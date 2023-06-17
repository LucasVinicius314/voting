import 'package:json_annotation/json_annotation.dart';
import 'package:voting/models/candidate.dart';

part 'party.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class Party {
  Party({
    required this.name,
    required this.candidates,
  });

  int? code;
  String? name;
  List<Candidate>? candidates;

  factory Party.fromJson(Map<String, dynamic> json) => _$PartyFromJson(json);

  Map<String, dynamic> toJson() => _$PartyToJson(this);
}
