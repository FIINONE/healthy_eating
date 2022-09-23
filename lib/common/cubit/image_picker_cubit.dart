import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerCubit extends Cubit<String> {
  ImagePickerCubit({required String photoPath}) : super(photoPath);
  final _imagePicker = ImagePicker();

  Future<String?> pickImage() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) return null;

    final path = image.path;

    emit(path);
    return path;
  }

  String cleanImage() {
    emit('');

    return '';
  }
}
