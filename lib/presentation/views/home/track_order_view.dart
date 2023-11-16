// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:eden_demo/core/data/data.dart';
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
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme.copyWith(
              color: AppColors.darkColor,
            ),
        title: Text(
          "Order $orderId",
          style: TextStyle(
            color: AppColors.darkColor,
          ),
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
              return ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: SizingConfig.defaultPadding,
                ),
                itemCount: statuses.length,
                itemBuilder: (_, index) => TimelineTile(
                  isFirst: index == 0,
                  isLast: index == statuses.length - 1,
                  hasIndicator: true,
                  indicatorStyle: IndicatorStyle(
                    color: Colors.red,
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
                              size: 15,
                              color: AppColors.successColor,
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
              );
            }

            return const SizedBox.shrink();
          }),
    );
  }
}
