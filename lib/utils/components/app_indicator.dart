import 'package:biblio/utils/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppIndicator extends StatelessWidget {
  const AppIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitWave(
        color: kMainColor,
      ),
    );
  }
}
