import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_eating/data/models/dish_model.dart';

class DishCubit extends Cubit<DishModel> {
  DishCubit() : super(const DishModel(title: '', uuid: ''));

  final titleController = TextEditingController();
  final caloriesController = TextEditingController();
  final descriptionController = TextEditingController();

  void setDish(DishModel model) {
    emit(model);
  }

  void clearText () {
    titleController.clear();
    caloriesController.clear();
    descriptionController.clear();
  }

  @override
  Future<void> close() {
    titleController.dispose();
    caloriesController.dispose();
    descriptionController.dispose();
    
    return super.close();
  }
}
