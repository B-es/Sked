import 'package:flutter/material.dart';
import 'package:sked/utils/extensions/build_context_ext.dart';

class PlaceHolder extends StatelessWidget {
  const PlaceHolder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Отдыхай",
          style: context.text.appName,
        ),
        Icon(
          Icons.psychology,
          color: context.text.appName.color,
        ),
      ],
    ));
  }
}
