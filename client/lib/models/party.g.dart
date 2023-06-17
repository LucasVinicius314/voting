// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Party _$PartyFromJson(Map<String, dynamic> json) => Party(
      name: json['name'] as String?,
      candidates: (json['candidates'] as List<dynamic>?)
          ?.map((e) => Candidate.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..code = json['code'] as int?;

Map<String, dynamic> _$PartyToJson(Party instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'candidates': instance.candidates?.map((e) => e.toJson()).toList(),
    };
