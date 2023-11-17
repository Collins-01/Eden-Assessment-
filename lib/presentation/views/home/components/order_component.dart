// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:eden_demo/presentation/views/views.dart';
import 'package:flutter/material.dart';

import 'package:eden_demo/core/models/models.dart';

import 'package:timeago/timeago.dart' as timeago;
import 'package:eden_demo/presentation/widgets/widgets.dart';

class OrderComponent extends StatelessWidget {
  final OrderModel order;
  const OrderComponent({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => OrderInfoView(id: order.id),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 15,
          top: 15,
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AppNetworkImage(
            height: 50,
            width: 50,
            url: order.items[0].image,
            fit: BoxFit.cover,
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          Gap.w10,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText.heading6(
                "Order #${order.id}",
              ),
              Gap.h6,
              AppText.caption(
                order.items.length == 1
                    ? '${order.items.length} Item'
                    : '${order.items.length} Items',
              ),
              Gap.h6,
            ],
          ),
          const Spacer(),
          AppText.caption(
            timeago.format(order.timestamp),
          ),
        ]),
      ),
    );
  }
}
