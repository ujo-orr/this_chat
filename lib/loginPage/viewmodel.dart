// viewModel.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:this_chat/loginPage/usecase.dart';

// Login 상태 관리 클래스
class LoginViewModel extends StateNotifier<LoginState> {
  final LoginUseCase _authUseCase;

  LoginViewModel(this._authUseCase) : super(LoginState());

  Future<bool> login(String email, String password) async {
    try {
      await _authUseCase.login(email, password);
      state = state.copyWith(isLoggedIn: true, errorMessage: null);
      return true;
    } catch (e) {
      state = state.copyWith(
          isLoggedIn: false, errorMessage: '로그인 실패: ${e.toString()}');
      return false;
    }
  }
}

// 로그인 상태를 담는 모델
class LoginState {
  final bool isLoggedIn;
  final String? errorMessage;

  LoginState({this.isLoggedIn = false, this.errorMessage});

  LoginState copyWith({bool? isLoggedIn, String? errorMessage}) {
    return LoginState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// ID 텍스트필드
class IdTextFormField extends StatelessWidget {
  const IdTextFormField({
    super.key,
    required this.idController,
  });

  final TextEditingController idController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: idController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: '이메일 입력',
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@.]+$'))
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '이메일을 입력하세요.';
        }
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return '유효한 이메일을 입력하세요.';
        }
        return null;
      },
    );
  }
}

// PW 텍스트 필드
class PwTextFormField extends StatelessWidget {
  const PwTextFormField({
    super.key,
    required this.pwController,
  });

  final TextEditingController pwController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: pwController,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: '비밀번호 입력',
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp(r'^[a-zA-Z0-9~!@#$%^&*()_+]+$'))
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '비밀번호를 입력하세요';
        } else if (!RegExp(
                r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+]).{6,}$')
            .hasMatch(value)) {
          return '유효한 비밀번호를 입력하세요.';
        }
        return null;
      },
    );
  }
}
