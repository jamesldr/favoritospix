import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class AppAssets {
  static const pixLogo = "assets/images/pix_logo.svg";
}

class AppImages {
  static Image pixLogo([Size? size]) => Image(
        width: size?.width ?? 100,
        height: size?.height ?? 100,
        image: const Svg(AppAssets.pixLogo),
      );
}
