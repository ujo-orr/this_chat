// useCase.dart

import 'package:this_chat/entity.dart';
import 'package:this_chat/repository.dart';

class LoginUseCase {
  final LoginRepository _repository;

  LoginUseCase(this._repository);

  Future<LoginEntity?> login(String email, String password) async {
    return await _repository.signIn(email, password);
  }

  Future<void> logout() async {
    await _repository.signOut();
  }
}
