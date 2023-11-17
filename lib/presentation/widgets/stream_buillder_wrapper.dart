import 'package:flutter/material.dart';

class StreamBuilderWrapper<T> extends StatelessWidget {
  final Stream<T> stream;
  final AsyncWidgetBuilder<T> builder;
  final Widget loadingWidget;
  final Widget errorWidget;

  const StreamBuilderWrapper({
    super.key,
    required this.stream,
    required this.builder,
    this.loadingWidget = const CircularProgressIndicator.adaptive(),
    this.errorWidget = const Text(
      "Ann error occurred while trying to perform the operation",
    ),
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return errorWidget;
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget;
        }

        return builder(context, snapshot);
      },
    );
  }
}
