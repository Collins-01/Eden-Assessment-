// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:eden_demo/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class LoaderPage extends StatelessWidget {
  final Widget child;
  final bool isBusy;
  const LoaderPage({
    Key? key,
    required this.child,
    this.isBusy = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
          height: context.getDeviceHeight,
          width: context.getDeviceWidth,
          decoration: BoxDecoration(
            color: isBusy ? Colors.black.withOpacity(.3) : null,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(child: child),
              isBusy
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : const SizedBox.shrink(),
            ],
          )),
    );
  }
}
