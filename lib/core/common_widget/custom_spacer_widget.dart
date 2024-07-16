import 'package:flutter/cupertino.dart';

class CustomSpacerWidget extends StatelessWidget {
  final double height, width;

  const CustomSpacerWidget({
    super.key,
    this.height = 0,
    this.width = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
