import 'package:eden_demo/presentation/widgets/app_button.dart';
import 'package:eden_demo/presentation/widgets/gap.dart';
import 'package:eden_demo/router/router.dart';
import 'package:eden_demo/utils/sizing_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrdersView extends ConsumerStatefulWidget {
  const OrdersView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrdersViewState();
}

class _OrdersViewState extends ConsumerState<OrdersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizingConfig.defaultPadding),
          child: Column(
            children: [
              Gap.h32,
              AppButtonLong(
                title: "Order",
                onClick: () => NavigationService.instance
                    .navigateTo(RoutePaths.orderInfoView),
              )
            ],
          ),
        ),
      ),
    );
  }
}
