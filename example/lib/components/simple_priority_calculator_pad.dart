import 'package:example/components/pad_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:grid_pad/grid_pad.dart';

import 'pad_button.dart';

class SimplePriorityCalculatorPad extends StatelessWidget {
  const SimplePriorityCalculatorPad({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme();
    return PadThemeProvider(
      theme: PadButtonTheme(
        colors: PadButtonColors(
          content: theme.colors.content,
          background: theme.colors.background,
        ),
      ),
      child: GridPad(
        gridPadCells: GridPadCellsBuilder(rowCount: 5, columnCount: 5)
            .rowSize(0, 48.fx())
            .build(),
        children: [
          _RemoveTheme(child: MediumTextPadButton('C', onPressed: () {})),
          _ActionTheme(
            child: MediumTextPadButton('(', onPressed: () {}),
          ).implicitCell(columnSpan: 2),
          _ActionTheme(
            child: MediumTextPadButton(')', onPressed: () {}),
          ).implicitCell(columnSpan: 2),
          LargeTextPadButton('7', onPressed: () {}),
          LargeTextPadButton('8', onPressed: () {}),
          LargeTextPadButton('9', onPressed: () {}),
          _ActionTheme(child: LargeTextPadButton('×', onPressed: () {})),
          _ActionTheme(child: LargeTextPadButton('÷', onPressed: () {})),
          LargeTextPadButton('4', onPressed: () {}),
          LargeTextPadButton('5', onPressed: () {}),
          LargeTextPadButton('6', onPressed: () {}),
          _ActionTheme(
            child: LargeTextPadButton('-', onPressed: () {}),
          ).implicitCell(rowSpan: 2),
          _ActionTheme(
            child: LargeTextPadButton('+', onPressed: () {}),
          ).implicitCell(rowSpan: 2),
          LargeTextPadButton('1', onPressed: () {}).cell(row: 3, column: 0),
          LargeTextPadButton('2', onPressed: () {}),
          LargeTextPadButton('3', onPressed: () {}),
          LargeTextPadButton('0', onPressed: () {}).cell(row: 4, column: 0),
          LargeTextPadButton('.', onPressed: () {}),
          _RemoveTheme(child: IconPadButton(Icons.backspace, onPressed: () {})),
          _ActionTheme(
            child: LargeTextPadButton('=', onPressed: () {}),
          ).implicitCell(columnSpan: 2),
        ],
      ),
    );
  }
}

class SimplePriorityCalculatorPadColors {
  final Color? content;
  final Color? background;
  final Color? removeBackground;
  final Color? actionsBackground;

  const SimplePriorityCalculatorPadColors({
    this.content,
    this.background,
    this.removeBackground,
    this.actionsBackground,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SimplePriorityCalculatorPadColors &&
          runtimeType == other.runtimeType &&
          content == other.content &&
          background == other.background &&
          removeBackground == other.removeBackground &&
          actionsBackground == other.actionsBackground;

  @override
  int get hashCode =>
      content.hashCode ^
      background.hashCode ^
      removeBackground.hashCode ^
      actionsBackground.hashCode;
}

class SimplePriorityCalculatorPadTheme {
  final SimplePriorityCalculatorPadColors colors;

  const SimplePriorityCalculatorPadTheme({
    this.colors = const SimplePriorityCalculatorPadColors(),
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SimplePriorityCalculatorPadTheme &&
          runtimeType == other.runtimeType &&
          colors == other.colors;

  @override
  int get hashCode => colors.hashCode;
}

extension _ThemeExtension on BuildContext {
  SimplePriorityCalculatorPadTheme theme() {
    return PadThemeProvider.of<SimplePriorityCalculatorPadTheme>(this)?.theme ??
        const SimplePriorityCalculatorPadTheme();
  }
}

class _ActionTheme extends StatelessWidget {
  final Widget child;

  const _ActionTheme({required this.child});

  @override
  Widget build(BuildContext context) {
    final padTheme = context.theme();
    return PadThemeProvider(
      theme: PadButtonTheme(
        colors: PadButtonColors(
          content: padTheme.colors.content,
          background: padTheme.colors.actionsBackground,
        ),
      ),
      child: child,
    );
  }
}

class _RemoveTheme extends StatelessWidget {
  final Widget child;

  const _RemoveTheme({required this.child});

  @override
  Widget build(BuildContext context) {
    final padTheme = context.theme();
    return PadThemeProvider(
      theme: PadButtonTheme(
        colors: PadButtonColors(
          content: padTheme.colors.content,
          background: padTheme.colors.removeBackground,
        ),
      ),
      child: child,
    );
  }
}
