import 'package:json_annotation/json_annotation.dart';

part 'repo.g.dart';

@JsonSerializable()
class Repo {
  final int id;
  final String name;
  @JsonKey(name: "full_name")
  final String fullName;
  final String description;
  @JsonKey(name: "stargazers_count")
  final int stargazersCount;

  Repo({
    required this.id,
    required this.name,
    required this.fullName,
    required this.description,
    required this.stargazersCount,
  });

  factory Repo.fromJson(Map<String, dynamic> json) => _$RepoFromJson(json);

  Map<String, dynamic> toJson() => _$RepoToJson(this);
}
