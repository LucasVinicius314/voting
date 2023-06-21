import 'package:json_annotation/json_annotation.dart';
import 'package:voting/utils/parsing.dart';

part 'result.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class Result {
  Result({
    required this.primaryLabel,
    required this.secondaryLabel,
    required this.value,
  });

  @JsonKey(fromJson: Parsing.parseString)
  String primaryLabel;
  @JsonKey(fromJson: Parsing.parseString)
  String secondaryLabel;
  @JsonKey(fromJson: Parsing.parseDouble)
  double value;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
