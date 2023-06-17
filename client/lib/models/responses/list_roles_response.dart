import 'package:json_annotation/json_annotation.dart';
import 'package:voting/models/party.dart';

part 'list_roles_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class ListRolesResponse {
  ListRolesResponse({
    required this.president,
    required this.mayor,
  });

  final List<Party>? president;
  final List<Party>? mayor;

  factory ListRolesResponse.fromJson(Map<String, dynamic> json) =>
      _$ListRolesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListRolesResponseToJson(this);
}
