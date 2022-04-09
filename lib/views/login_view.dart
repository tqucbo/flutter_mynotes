import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng nhập'),
      ),
      body: Column(
        children: [
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
              try {
                final userCredential =
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                Navigator.of(context).pushNamedAndRemoveUntil(
                  notesRoute,
                  (route) => false,
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  await showErrorDialog(
                      context, 'Không tìm thấy tài khoản này.');
                } else if (e.code == 'wrong-password') {
                  await showErrorDialog(
                      context, 'Thư điện tử hoặc mật khẩu không đúng.');
                } else if (e.code == 'invalid-email') {
                  await showErrorDialog(
                      context, 'Thư điện tử không đúng định dạng.');
                } else {
                  await showErrorDialog(context,
                      'Lỗi này sẽ được sửa trong bản cập nhật tới: ${e.code}');
                }
              } catch (e) {
                await showErrorDialog(context,
                    'Lỗi này sẽ được sửa trong bản cập nhật tới: ${e.toString()}');
              }
            },
            child: const Text('Đăng nhập'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: const Text('Chưa có tài khoản? Đăng ký ngay!')),
        ],
      ),
    );
  }
}
