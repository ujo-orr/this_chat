import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:this_chat/loginPage/viewmodel.dart';
import 'package:this_chat/provider.dart';

import 'package:this_chat/signupPage/view.dart';
import 'package:this_chat/userlistPage/view.dart';

class LoginPageView extends ConsumerWidget {
  const LoginPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController idController = TextEditingController();
    final TextEditingController pwController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final loginState = ref.watch(loginViewModelProvider); // 로그인상태 구독
    final loginViewModel =
        ref.read(loginViewModelProvider.notifier); // ViewModel 호출

    return Scaffold(
      appBar: AppBar(
        title: Text('로그인'),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IdTextFormField(idController: idController),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PwTextFormField(pwController: pwController),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          // Form이 유효한지 확인
                          if (formKey.currentState?.validate() ?? false) {
                            // 로그인 시도
                            bool loginSuccess = await loginViewModel.login(
                              idController.text,
                              pwController.text,
                            );

                            if (loginSuccess) {
                              // 로그인 성공 시 UserListPage로 이동
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserListPage(),
                                ),
                              );
                            } else {
                              // 로그인 실패 시 오류 메시지 출력
                              WidgetsBinding.instance.addPostFrameCallback(
                                (timeStamp) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('로그인 실패'),
                                        content:
                                            Text('${loginState.errorMessage}'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('확인'))
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            }
                          }
                        },
                        child: Text('로그인')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupView(),
                              ));
                        },
                        child: Text('회원가입')),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        ElevatedButton(onPressed: () {}, child: Text('아이디 찾기')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {}, child: Text('비밀번호 찾기')),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
