import 'package:flutter/material.dart';
import 'package:healthy_eating/data/models/dish_model.dart';

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
            ? ListView.builder(
                itemCount: dishList.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final dish = dishList[index];

                  return ListTile(
                    title: Text(dish.title),
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
