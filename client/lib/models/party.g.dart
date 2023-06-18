// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Party _$PartyFromJson(Map<String, dynamic> json) => Party(
      acronym: json['acronym'] as String?,
      name: json['name'] as String?,
      candidates: (json['candidates'] as List<dynamic>?)
          ?.map((e) => Candidate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PartyToJson(Party instance) => <String, dynamic>{
      'acronym': instance.acronym,
      'name': instance.name,
      'candidates': instance.candidates?.map((e) => e.toJson()).toList(),
    };
