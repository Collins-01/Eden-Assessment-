import 'package:eden_demo/extensions/extensions.dart';
import 'package:eden_demo/utils/utils.dart';
import 'package:flutter/material.dart';

class AppButtonLong extends StatelessWidget {
  final void Function()? onClick;
  final String title;

  const AppButtonLong({
    Key? key,
    this.onClick,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 57,
      width: context.getDeviceWidth,
      child: ElevatedButton(
          onPressed: onClick,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
          ),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.white),
          )),
    );
  }
}
