// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:eden_demo/core/data/data.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => NavigationService.instance.goBack(),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Gap.w20,
                    Text(
                      "Order Details",
                      style: Theme.of(context).textTheme.headlineSmall,
                    )
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<OrderModel?>(
                  stream: ref
                      .watch(orderRepository)
                      .watchOrder(widget.orderModel.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    final data = snapshot.data;
                    if (data == null) {
                      return Text(
                        "Order not found",
                        style: Theme.of(context).textTheme.bodyMedium,
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ClipRRect(
                                clipBehavior: Clip.hardEdge,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                child: Container(
                                  height: 500,
                                  width: context.getDeviceWidth,
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          child: Container(
                            height:
                                context.deviceHeightPercentage(percentage: 17),
                            width: context.getDeviceWidth,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
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
