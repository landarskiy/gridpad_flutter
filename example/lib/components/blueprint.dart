import 'package:flutter/material.dart';

import '../theme.dart';

class BlueprintBox extends StatelessWidget {
  const BlueprintBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox.expand(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: andreaBlue,
            shape: BoxShape.rectangle,
            border: Border.all(
              color: white,
              style: BorderStyle.solid,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}

class ContentBlueprintBox extends StatelessWidget {
  final String text;

  const ContentBlueprintBox({super.key, this.text = ''});

  @override
  Widget build(BuildContext context) {
    final textStyle =
        Theme.of(context).textTheme.bodyMedium?.copyWith(color: andreaBlue);
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox.expand(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: white,
            shape: BoxShape.rectangle,
            border: Border.all(
              color: heatWave,
              style: BorderStyle.solid,
              width: 3,
            ),
          ),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
          ),
        ),
      ),
    );
  }
}
