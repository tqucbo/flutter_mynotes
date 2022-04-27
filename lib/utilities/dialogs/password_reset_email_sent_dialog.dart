import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Khôi phục mật khẩu',
    content:
        'Chúng tôi đã gửi liên kết xác thực yêu cầu khôi phục mật khẩu đến thư điện tử của bạn. Vui lòng kiểm tra trong mục \'Hộp thư đến\' hoặc \'Thư rác\'.',
    optionBuilder: () => {
      'Đồng ý': null,
    },
  );
}
