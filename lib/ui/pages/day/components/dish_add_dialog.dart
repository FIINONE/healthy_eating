import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:healthy_eating/blocs/dai_diet_bloc.dart';
import 'package:healthy_eating/common/cubit/image_picker_cubit.dart';
import 'package:healthy_eating/common/cubit/text_cubit.dart';
import 'package:healthy_eating/config/app_colors.dart';
import 'package:healthy_eating/data/models/dish_model.dart';
import 'package:healthy_eating/ui/pages/day/cubit/dish_cubit.dart';
import 'package:healthy_eating/ui/pages/day/cubit/dish_title_error.dart';
import 'package:healthy_eating/ui/widgets/add_button.dart';
import 'package:healthy_eating/ui/widgets/image_builder.dart';
import 'package:uuid/uuid.dart';

class DishAddDialog extends StatelessWidget {
  const DishAddDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dishCubit = context.read<DishCubit>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ImagePickerCubit(photoPath: '')),
        BlocProvider(create: (_) => DishTitleError()),
      ],
      child: SimpleDialog(
        contentPadding: const EdgeInsets.all(8),
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: ImageBuilder(widthFactor: 4),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: _TitleField(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: TextField(
              controller: dishCubit.descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Введите описание...',
              ),
              cursorColor: AppColors.greenDark,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: TextField(
              controller: dishCubit.caloriesController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Введите калории...',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              cursorColor: AppColors.greenDark,
            ),
          ),
          const _AddButton(),
        ],
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  const _TitleField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dishCubit = context.watch<DishCubit>();
    final textCubit = context.watch<DishTitleError>();

    return TextField(
      controller: dishCubit.titleController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'Введите название...',
        errorText: textCubit.state,
      ),
      cursorColor: AppColors.greenDark,
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dishCubit = context.read<DishCubit>();
    final textCubit = context.read<DishTitleError>();
    final imgaePickerCubit = context.watch<ImagePickerCubit>();

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Center(
        child: AddButton(
            buttonText: 'Добавить блюдо',
            onPressed: () {
              if (dishCubit.titleController.text.isEmpty) {
                textCubit.setText('Название не может быть пустым');
                return;
              }

              final bloc = context.read<DayDietBloc>();
              final title = dishCubit.titleController.text;
              final description = dishCubit.descriptionController.text;
              final calories = dishCubit.caloriesController.text;
              final photo = imgaePickerCubit.state;

              dishCubit.clearText();
              textCubit.clearText();

              const uuid = Uuid();
              final model = DishModel(
                title: title,
                uuid: uuid.v1(),
                description: description,
                calories: calories,
                photo: photo,
              );

              bloc.setData(model);

              Navigator.pop(context);
            }),
      ),
    );
  }
}
