import 'package:move_on_app/data/services/user/user_service.dart';
import 'package:move_on_app/domain/dtos/register_form_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServiceImpl implements IUserService {
  UserServiceImpl(this._prefs);
  final SharedPreferences _prefs;

  static const storageKey = 'current_user';

  @override
  Future<RegisterFormDTO?> get currentUser async {
    final json = _prefs.getString(storageKey);

    if (json == null) return null;

    final user = RegisterFormDTO.fromJson(json);

    return user;
  }

  @override
  Future<bool> isLogged() async {
    final user = await currentUser;

    return user != null;
  }

  @override
  Future<void> register(RegisterFormDTO form) async {
    await _prefs.setString(storageKey, form.toJson());
  }
}
