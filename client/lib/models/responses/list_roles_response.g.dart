// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_roles_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListRolesResponse _$ListRolesResponseFromJson(Map<String, dynamic> json) =>
    ListRolesResponse(
      president: (json['president'] as List<dynamic>?)
          ?.map((e) => Party.fromJson(e as Map<String, dynamic>))
          .toList(),
      mayor: (json['mayor'] as List<dynamic>?)
          ?.map((e) => Party.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListRolesResponseToJson(ListRolesResponse instance) =>
    <String, dynamic>{
      'president': instance.president?.map((e) => e.toJson()).toList(),
      'mayor': instance.mayor?.map((e) => e.toJson()).toList(),
    };
