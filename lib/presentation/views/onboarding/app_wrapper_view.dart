import 'package:eden_demo/core/domains/domains.dart';
import 'package:eden_demo/presentation/views/views.dart';
import 'package:eden_demo/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppWrapper extends ConsumerWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final userDomain = ref.watch(userDomainProvider);
    return StreamBuilderWrapper(
      stream: userDomain.currentUserStream,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const AuthView();
        } else {
          return const HomeView();
        }
      },
    );
    // return ValueListenableBuilder(
    //   valueListenable: userDomain.currentUsers,
    //   builder: (context, value, child) {
    //     // print("Current Value from wrapper ::: ${value?.email}");
    //     if (value == null) {
    //       return const AuthView();
    //     } else {
    //       return const HomeView();
    //     }
    //   },
    // );
  }
}
