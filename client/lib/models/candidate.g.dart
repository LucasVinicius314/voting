// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Candidate _$CandidateFromJson(Map<String, dynamic> json) => Candidate(
      code: Parsing.parseInt(json['code']),
      name: Parsing.parseString(json['name']),
    );

Map<String, dynamic> _$CandidateToJson(Candidate instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
