// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Expert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Experts _$ExpertsFromJson(Map<String, dynamic> json) => Experts(
      json['name'] as String?,
      json['sex'] as String?,
      json['phone'] as int?,
      json['email'] as String?,
      json['password'] as String?,
      json['age'] as int?,
      (json['averageRating'] as num?)?.toDouble(),
      json['availability'] as bool?,
      json['status'] as String?,
      (json['totalTips'] as num?)?.toDouble(),
      (json['totalCommission'] as num?)?.toDouble(),
      json['last_location'] == null
          ? null
          : LastLocation.fromJson(
              json['last_location'] as Map<String, dynamic>),
      json['expertId'] as int?,
    );

Map<String, dynamic> _$ExpertsToJson(Experts instance) => <String, dynamic>{
      'name': instance.name,
      'sex': instance.sex,
      'phone': instance.phone,
      'email': instance.email,
      'password': instance.password,
      'age': instance.age,
      'averageRating': instance.averageRating,
      'availability': instance.availability,
      'last_location': instance.lastLocation,
      'status': instance.status,
      'totalTips': instance.totalTips,
      'totalCommission': instance.totalCommission,
      'expertId': instance.expertId,
    };

LastLocation _$LastLocationFromJson(Map<String, dynamic> json) => LastLocation(
      json['latitude'] as String?,
      json['longitude'] as String?,
    );

Map<String, dynamic> _$LastLocationToJson(LastLocation instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
