import 'package:json_annotation/json_annotation.dart';
import 'package:voting/models/candidate.dart';
import 'package:voting/utils/parsing.dart';

part 'party.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class Party {
  Party({
    required this.id,
    required this.name,
    required this.acronym,
    required this.candidates,
  });

  @JsonKey(fromJson: Parsing.parseString, name: '_id')
  String id;
  @JsonKey(fromJson: Parsing.parseString)
  String name;
  @JsonKey(fromJson: Parsing.parseString)
  String acronym;
  List<Candidate>? candidates;

  factory Party.fromJson(Map<String, dynamic> json) => _$PartyFromJson(json);

  Map<String, dynamic> toJson() => _$PartyToJson(this);
}
