import 'package:favoritospix/utils/app_assets.dart';
import 'package:favoritospix/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _controller.forward().whenCompleteOrCancel(() {
      Modular.to.pushReplacementNamed('/welcome/');
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
            child: AppImages.pixLogo(),
          ),
        ],
      ),
    );
  }
}
