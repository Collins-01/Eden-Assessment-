import 'package:eden_demo/extensions/extensions.dart';
import 'package:eden_demo/presentation/views/home/viewmodels/home_viewmodel.dart';
import 'package:eden_demo/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeAppBarComponent extends ConsumerWidget {
  const HomeAppBarComponent({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final vm = ref.watch(homeViewModelProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // ValueListenableBuilder(
        //     valueListenable: vm.currentUser,
        //     builder: (context, user, _) {
        //       return Row(
        //         children: [
        //           AppNetworkImage(
        //             url: user?.image ?? '',
        //             circle: true,
        //             height: 30,
        //             width: 30,
        //           ),
        //           Gap.w8,
        //           AppText.heading4(
        //             "Hello, ${user?.name.split(" ")[0].capitalizeFirst}",
        //           ),
        //         ],
        //       );
        //     }),
        StreamBuilderWrapper(
          stream: vm.currentUser,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              final user = snapshot.data;
              return Row(
                children: [
                  AppNetworkImage(
                    url: user?.image ?? '',
                    circle: true,
                    height: 30,
                    width: 30,
                  ),
                  Gap.w8,
                  AppText.heading4(
                    "Hello, ${user?.name.split(" ")[0].capitalizeFirst}",
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
        const Spacer(),
        IconButton(
          onPressed: () => vm.logOut(),
          icon: const Icon(
            Icons.logout,
            size: 14,
          ),
        )
      ],
    );
  }
}
