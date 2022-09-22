import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_eating/data/models/dish_model.dart';

class DishCubit extends Cubit<DishModel> {
  DishCubit() : super(const DishModel(title: ''));

  final titleController = TextEditingController();

  void setDish(DishModel model) {

    emit(model);
  }
}
