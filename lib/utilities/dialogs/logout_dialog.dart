import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(
  BuildContext context,
) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Đăng xuất',
    content: 'Bạn có chắc muốn đăng xuất không?',
    optionBuilder: () => {
      'Huỷ': false,
      'Đồng ý': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
