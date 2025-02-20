import 'package:move_on_app/domain/dtos/register_form_dto.dart';

abstract interface class IUserService {
  Future<void> register(RegisterFormDTO form);
  Future<bool> isLogged();
  Future<RegisterFormDTO?> get currentUser;
}
