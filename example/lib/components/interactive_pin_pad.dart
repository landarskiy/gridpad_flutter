import 'package:flutter/material.dart';

import 'pin_pad.dart';

class InteractivePinPad extends StatefulWidget {
  const InteractivePinPad({super.key});

  @override
  State<InteractivePinPad> createState() => _InteractivePinPadState();
}

class _InteractivePinPadState extends State<InteractivePinPad> {
  String _digits = "";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(8.0))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _digits,
              textAlign: TextAlign.center,
              style: theme.textTheme.displayMedium,
            ),
          ),
        ),
        const SizedBox(height: 16),
        AspectRatio(
          aspectRatio: 1.2,
          child: PinPad(
            callback: (action) {
              if (action == 'r') {
                if (_digits.isNotEmpty) {
                  _onDigitsChanged(_digits.substring(0, _digits.length - 1));
                }
              } else {
                if (_digits.length < 6) {
                  _onDigitsChanged(_digits + action);
                }
              }
            },
          ),
        )
      ],
    );
  }

  _onDigitsChanged(String newDigits) {
    setState(() {
      _digits = newDigits;
    });
  }
}
