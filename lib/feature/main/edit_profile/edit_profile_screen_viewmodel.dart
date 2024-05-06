import 'package:flutter/foundation.dart';
import 'package:kidventory_flutter/core/data/model/update_profile_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service.dart';
import 'package:kidventory_flutter/feature/main/edit_profile/edit_profile_screen_state.dart';

class EditProfileScreenViewModel extends ChangeNotifier {
  final UserApiService _userApiService;

  EditProfileScreenViewModel(this._userApiService);

  EditProfileScreenState _state = EditProfileScreenState();

  EditProfileScreenState get state => _state;

  Future<void> editUser(
    String name,
    String lastName,
    String? imageAddress,
    String? imageFile,
  ) async {
    _update();
    try {
      final _ = await _userApiService.updateProfile(UpdateProfileDto(
        avatarFile: imageFile,
        avatarUrl: imageAddress,
        firstName: name,
        lastName: lastName,
      ));
    } finally {
      _update();
    }
  }

  void _update({String? name, String? lastName, String? imageAddress}) {
    _state = _state.copy(
      name: name,
      lastName: lastName,
      imageAddress: imageAddress,
    );
    notifyListeners();
  }
}
