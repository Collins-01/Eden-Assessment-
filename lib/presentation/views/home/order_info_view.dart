// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:eden_demo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:eden_demo/core/data/data.dart';
import 'package:eden_demo/core/models/models.dart';
import 'package:eden_demo/presentation/views/home/track_order_view.dart';

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
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme.copyWith(
              color: AppColors.darkColor,
            ),
        title: Text(
          "Order Info",
          style: TextStyle(
            color: AppColors.darkColor,
          ),
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => TrackOrderView(orderId: id),
                        ),
                      );
                    },
                    child: Text("Track Order"),
                  )
                  // InkWell(
                  //   onTap: () => showModalBottomSheet(
                  //     context: context,
                  //     builder: (context) {
                  //       return ClipRRect(
                  //         clipBehavior: Clip.hardEdge,
                  //         borderRadius: const BorderRadius.only(
                  //           topLeft: Radius.circular(20),
                  //           topRight: Radius.circular(20),
                  //         ),
                  //         child: Container(
                  //           height: 500,
                  //           width: context.getDeviceWidth,
                  //           decoration: const BoxDecoration(
                  //             color: Colors.blue,
                  //             borderRadius: BorderRadius.only(
                  //               topLeft: Radius.circular(20),
                  //               topRight: Radius.circular(20),
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  //   child: Container(
                  //     height:
                  //         context.deviceHeightPercentage(percentage: 17),
                  //     width: context.getDeviceWidth,
                  //     decoration: const BoxDecoration(
                  //       color: Colors.green,
                  //       borderRadius: BorderRadius.all(
                  //         Radius.circular(12),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
