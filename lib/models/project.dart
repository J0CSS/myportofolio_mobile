import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

/// Portfolio project synchronized with the Django REST Framework API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Project {
  const Project({
    required this.title,
    required this.description,
    this.projectTags = const [],
    this.techTags = const [],
    this.projectUrl = '',
    this.projectImageUrl = '',
    this.startedAt,
    this.endedAt,
    this.id,
    this.projectTagNames = const [],
    this.techTagNames = const [],
    this.starCount = 0,
    this.isStarred = false,
    this.starredByNames = '',
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  /// UUID assigned by Django. It is not sent in create/update request bodies.
  @JsonKey(includeToJson: false)
  final String? id;

  final String title;
  final String description;

  /// Django's default ManyRelatedField representation uses tag primary keys.
  final List<int> projectTags;
  final List<int> techTags;

  final String projectUrl;

  @JsonKey(defaultValue: '')
  final String projectImageUrl;

  /// Date values use the API's YYYY-MM-DD representation.
  @JsonKey(includeIfNull: false)
  final String? startedAt;

  @JsonKey(includeIfNull: false)
  final String? endedAt;

  /// Computed serializer fields are returned by the API, but are read-only.
  @JsonKey(includeToJson: false)
  final List<String> projectTagNames;

  @JsonKey(includeToJson: false)
  final List<String> techTagNames;

  @JsonKey(includeToJson: false)
  final int starCount;

  @JsonKey(includeToJson: false)
  final bool isStarred;

  @JsonKey(includeToJson: false)
  final String starredByNames;

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
