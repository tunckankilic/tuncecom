import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DIYModel {
  final String description;
  final String id;
  final String imageUrl;
  final List<String> steps;
  final String title;
  DIYModel({
    required this.description,
    required this.id,
    required this.imageUrl,
    required this.steps,
    required this.title,
  });

  DIYModel copyWith({
    String? description,
    String? id,
    String? imageUrl,
    List<String>? steps,
    String? title,
  }) {
    return DIYModel(
      description: description ?? this.description,
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      steps: steps ?? this.steps,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'id': id,
      'imageUrl': imageUrl,
      'steps': steps,
      'title': title,
    };
  }

  factory DIYModel.fromMap(Map<String, dynamic> map) {
    return DIYModel(
      description: map['description'] as String,
      id: map['id'] as String,
      imageUrl: map['imageUrl'] as String,
      steps: List<String>.from((map['steps'] as List<String>)),
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DIYModel.fromJson(String source) =>
      DIYModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DIYModel(description: $description, id: $id, imageUrl: $imageUrl, steps: $steps, title: $title)';
  }

  @override
  bool operator ==(covariant DIYModel other) {
    if (identical(this, other)) return true;

    return other.description == description &&
        other.id == id &&
        other.imageUrl == imageUrl &&
        listEquals(other.steps, steps) &&
        other.title == title;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        id.hashCode ^
        imageUrl.hashCode ^
        steps.hashCode ^
        title.hashCode;
  }
}
