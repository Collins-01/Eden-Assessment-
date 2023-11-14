// ignore_for_file: public_member_api_docs, sort_constructors_first
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
        children: [],
      ),
    );
  }
}
