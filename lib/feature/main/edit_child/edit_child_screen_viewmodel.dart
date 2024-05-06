import 'package:flutter/foundation.dart';
import 'package:kidventory_flutter/core/data/model/child_dto.dart';
import 'package:kidventory_flutter/core/data/service/http/user_api_service.dart';
import 'package:kidventory_flutter/feature/main/edit_child/edit_child_screen_state.dart';

class EditChildScreenViewModel extends ChangeNotifier {
  final UserApiService _userApiService;

  EditChildScreenViewModel(this._userApiService);

  EditChildScreenState _state = EditChildScreenState();

  EditChildScreenState get state => _state;

  Future<void> createChild(
    String name,
    String lastName,
    DateTime birthday,
    String? relation,
    String? imageAddress,
    String? imageFile,
  ) async {
    _update();
    try {
      final _ = await _userApiService.addChild(
        ChildDto(
          id: "",
          parentId: "",
          avatarFile: imageFile,
          avatarUrl: imageAddress,
          firstName: name,
          lastName: lastName,
          relation: relation ?? "None",
          birthday: birthday,
          age: 0,
          address: "",
        ),
      );
    } catch (e) {
      print(e);
    } finally {
      _update();
    }
  }

  Future<void> editChild(
    String id,
    String name,
    String lastName,
    DateTime birthday,
    String? relation,
    String? imageAddress,
    String? imageFile,
  ) async {
    _update();
    try {
      final _ = await _userApiService.updateChild(
        id,
        ChildDto(
          id: "",
          parentId: "",
          avatarFile: imageFile,
          avatarUrl: imageAddress,
          firstName: name,
          lastName: lastName,
          relation: relation ?? "None",
          birthday: birthday,
          age: 0,
          address: "",
        ),
      );
    } finally {
      _update();
    }
  }

  Future<void> deleteChild(
    String id,
  ) async {
    _update();
    try {
      final _ = await _userApiService.deleteChild(
        id,
      );
    } finally {
      _update();
    }
  }

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
