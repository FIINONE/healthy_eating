import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:healthy_eating/blocs/dai_diet_bloc.dart';
import 'package:healthy_eating/blocs/day_diet_bloc_state.dart';
import 'package:healthy_eating/config/app_colors.dart';
import 'package:healthy_eating/data/models/day_diet_model.dart';

class TopPanel extends StatelessWidget {
  const TopPanel({Key? key}) : super(key: key);

  String _switchDay(Days day) {
    switch (day) {
      case Days.monday:
        return 'Понедельник';
      case Days.tuesday:
        return 'Вторник';
      case Days.wednesday:
        return 'Среда';
      case Days.thursday:
        return 'Четверг';
      case Days.friday:
        return 'Пятница';
      case Days.saturday:
        return 'Суббота';
      case Days.sunday:
        return 'Воскресенье';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<DayDietBloc>();
    final state = bloc.state as DayDietBlocData;

    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final width = (screenWidth - 32) / 6;

    return Row(
      children: [
        _DayChanger(
          width: width,
          icon: Icons.arrow_back_ios,
          onTap: () {
            bloc.beforeDay();
          },
        ),
        Expanded(
          child: DropdownButton<String>(
            onChanged: (value) {},
            isExpanded: true,
            icon: const SizedBox.shrink(),
            value: _switchDay(state.data.day),
            dropdownColor: Colors.white,
            itemHeight: width + 10,
            menuMaxHeight: width * 5,
            borderRadius: BorderRadius.circular(10),
            elevation: 1,
            items: Days.values
                .map(
                  (day) => DropdownMenuItem<String>(
                    value: _switchDay(day),
                    onTap: () {
                      bloc.selectDay(day);
                    },
                    child: Container(
                      height: width,
                      decoration: BoxDecoration(
                        color: AppColors.greenLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      alignment: Alignment.center,
                      child: Text(
                        _switchDay(day),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        // Expanded(
        //   child: Container(
        //     height: width,
        //     margin: const EdgeInsets.symmetric(horizontal: 8),
        //     decoration: BoxDecoration(
        //       color: AppColors.greenLight,
        //       borderRadius: BorderRadius.circular(10),
        //     ),
        //     alignment: Alignment.center,
        //     child: Text(
        //       _switchDay(state.data.day),
        //       style: const TextStyle(
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ),
        _DayChanger(
          width: width,
          icon: Icons.arrow_forward_ios,
          onTap: () {
            bloc.nextDay();
          },
        ),
      ],
    );
  }
}

class _DayChanger extends StatelessWidget {
  const _DayChanger({
    Key? key,
    required this.width,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  final double width;
  final void Function() onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Ink(
        width: width,
        height: width,
        decoration: BoxDecoration(
          color: AppColors.brown,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
