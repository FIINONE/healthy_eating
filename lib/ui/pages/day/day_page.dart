import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_eating/blocs/dai_diet_bloc.dart';
import 'package:healthy_eating/blocs/day_diet_bloc_state.dart';
import 'package:healthy_eating/ui/pages/day/components/dish_add_dialog.dart';
import 'package:healthy_eating/ui/pages/day/components/dish_list.dart';
import 'package:healthy_eating/ui/pages/day/components/top_panel.dart';
import 'package:healthy_eating/ui/pages/day/cubit/dish_cubit.dart';
import 'package:healthy_eating/ui/widgets/add_button.dart';

class DayPage extends StatefulWidget {
  const DayPage({Key? key}) : super(key: key);

  @override
  State<DayPage> createState() => _DayPageState();
}

class _DayPageState extends State<DayPage> {
  @override
  void initState() {
    super.initState();

    final bloc = context.read<DayDietBloc>();
    bloc.getData();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DishCubit()),
      ],
      child: BlocBuilder<DayDietBloc, DayDietBlocState>(
        builder: (context, state) {
          return state.map(
              loading: (loading) => const Center(
                    child: CircularProgressIndicator(),
                  ),
              data: (data) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const TopPanel(),
                      DishList(dishList: data.data.dishList),
                      AddButton(
                        buttonText: 'Добавить новое блюдо',
                        onPressed: () {
                          final dishCubit = context.read<DishCubit>();
                          showDialog(
                            context: context,
                            useRootNavigator: false,
                            builder: (context) {
                              return DishAddDialog(dishCubit: dishCubit);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
