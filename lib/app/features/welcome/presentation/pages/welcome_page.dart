import 'package:auto_size_text/auto_size_text.dart';
import 'package:favoritospix/utils/app_assets.dart';
import 'package:favoritospix/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).viewPadding.vertical,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Spacer(),
                _BodyWidget(),
                Spacer(),
                _ButtonWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ButtonWidget extends StatelessWidget {
  const _ButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Modular.to.pushReplacementNamed('/home/');
      },
      child: Text(
        'Continuar',
        style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        foregroundColor: MaterialStateProperty.all<Color>(AppColors.bgColor),
        overlayColor: MaterialStateProperty.all<Color>(
          AppColors.bgColor.withOpacity(0.1),
        ),
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({
    Key? key,
  }) : super(key: key);

  final textColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppImages.pixLogo(),
        const SizedBox(height: 16),
        AutoSizeText(
          'Bem vindo ao Favoritos Pix',
          style: GoogleFonts.montserrat(fontSize: 26, color: textColor),
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        AutoSizeText(
          'Ferramenta para gerenciamento de lista de favoritos de chaves pix',
          style: GoogleFonts.montserrat(fontSize: 16, color: textColor),
          maxLines: 3,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
