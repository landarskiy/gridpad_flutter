import 'package:example/components/pad_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:grid_pad/grid_pad.dart';

import 'pad_button.dart';

class PinPad extends StatelessWidget {
  final PadActionCallback? callback;

  const PinPad({super.key, this.callback});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme().colors;
    return PadThemeProvider(
      theme: PadButtonTheme(
        colors: PadButtonColors(
          content: colors.content,
          background: colors.background,
        ),
      ),
      child: GridPad(
        gridPadCells: GridPadCells.gridSize(rowCount: 4, columnCount: 3),
        placementPolicy: GridPadPlacementPolicy(
          verticalPolicy: VerticalPolicy.bottomTop,
        ),
        children: [
          LargeTextPadButton(
            '0',
            onPressed: () => callback?.call('0'),
          ).cell(row: 3, column: 1),
          PadThemeProvider(
            theme: PadButtonTheme(
              colors: PadButtonColors(
                content: colors.removeColor,
                background: colors.background,
              ),
            ),
            child: IconPadButton(
              Icons.backspace,
              onPressed: () => callback?.call('r'),
            ),
          ),
          LargeTextPadButton('1', onPressed: () => callback?.call('1')),
          LargeTextPadButton('2', onPressed: () => callback?.call('2')),
          LargeTextPadButton('3', onPressed: () => callback?.call('3')),
          LargeTextPadButton('4', onPressed: () => callback?.call('4')),
          LargeTextPadButton('5', onPressed: () => callback?.call('5')),
          LargeTextPadButton('6', onPressed: () => callback?.call('6')),
          LargeTextPadButton('7', onPressed: () => callback?.call('7')),
          LargeTextPadButton('8', onPressed: () => callback?.call('8')),
          LargeTextPadButton('9', onPressed: () => callback?.call('9')),
        ],
      ),
    );
  }
}

typedef PadActionCallback = void Function(String action);

class PinPadColors {
  final Color? content;
  final Color? removeColor;
  final Color? background;

  const PinPadColors({
    this.content,
    this.removeColor,
    this.background,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PinPadColors &&
          runtimeType == other.runtimeType &&
          content == other.content &&
          removeColor == other.removeColor &&
          background == other.background;

  @override
  int get hashCode =>
      content.hashCode ^ removeColor.hashCode ^ background.hashCode;
}

class PinPadTheme {
  final PinPadColors colors;

  const PinPadTheme({this.colors = const PinPadColors()});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PinPadTheme &&
          runtimeType == other.runtimeType &&
          colors == other.colors;

  @override
  int get hashCode => colors.hashCode;
}

extension _ThemeExtension on BuildContext {
  PinPadTheme theme() {
    return PadThemeProvider.of<PinPadTheme>(this)?.theme ?? const PinPadTheme();
  }
}
