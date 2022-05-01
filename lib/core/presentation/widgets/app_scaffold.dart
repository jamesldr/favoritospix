import 'package:flutter/material.dart';

import 'package:favoritospix/utils/app_colors.dart';

class AppScaffoldBody extends StatelessWidget {
  const AppScaffoldBody({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RawScrollbar(
        thumbColor: AppColors.bgColor.withOpacity(0.5),
        radius: const Radius.circular(12),
        child: child,
      ),
    );
  }
}
