import 'package:flutter/material.dart';
import 'package:healthy_eating/config/app_colors.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  final String buttonText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.greenDark),
        fixedSize: MaterialStateProperty.all(const Size.fromHeight(50)),
      ),
      child: Text(buttonText),
    );
  }
}
