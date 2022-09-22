class DishModel {
  final String title;
  final String photo;
  final String description;
  final String recipe;

  const DishModel({
    required this.title,
    this.photo = '',
    this.description = '',
    this.recipe = '',
  });

  DishModel copyWith({
    String? uuid,
    String? title,
    String? photo,
    String? description,
    String? recipe,
  }) {
    return DishModel(
      title: title ?? this.title,
      photo: photo ?? this.photo,
      description: description ?? this.description,
      recipe: recipe ?? this.recipe,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'photo': photo,
      'description': description,
      'recipe': recipe,
    };
  }

  factory DishModel.fromMap(Map<String, dynamic> map) {
    return DishModel(
      title: map['title'],
      photo: map['photo'],
      description: map['description'],
      recipe: map['recipe'],
    );
  }

}
