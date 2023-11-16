// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:eden_demo/presentation/views/views.dart';
import 'package:flutter/material.dart';

import 'package:eden_demo/core/models/models.dart';
import 'package:eden_demo/extensions/extensions.dart';
import 'package:eden_demo/presentation/widgets/widgets.dart';
import 'package:eden_demo/utils/utils.dart';

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
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        height: 120,
        width: context.getDeviceWidth,
        decoration: BoxDecoration(
          color: AppColors.greyColor.withOpacity(.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Row(children: [
          AppNetworkImage(
            height: 80,
            width: 80,
            url: order.items[0].image,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          Gap.w10,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                order.items[0].name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Gap.h8,
              Text(
                order.price.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Gap.h6,
              Text("QTY: ${order.items.length}"),
              Gap.h6,
              Text(
                "Status : ${OrderStatusModel.getOrderStatusString(order.statusList.last.status)}",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.green,
                    ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
