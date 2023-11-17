// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:eden_demo/extensions/context_extension.dart';
import 'package:eden_demo/presentation/widgets/widgets.dart';
import 'package:eden_demo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:eden_demo/core/data/data.dart';
import 'package:eden_demo/core/models/models.dart';
import 'package:eden_demo/presentation/views/home/track_order_view.dart';
import 'package:timeline_tile/timeline_tile.dart';

class OrderInfoView extends ConsumerWidget {
  final String id;
  const OrderInfoView({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        iconTheme: Theme.of(context).iconTheme.copyWith(
              color: AppColors.darkColor,
            ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.heading3(
              "Order",
              color: AppColors.darkColor,
            ),
            AppText.caption(
              "#$id",
              color: AppColors.darkColor,
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: StreamBuilder<OrderModel?>(
            stream: ref.watch(orderRepository).watchOrder(id),
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
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap.h20,
                    Container(
                      width: context.getDeviceWidth,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColors.greyColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.body1("Price"),
                          AppText.heading4(
                            "\$${snapshot.data?.totalPrice() ?? "0.00"}",
                          ),
                          Gap.h12,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //1
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppText.caption("Items"),
                                  AppText.body1(
                                    snapshot.data?.items
                                            .fold(0.0,
                                                (sum, item) => sum + item.price)
                                            .toString() ??
                                        "0.00",
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppText.caption("Delivery"),
                                  AppText.body1(
                                    snapshot.data?.deliveryFee.toString() ??
                                        "0.00",
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppText.caption("Packaging"),
                                  AppText.body1(
                                      snapshot.data?.packagingFee.toString() ??
                                          "0.00"),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Gap.h20,
                    //Tracker
                    SizedBox(
                      height: 70,
                      width: context.getDeviceWidth,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.statusList.length,
                        itemBuilder: (context, index) => SizedBox(
                          width: context.getDeviceWidth /
                              (data.statusList.length - 1),
                          child: TimelineTile(
                            endChild: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: AppText.caption(
                                OrderStatusModel.statusToString(
                                  data.statusList[index].status,
                                ),
                              ),
                            ),
                            axis: TimelineAxis.horizontal,
                            isFirst: index == 0,
                            indicatorStyle: IndicatorStyle(
                              color: AppColors.greyColor,
                              height: 30,
                              width: 30,
                              // color:  AppColors.primaryColor,
                              indicator: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      data.statusList[index].timestamp == null
                                          ? AppColors.greyColor
                                          : AppColors.primaryColor,
                                ),
                                child: data.statusList[index].timestamp == null
                                    ? Icon(
                                        Icons.pending,
                                        color: AppColors.darkColor,
                                        // color: Colors.white,
                                        size: 14,
                                      )
                                    : const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                              ),
                            ),
                            isLast: index == data.statusList.length - 1,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => TrackOrderView(orderId: id),
                          ),
                        );
                      },
                      child: AppText.heading5(
                        "Track Order",
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Gap.h20,
                    //Items
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.heading5("Items"),
                        Gap.h10,
                        ...List.generate(
                          data.items.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: Row(
                              children: [
                                AppNetworkImage(
                                  url: data.items[index].image,
                                  height: 60,
                                  width: 60,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                Gap.w14,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText.heading6(
                                      data.items[index].name,
                                    ),
                                    Gap.h4,
                                    AppText.body1(
                                      data.items[index].price.toString(),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
