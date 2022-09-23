import 'package:flutter/material.dart';
import 'package:healthy_eating/common/cubit/text_cubit.dart';

class DishDescriptionCubit extends TextCubit {

  final controller = TextEditingController();

  DishDescriptionCubit({required String text}) {
    controller.text = text;
  }

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
