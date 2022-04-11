import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xác thực thư điện tử'),
      ),
      body: Column(
        children: [
          const Text('Chúng tôi đã gửi thư xác nhận đến địa chỉ thư điện tử bạn đã nhập.'),
          const Text('Nếu chưa nhận được thư xác nhận, vui lòng nhấn nút dưới đây để gửi lại.'),
          TextButton(
              onPressed: () async {
                await AuthService.firebase().sendEmailVerification();
              },
              child: const Text('Gửi lại thư xác thực')),
              TextButton(onPressed: () async {
                await AuthService.firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
              }, child: const Text('Khởi động lại'))
        ],
      ),
    );
  }
}
