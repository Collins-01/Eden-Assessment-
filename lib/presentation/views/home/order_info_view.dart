// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:eden_demo/extensions/extensions.dart';
import 'package:eden_demo/presentation/widgets/widgets.dart';
import 'package:eden_demo/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:eden_demo/core/models/models.dart';

class OrderInfoView extends ConsumerStatefulWidget {
  final OrderModel orderModel;
  const OrderInfoView({
    super.key,
    required this.orderModel,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderInfoViewState();
}

class _OrderInfoViewState extends ConsumerState<OrderInfoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: context.deviceHeightPercentage(percentage: 8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => NavigationService.instance.goBack(),
                  icon: const Icon(Icons.arrow_back),
                ),
                Gap.w20,
                Text(
                  "Order Details",
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [],
              ),
            ),
          )
        ],
      ),
    );
  }
}
