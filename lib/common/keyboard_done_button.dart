import 'package:flutter/material.dart';

import '../Values/app_colors.dart';

class CustomKeyBoardDoneButton extends StatelessWidget
    implements PreferredSizeWidget {
  CustomKeyBoardDoneButton({Key? key,  this.onTapDone})
      : super(key: key);
  final GestureTapCallback? onTapDone;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onTapDone,
        child: const Text(
          'Done',
          style: TextStyle(color: AppColor.black, fontSize: 16),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
