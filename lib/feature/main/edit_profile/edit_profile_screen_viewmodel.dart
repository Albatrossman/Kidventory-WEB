import 'package:flutter/foundation.dart';
import 'package:kidventory_flutter/feature/main/edit_profile/edit_profile_screen_state.dart';

class EditChildScreenViewModel extends ChangeNotifier {
  EditProfileScreenState _state = EditProfileScreenState();

  EditProfileScreenState get state => _state;

  void _update(
      {String? name,
      String? lastName,
      String? imageAddress}) {
    _state = _state.copy(
      name: name,
      lastName: lastName,
      imageAddress: imageAddress,
    );
    notifyListeners();
  }
}
