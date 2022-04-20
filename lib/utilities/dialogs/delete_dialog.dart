import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(
  BuildContext context,
) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Xoá ghi chú',
    content: 'Bạn có chắc muốn xoá ghi chú này không?',
    optionBuilder: () => {
      'Huỷ': false,
      'Đồng ý': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
