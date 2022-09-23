import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_eating/blocs/dai_diet_bloc.dart';
import 'package:healthy_eating/common/cubit/image_picker_cubit.dart';
import 'package:healthy_eating/config/app_colors.dart';
import 'package:healthy_eating/data/models/dish_model.dart';
import 'package:healthy_eating/ui/pages/day/cubit/dish_cubit.dart';
import 'package:healthy_eating/ui/pages/dish/cubit/dish_calories_cubit.dart';
import 'package:healthy_eating/ui/pages/dish/cubit/dish_description_cuibt.dart';
import 'package:healthy_eating/ui/widgets/image_builder.dart';

class DishPage extends StatefulWidget {
  const DishPage({Key? key}) : super(key: key);

  @override
  State<DishPage> createState() => _DishPageState();
}

class _DishPageState extends State<DishPage> {
  late DishModel dishModel;

  @override
  void initState() {
    super.initState();

    final dishCubit = context.read<DishCubit>();
    dishModel = dishCubit.state;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dishCubit = context.watch<DishCubit>();
    final dish = dishCubit.state;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ImagePickerCubit(photoPath: dish.photo)),
        BlocProvider(create: (_) => DishDescriptionCubit(text: dish.description)),
        BlocProvider(create: (_) => DishCaloriesCubit(text: dish.calories)),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(dish.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: const [
              ImageBuilder(),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: _KKalWidget(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: _DescriptionWidget(),
              ),
            ],
          ),
        ),
        floatingActionButton: dishModel != dish
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: FloatingActionButton(
                  onPressed: () {
                    final bloc = context.read<DayDietBloc>();
                    setState(() {});
                    final dish = dishCubit.state;
                    dishModel = dish;

                    bloc.setData(dish);
                  },
                  backgroundColor: AppColors.greenDark,
                  child: const Icon(Icons.save),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

class _KKalWidget extends StatefulWidget {
  const _KKalWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_KKalWidget> createState() => _KKalWidgetState();
}

class _KKalWidgetState extends State<_KKalWidget> {
  bool edited = false;

  @override
  Widget build(BuildContext context) {
    final dishCubit = context.read<DishCubit>();
    final dishColories = context.read<DishCaloriesCubit>();

    return Row(
      children: [
        edited
            ? Expanded(
                child: TextField(
                controller: dishColories.controller,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ))
            : Expanded(
                child: Text(
                  '${dishCubit.state.calories} Ккал',
                  style: const TextStyle(color: AppColors.greenDark, fontSize: 20),
                ),
              ),
        IconButton(
            onPressed: () {
              if (edited) {
                final calories = dishColories.controller.text;
                final model = dishCubit.state.copyWith(calories: calories);
                dishCubit.setDish(model);
              }

              setState(() {
                edited = !edited;
              });
            },
            icon: Icon(
              edited ? Icons.check : Icons.edit,
              color: AppColors.greenDark,
            ))
      ],
    );
  }
}

class _DescriptionWidget extends StatefulWidget {
  const _DescriptionWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_DescriptionWidget> createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<_DescriptionWidget> {
  bool edited = false;

  @override
  Widget build(BuildContext context) {
    final dishCubit = context.read<DishCubit>();
    final dishDecsriprion = context.read<DishDescriptionCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
                child: Text(
              'Описание:',
              style: TextStyle(color: AppColors.greenLight),
            )),
            IconButton(
                onPressed: () {
                  if (edited) {
                    final description = dishDecsriprion.controller.text;
                    final model = dishCubit.state.copyWith(description: description);
                    dishCubit.setDish(model);
                  }

                  setState(() {
                    edited = !edited;
                  });
                },
                icon: Icon(
                  edited ? Icons.check : Icons.edit,
                  color: AppColors.greenDark,
                ))
          ],
        ),
        edited
            ? TextField(controller: dishDecsriprion.controller)
            : Text(
                dishCubit.state.description,
                style: const TextStyle(color: AppColors.greenDark),
              ),
      ],
    );
  }
}
