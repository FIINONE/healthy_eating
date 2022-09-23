import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_eating/blocs/dai_diet_bloc.dart';
import 'package:healthy_eating/common/cubit/image_picker_cubit.dart';
import 'package:healthy_eating/ui/pages/day/cubit/dish_cubit.dart';

class ImageBuilder extends StatelessWidget {
  const ImageBuilder({
    Key? key,
    this.widthFactor,
  }) : super(key: key);

  final double? widthFactor;

  @override
  Widget build(BuildContext context) {
    final imgaePickerCubit = context.watch<ImagePickerCubit>();
    final dishCubit = context.read<DishCubit>();

    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final width = (screenWidth - 8) / (widthFactor ?? 2);

    return Center(
      child: GestureDetector(
        onTap: () async {
          final image = await imgaePickerCubit.pickImage();

          if (image == null) return;

          final dishModel = dishCubit.state;
          final model = dishModel.copyWith(photo: image);

          dishCubit.setDish(model);
        },
        child: Container(
          width: width,
          height: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.hardEdge,
          child: Image.file(
            File(imgaePickerCubit.state),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Добавить фото',
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
