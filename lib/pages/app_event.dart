class AppEvent{
  final String title;
  final String id;
  final String description;
  final String data;
  final String userId;
  final bool public;

//<editor-fold desc="Data Methods">
  const AppEvent({
    required this.title,
    required this.id,
    required this.description,
    required this.data,
    required this.userId,
    required this.public,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppEvent &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          id == other.id &&
          description == other.description &&
          data == other.data &&
          userId == other.userId &&
          public == other.public);

  @override
  int get hashCode =>
      title.hashCode ^
      id.hashCode ^
      description.hashCode ^
      data.hashCode ^
      userId.hashCode ^
      public.hashCode;

  @override
  String toString() {
    return 'AppEvent{ title: $title, id: $id, description: $description, data: $data, userId: $userId, public: $public,}';
  }

  AppEvent copyWith({
    String? title,
    String? id,
    String? description,
    String? data,
    String? userId,
    bool? public,
  }) {
    return AppEvent(
      title: title ?? this.title,
      id: id ?? this.id,
      description: description ?? this.description,
      data: data ?? this.data,
      userId: userId ?? this.userId,
      public: public ?? this.public,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'description': description,
      'data': data,
      'userId': userId,
      'public': public,
    };
  }

  factory AppEvent.fromMap(Map<String, dynamic> map) {
    return AppEvent(
      title: map['title'] as String,
      id: map['id'] as String,
      description: map['description'] as String,
      data: map['data'] as String,
      userId: map['userId'] as String,
      public: map['public'] as bool,
    );
  }
  factory AppEvent.fromDS(String id, Map<String, dynamic> map) {
    return AppEvent(
      title: map['title'] as String,
      id: id,
      description: map['description'] as String,
      data: map['data'] as String,
      userId: map['userId'] as String,
      public: map['public'] as bool,
    );
  }

//</editor-fold>
 }