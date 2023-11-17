import 'package:eden_demo/core/models/models.dart';
import 'package:eden_demo/presentation/views/home/components/components.dart';
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
              const HomeAppBarComponent(),
              Gap.h20,
              AppText.heading5(
                "Order History",
              ),
              Gap.h20,
              Expanded(
                  child: StreamBuilderWrapper(
                stream: vm.ordersStream,
                builder: (context, snapshot) {
                  List<OrderModel> orders = snapshot.data ?? [];
                  return ListView.separated(
                    separatorBuilder: (_, __) => const Divider(
                      height: 2,
                    ),
                    // Show messages from bottom to top
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return OrderComponent(order: order);
                    },
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
