import 'package:json_annotation/json_annotation.dart';
part 'Expert.g.dart';

@JsonSerializable()
class Experts {
  Experts(
    this.name,
    this.sex,
    this.phone,
    this.email,
    this.password,
    this.age,
    this.averageRating,
    this.availability,
    this.status,
    this.totalTips,
    this.totalCommission,
    this.lastLocation,
    this.expertId,
  );
  final String? name;
  final String? sex;
  final int? phone;
  final String? email;
  final String? password;
  final int? age;
  final double? averageRating;
  final bool? availability;
  @JsonKey(name: 'last_location')
  final LastLocation? lastLocation;
  final String? status;
  final double? totalTips;
  final double? totalCommission;
  final int? expertId;

  factory Experts.fromJson(Map<String, dynamic> json) =>
      _$ExpertsFromJson(json);

  Map<String, dynamic> toJson() => _$ExpertsToJson(this);
}

@JsonSerializable()
class LastLocation {
  final String? latitude;
  final String? longitude;

  LastLocation(this.latitude, this.longitude);

  factory LastLocation.fromJson(Map<String, dynamic> json) =>
      _$LastLocationFromJson(json);

  Map<String, dynamic> toJson() => _$LastLocationToJson(this);
}
