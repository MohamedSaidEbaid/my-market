import 'package:flutter/cupertino.dart';

class ModelHud extends ChangeNotifier {
  bool isLoading = false;
  changingIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
