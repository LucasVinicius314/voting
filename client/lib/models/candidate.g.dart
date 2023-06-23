// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Candidate _$CandidateFromJson(Map<String, dynamic> json) => Candidate(
      id: Parsing.parseString(json['_id']),
      partyId: Parsing.parseString(json['partyId']),
      name: Parsing.parseString(json['name']),
      code: Parsing.parseInt(json['code']),
      role: Parsing.parseString(json['role']),
    );

Map<String, dynamic> _$CandidateToJson(Candidate instance) => <String, dynamic>{
      '_id': instance.id,
      'partyId': instance.partyId,
      'name': instance.name,
      'code': instance.code,
      'role': instance.role,
    };
