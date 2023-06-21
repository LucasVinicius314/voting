import 'package:json_annotation/json_annotation.dart';
import 'package:voting/models/candidate.dart';
import 'package:voting/utils/parsing.dart';

part 'party.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class Party {
  Party({
    required this.acronym,
    required this.name,
    required this.candidates,
  });

  @JsonKey(fromJson: Parsing.parseString)
  String acronym;
  @JsonKey(fromJson: Parsing.parseString)
  String name;
  List<Candidate>? candidates;

  factory Party.fromJson(Map<String, dynamic> json) => _$PartyFromJson(json);

  Map<String, dynamic> toJson() => _$PartyToJson(this);
}
