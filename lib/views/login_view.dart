import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(context, 'Không tìm thấy tài khoản với thông tin vừa nhập.');
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(
                context, 'Thư điện tử hoặc mật khẩu không đúng.');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Lỗi xác thực không xác định.');
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, 'Thư điện tử không đúng định dạng.');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Đăng nhập'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Để truy cập vào các ghi chú đã lưu, vui lòng đăng nhập vào tài khoản của bạn.'),
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'Thư điện tử'),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(hintText: 'Mật khẩu'),
              ),
              TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  context.read<AuthBloc>().add(
                        AuthEventLogIn(
                          email,
                          password,
                        ),
                      );
                },
                child: const Text('Đăng nhập'),
              ),
              TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          const AuthEventShouldRegister(),
                        );
                  },
                  child: const Text('Chưa có tài khoản? Đăng ký ngay!')),
              TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          const AuthEventForgotPassword()
                        );
                  },
                  child: const Text('Quên mật khẩu')),
            ],
          ),
        ),
      ),
    );
  }
}
