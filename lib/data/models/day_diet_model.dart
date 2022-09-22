import 'package:flutter/foundation.dart';

import 'package:healthy_eating/data/models/dish_model.dart';

class DayDietModel {
  final Days day;
  final List<DishModel> dishList;

  const DayDietModel({
    required this.day,
    this.dishList = const [],
  });

  DayDietModel copyWith({
    Days? day,
    List<DishModel>? dishList,
  }) {
    return DayDietModel(
      day: day ?? this.day,
      dishList: dishList ?? this.dishList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'day': day.name,
      'dish_list': dishList.map((x) => x.toMap()).toList(),
    };
  }

  factory DayDietModel.fromMap(Map<String, dynamic> map) {
    return DayDietModel(
      day: _mapper(map['day']),
      dishList: List<DishModel>.from(map['dish_list']?.map((x) => DishModel.fromMap(x))),
    );
  }

  static Days _mapper(String day) {
    switch (day) {
      case 'monday':
        return Days.monday;
      case 'tuesday':
        return Days.tuesday;
      case 'wednesday':
        return Days.wednesday;
      case 'thursday':
        return Days.thursday;
      case 'friday':
        return Days.friday;
      case 'saturday':
        return Days.saturday;
      default:
        return Days.sunday;
    }
  }
}

enum Days { monday, tuesday, wednesday, thursday, friday, saturday, sunday }
