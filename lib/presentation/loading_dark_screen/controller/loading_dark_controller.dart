import 'package:get/get.dart';
import '../models/loading_dark_model.dart';

class LoadingDarkController extends GetxController with StateMixin<dynamic> {
  Rx<LoadingDarkModel> loadingDarkModelObj = LoadingDarkModel().obs;

  @override
  void onClose() {
    super.onClose();
  }
}
