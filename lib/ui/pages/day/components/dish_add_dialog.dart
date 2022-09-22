import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:healthy_eating/blocs/dai_diet_bloc.dart';
import 'package:healthy_eating/data/models/dish_model.dart';
import 'package:healthy_eating/ui/pages/day/cubit/dish_cubit.dart';

class DishAddDialog extends StatelessWidget {
  const DishAddDialog({
    Key? key,
    required this.dishCubit,
  }) : super(key: key);

  final DishCubit dishCubit;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(8),
      children: [
        TextField(
          controller: dishCubit.titleController,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        ElevatedButton(
          onPressed: () {
            final bloc = context.read<DayDietBloc>();
            final title = dishCubit.titleController.text;
            final model = DishModel(title: title);

            bloc.setData(model);

            Navigator.pop(context);
          },
          child: const Text('Добавить блюдо'),
        )
      ],
    );
  }
}
