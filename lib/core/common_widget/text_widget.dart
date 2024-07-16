import 'package:eti_chat/core/conifg/localization.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String constText;
  final TextStyle appFonts;
  final Function? function;

  const TextWidget({
    super.key,
    this.function,
    required this.constText,
    required this.appFonts,
  });

  @override
  Widget build(BuildContext context) {
    return function == null
        ? Text(MyLocalizations.of(context).getString(constText),
            style: appFonts)
        : GestureDetector(
            onTap: () => function!(),
            child: Text(MyLocalizations.of(context).getString(constText),
                style: appFonts),
          );
  }
}
