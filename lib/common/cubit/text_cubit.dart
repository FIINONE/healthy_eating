import 'package:flutter_bloc/flutter_bloc.dart';

class TextCubit extends Cubit<String?> {
  TextCubit({String? text}) : super(text);

  void setText(String text) {
    emit(text);
  }

  void clearText() {
    emit(null);
  }
}
