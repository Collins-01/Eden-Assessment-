import 'package:eden_demo/core/models/models.dart';
import 'package:eden_demo/extensions/extensions.dart';
import 'package:eden_demo/presentation/views/home/components/order_component.dart';
import 'package:eden_demo/presentation/views/home/viewmodels/home_viewmodel.dart';
import 'package:eden_demo/presentation/widgets/widgets.dart';
import 'package:eden_demo/utils/sizing_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(homeViewModelProvider);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizingConfig.defaultPadding),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap.h20,
              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder(
                      valueListenable: vm.currentUser,
                      builder: (context, user, _) {
                        return Row(
                          children: [
                            AppNetworkImage(
                              url: user?.image ?? '',
                              circle: true,
                              height: 30,
                              width: 30,
                            ),
                            Gap.w8,
                            Text(
                              "Hello, ${user?.name.split(" ")[0].capitalizeFirst}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        );
                      }),
                  const Spacer(),
                  IconButton(
                    onPressed: () => vm.logOut(),
                    icon: const Icon(
                      Icons.logout,
                      size: 14,
                    ),
                  )
                ],
              ),
              // Gap.h20,
              Expanded(
                child: StreamBuilder(
                  stream: vm.ordersStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    List<OrderModel> orders = snapshot.data ?? [];
                    return ListView.builder(
                      // Show messages from bottom to top
                      reverse: true,
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        return OrderComponent(order: order);
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
