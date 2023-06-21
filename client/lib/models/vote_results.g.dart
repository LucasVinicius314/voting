// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoteResults _$VoteResultsFromJson(Map<String, dynamic> json) => VoteResults(
      voteCount: Parsing.parseInt(json['voteCount']),
      votesByCandidate: (json['votesByCandidate'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
      votesByParty: (json['votesByParty'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
      votesByAge: (json['votesByAge'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
      votesByGender: (json['votesByGender'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VoteResultsToJson(VoteResults instance) =>
    <String, dynamic>{
      'voteCount': instance.voteCount,
      'votesByCandidate':
          instance.votesByCandidate?.map((e) => e.toJson()).toList(),
      'votesByParty': instance.votesByParty?.map((e) => e.toJson()).toList(),
      'votesByAge': instance.votesByAge?.map((e) => e.toJson()).toList(),
      'votesByGender': instance.votesByGender?.map((e) => e.toJson()).toList(),
    };
