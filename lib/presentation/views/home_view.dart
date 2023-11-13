import 'package:eden_demo/presentation/widgets/widgets.dart';
import 'package:eden_demo/utils/app_colors.dart';
import 'package:eden_demo/utils/sizing_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizingConfig.defaultPadding),
        child: SafeArea(
          child: Column(
            children: [
              Gap.h20,
              //
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Gap.w8,
                  Text(
                    "Hello, Collins",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Logout",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
