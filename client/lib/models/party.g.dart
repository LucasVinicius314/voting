// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Party _$PartyFromJson(Map<String, dynamic> json) => Party(
      id: Parsing.parseString(json['_id']),
      name: Parsing.parseString(json['name']),
      acronym: Parsing.parseString(json['acronym']),
      candidates: (json['candidates'] as List<dynamic>?)
          ?.map((e) => Candidate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PartyToJson(Party instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'acronym': instance.acronym,
      'candidates': instance.candidates?.map((e) => e.toJson()).toList(),
    };
