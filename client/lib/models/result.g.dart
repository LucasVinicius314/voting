// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      primaryLabel: Parsing.parseString(json['primaryLabel']),
      secondaryLabel: Parsing.parseString(json['secondaryLabel']),
      value: Parsing.parseDouble(json['value']),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'primaryLabel': instance.primaryLabel,
      'secondaryLabel': instance.secondaryLabel,
      'value': instance.value,
    };
