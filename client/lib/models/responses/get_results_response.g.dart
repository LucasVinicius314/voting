// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_results_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetResultsResponse _$GetResultsResponseFromJson(Map<String, dynamic> json) =>
    GetResultsResponse(
      presidentVoteResults: json['presidentVoteResults'] == null
          ? null
          : VoteResults.fromJson(
              json['presidentVoteResults'] as Map<String, dynamic>),
      mayorVoteResults: json['mayorVoteResults'] == null
          ? null
          : VoteResults.fromJson(
              json['mayorVoteResults'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetResultsResponseToJson(GetResultsResponse instance) =>
    <String, dynamic>{
      'presidentVoteResults': instance.presidentVoteResults?.toJson(),
      'mayorVoteResults': instance.mayorVoteResults?.toJson(),
    };
