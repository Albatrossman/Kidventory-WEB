import 'package:flutter/foundation.dart';
import 'package:kidventory_flutter/feature/main/edit_child/edit_child_screen_state.dart';

class EditChildScreenViewModel extends ChangeNotifier {
  EditChildScreenState _state = EditChildScreenState();

  EditChildScreenState get state => _state;

  void _update(
      {String? name,
      String? lastName,
      DateTime? birthday,
      String? relation,
      String? imageAddress}) {
    _state = _state.copy(
      name: name,
      lastName: lastName,
      birthday: birthday,
      relation: relation,
      imageAddress: imageAddress,
    );
    notifyListeners();
  }
}
