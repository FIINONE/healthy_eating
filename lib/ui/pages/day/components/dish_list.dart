import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_eating/blocs/dai_diet_bloc.dart';
import 'package:healthy_eating/data/models/dish_model.dart';
import 'package:healthy_eating/ui/pages/day/cubit/dish_cubit.dart';
import 'package:healthy_eating/ui/pages/dish/dish_page.dart';

class DishList extends StatelessWidget {
  const DishList({
    Key? key,
    required this.dishList,
  }) : super(key: key);

  final List<DishModel> dishList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: dishList.isNotEmpty
            ? ListView.separated(
                itemCount: dishList.length,
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final dish = dishList[index];
                  return ListTile(
                    onTap: () {
                      final dishCubit = context.read<DishCubit>();
                      dishCubit.setDish(dish);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider.value(value: dishCubit, child: const DishPage())));
                    },
                    title: Text(dish.title),
                    minLeadingWidth: 30,
                    leading: SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.file(
                        File(dish.photo),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'фото',
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    trailing: InkWell(
                        onTap: () {
                          final bloc = context.read<DayDietBloc>();

                          bloc.deleteData(dish);
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Ink(
                          width: 40,
                          height: 40,
                          child: const Icon(Icons.delete),
                        )),
                  );
                },
              )
            : const Center(
                child: Text('Добавьте свое первое блюдо'),
              ),
      ),
    );
  }
}
