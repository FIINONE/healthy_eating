import 'package:healthy_eating/data/models/day_diet_model.dart';

abstract class DayDietBlocState {}

class DayDietBlocLoading extends DayDietBlocState {}

class DayDietBlocData extends DayDietBlocState {
  final DayDietModel data;

  DayDietBlocData({
    required this.data,
  });
}

extension DayDietBlocStateUnion on DayDietBlocState {
  T map<T>({
    required T Function(DayDietBlocLoading) loading,
    required T Function(DayDietBlocData) data,
  }) {
    if (this is DayDietBlocLoading) return loading(this as DayDietBlocLoading);
    if (this is DayDietBlocData) return data(this as DayDietBlocData);

    throw AssertionError('Union does not match any possible values');
  }
}
