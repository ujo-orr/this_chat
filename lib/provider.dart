import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'repository.dart';
import 'loginPage/usecase.dart';
import 'loginPage/viewmodel.dart';

// Provider 설정 (전역)
final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  return FirebaseAuthRepository(FirebaseAuth.instance); // FirebaseAuth 주입
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.read(loginRepositoryProvider); // LoginRepository 주입
  return LoginUseCase(repository);
});

// ViewModel Provider 정의
final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginState>((ref) {
  final authUseCase = ref.read(loginUseCaseProvider); // UseCase Provider에서 가져오기
  return LoginViewModel(authUseCase);
});
