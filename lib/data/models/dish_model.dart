class DishModel {
  final String title;
  final String photo;
  final String uuid;
  final String description;
  final String calories;

  const DishModel({
    required this.title,
    this.photo = '',
    required this.uuid,
    this.description = '',
    this.calories = '',
  });

  DishModel copyWith({
    String? title,
    String? photo,
    String? uuid,
    String? description,
    String? calories,
  }) {
    return DishModel(
      title: title ?? this.title,
      photo: photo ?? this.photo,
      uuid: uuid ?? this.uuid,
      description: description ?? this.description,
      calories: calories ?? this.calories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'photo': photo,
      'uuid': uuid,
      'description': description,
      'calories': calories,
    };
  }

  factory DishModel.fromMap(Map<String, dynamic> map) {
    return DishModel(
      title: map['title'],
      photo: map['photo'],
      uuid: map['uuid'],
      description: map['description'],
      calories: map['calories'],
    );
  }
}
