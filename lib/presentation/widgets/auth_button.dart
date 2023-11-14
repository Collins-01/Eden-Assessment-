// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:eden_demo/extensions/extensions.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.title,
    required this.callback,
  }) : super(key: key);
  final String title;
  final void Function() callback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: context.getDeviceWidth,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          elevation: 0.0,
        ),
        onPressed: callback,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
