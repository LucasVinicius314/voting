// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Candidate _$CandidateFromJson(Map<String, dynamic> json) => Candidate(
      name: json['name'] as String?,
    )..code = json['code'] as int?;

Map<String, dynamic> _$CandidateToJson(Candidate instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };
