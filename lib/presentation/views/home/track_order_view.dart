// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:eden_demo/core/data/data.dart';
import 'package:eden_demo/core/models/models.dart';
import 'package:eden_demo/presentation/widgets/widgets.dart';
import 'package:eden_demo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TrackOrderView extends ConsumerWidget {
  final String orderId;
  const TrackOrderView({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme.copyWith(
              color: AppColors.darkColor,
            ),
        title: AppText.heading3(
          "Order $orderId",
          color: AppColors.darkColor,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: StreamBuilder(
          stream: ref.watch(orderRepository).watchOrder(orderId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.data != null) {
              final statuses = snapshot.data!.statusList;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizingConfig.defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.caption("Your order arrives in..."),
                        AppText.heading4("29 mins"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizingConfig.defaultPadding,
                      ),
                      itemCount: statuses.length,
                      itemBuilder: (_, index) => SizedBox(
                        height: 100,
                        child: TimelineTile(
                          endChild: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText.heading5(
                                      OrderStatusModel.statusToString(
                                          statuses[index].status),
                                    ),
                                    Gap.h4,
                                    AppText.caption(
                                        orderStatusInformation[index])
                                  ],
                                ),
                                statuses[index].timestamp != null
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor
                                              .withOpacity(.1),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(4),
                                          ),
                                        ),
                                        child: AppText.caption(
                                          "${statuses[index].timestamp!.hour}:${statuses[index].timestamp!.minute}:${statuses[index].timestamp!.second}",
                                          color: AppColors.primaryColor,
                                        ),
                                      )
                                    : const SizedBox.shrink()
                              ],
                            ),
                          ),
                          isFirst: index == 0,
                          isLast: index == statuses.length - 1,
                          hasIndicator: true,
                          indicatorStyle: IndicatorStyle(
                            height: 35,
                            width: 35,
                            indicator: Container(
                              height: 35,
                              alignment: Alignment.center,
                              width: 35,
                              decoration: BoxDecoration(
                                color: AppColors.greyColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: statuses[index].timestamp != null
                                  ? Icon(
                                      Icons.check,
                                      size: 16,
                                      color: AppColors.primaryColor,
                                    )
                                  : Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.darkColor,
                                      ),
                                    ),
                            ),
                          ),
                          afterLineStyle: LineStyle(
                            color: AppColors.greyColor,
                            thickness: 2,
                          ),
                          beforeLineStyle: LineStyle(
                            color: AppColors.greyColor,
                            thickness: 2,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }

            return const SizedBox.shrink();
          }),
    );
  }
}

List<String> orderStatusInformation = [
  "Order has been placed ",
  "Order has been accepted",
  "Order has been assigned to a dispatcher",
  "Your order is on its way",
  "Dispatcher has arrived with your order",
  'You have received your order, enjoy'
];
