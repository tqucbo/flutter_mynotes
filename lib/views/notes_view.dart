import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/enums/menu_action.dart';
import 'package:mynotes/services/auth/auth_service.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Giao diện chính'), actions: [
        PopupMenuButton(onSelected: (value) async {
          switch (value) {
            case MenuAction.logout:
              final shouldLogout = await showLogOutDialog(context);
              if (shouldLogout) {
                await AuthService.firebase().logOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              }
          }
        }, itemBuilder: (context) {
          return const [
            PopupMenuItem<MenuAction>(
              value: MenuAction.logout,
              child: Text('Đăng xuất'),
            ),
          ];
        })
      ]),
      body: const Center(child: Text('Chào mừng bạn')),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Đăng xuất'),
        content:
            const Text('Bạn có chắc chắn thực hiện việc đăng xuất này không?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Huỷ')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Đăng xuất')),
        ],
      );
    },
  ).then((value) => value ?? false);
}
