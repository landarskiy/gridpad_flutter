import 'package:example/components/pad_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:grid_pad/grid_pad.dart';

import 'pad_button.dart';

class SimpleCalculatorPad extends StatelessWidget {
  const SimpleCalculatorPad({super.key});

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
        gridPadCells: GridPadCellsBuilder(rowCount: 5, columnCount: 4).build(),
        children: [
          _RemoveTheme(child: LargeTextPadButton('C', onPressed: () {})),
          _ActionTheme(child: LargeTextPadButton('÷', onPressed: () {})),
          _ActionTheme(child: LargeTextPadButton('×', onPressed: () {})),
          _RemoveTheme(child: IconPadButton(Icons.backspace, onPressed: () {})),
          LargeTextPadButton('7', onPressed: () {}),
          LargeTextPadButton('8', onPressed: () {}),
          LargeTextPadButton('9', onPressed: () {}),
          _ActionTheme(child: LargeTextPadButton('-', onPressed: () {})),
          LargeTextPadButton('4', onPressed: () {}),
          LargeTextPadButton('5', onPressed: () {}),
          LargeTextPadButton('6', onPressed: () {}),
          _ActionTheme(child: LargeTextPadButton('+', onPressed: () {})),
          LargeTextPadButton('1', onPressed: () {}),
          LargeTextPadButton('2', onPressed: () {}),
          LargeTextPadButton('3', onPressed: () {}),
          _ActionTheme(
            child: LargeTextPadButton('=', onPressed: () {}),
          ).implicitCell(rowSpan: 2),
          LargeTextPadButton('.', onPressed: () {}).cell(row: 4, column: 0),
          LargeTextPadButton('0', onPressed: () {}).implicitCell(columnSpan: 2),
        ],
      ),
    );
  }
}

class SimpleCalculatorPadColors {
  final Color? content;
  final Color? removeContent;
  final Color? actionsContent;
  final Color? background;

  const SimpleCalculatorPadColors({
    this.content,
    this.removeContent,
    this.actionsContent,
    this.background,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SimpleCalculatorPadColors &&
          runtimeType == other.runtimeType &&
          content == other.content &&
          removeContent == other.removeContent &&
          actionsContent == other.actionsContent &&
          background == other.background;

  @override
  int get hashCode =>
      content.hashCode ^
      removeContent.hashCode ^
      actionsContent.hashCode ^
      background.hashCode;
}

class SimpleCalculatorPadTheme {
  final SimpleCalculatorPadColors colors;

  const SimpleCalculatorPadTheme({
    this.colors = const SimpleCalculatorPadColors(),
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SimpleCalculatorPadTheme &&
          runtimeType == other.runtimeType &&
          colors == other.colors;

  @override
  int get hashCode => colors.hashCode;
}

extension _ThemeExtension on BuildContext {
  SimpleCalculatorPadTheme theme() {
    return PadThemeProvider.of<SimpleCalculatorPadTheme>(this)?.theme ??
        const SimpleCalculatorPadTheme();
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
          content: padTheme.colors.actionsContent,
          background: padTheme.colors.background,
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
          content: padTheme.colors.removeContent,
          background: padTheme.colors.background,
        ),
      ),
      child: child,
    );
  }
}
