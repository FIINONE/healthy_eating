import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_eating/blocs/day_diet_bloc_state.dart';
import 'package:healthy_eating/data/models/day_diet_model.dart';
import 'package:healthy_eating/data/models/dish_model.dart';
import 'package:healthy_eating/data/providers/day_diet_local_provider.dart';

class DayDietBloc extends Cubit<DayDietBlocState> {
  final DayDietLocalProvider provider = DayDietLocalProvider.instance;

  DayDietBloc() : super(DayDietBlocLoading());

  List<DishModel> dishList = [];
  late Days currentDay = _getDay();

  Future<void> getData() async {
    emit(DayDietBlocLoading());

    final map = await provider.getFromLocalStorage(currentDay.name);

    dishList = map.isNotEmpty ? List<DishModel>.from(map['dish_list']?.map((x) => DishModel.fromMap(x))) : [];

    print('currentDay: $currentDay');
    emit(DayDietBlocData(data: DayDietModel(day: currentDay, dishList: dishList)));
  }

  Future<void> setData(DishModel model) async {
    emit(DayDietBlocLoading());

    dishList.add(model);

    final dayModel = DayDietModel(day: currentDay, dishList: dishList);

    final map = dayModel.toMap();

    await provider.setTOLocalStorage(currentDay.name, map);

    emit(DayDietBlocData(data: dayModel));
  }

  void beforeDay() {
    final index = Days.values.indexOf(currentDay);
    if (index == 0) {
      return;
    }
    currentDay = Days.values[index - 1];
    getData();
  }

  void nextDay() {
    final index = Days.values.indexOf(currentDay);

    if (index == Days.values.length - 1) {
      return;
    }
    currentDay = Days.values[index + 1];
    getData();
  }

  Days _getDay([DateTime? time]) {
    final date = time ?? DateTime.now();
    switch (date.weekday) {
      case 1:
        return Days.monday;
      case 2:
        return Days.tuesday;
      case 3:
        return Days.wednesday;
      case 4:
        return Days.thursday;
      case 5:
        return Days.friday;
      case 6:
        return Days.saturday;
      default:
        return Days.sunday;
    }
  }
}
