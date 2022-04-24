import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Chia sẻ',
    content: 'Bạn không thể chia sẻ một ghi chú trống.',
    optionBuilder: () => {
      'Đồng ý': null,
    },
  );
}
