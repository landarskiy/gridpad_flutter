import 'package:example/components/pad_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:grid_pad/grid_pad.dart';

import 'pad_button.dart';

class SimplePriorityCalculatorPad extends StatelessWidget {
  const SimplePriorityCalculatorPad({Key? key}) : super(key: key);

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
            .rowSize(0, const Fixed(48))
            .build(),
        children: [
          _RemoveTheme(child: MediumTextPadButton('C', onPressed: () {})),
          Cell.implicit(
            columnSpan: 2,
            child: _ActionTheme(
              child: MediumTextPadButton('(', onPressed: () {}),
            ),
          ),
          Cell.implicit(
            columnSpan: 2,
            child: _ActionTheme(
              child: MediumTextPadButton(')', onPressed: () {}),
            ),
          ),
          LargeTextPadButton('7', onPressed: () {}),
          LargeTextPadButton('8', onPressed: () {}),
          LargeTextPadButton('9', onPressed: () {}),
          _ActionTheme(child: LargeTextPadButton('×', onPressed: () {})),
          _ActionTheme(child: LargeTextPadButton('÷', onPressed: () {})),
          LargeTextPadButton('4', onPressed: () {}),
          LargeTextPadButton('5', onPressed: () {}),
          LargeTextPadButton('6', onPressed: () {}),
          Cell.implicit(
            rowSpan: 2,
            child: _ActionTheme(
              child: LargeTextPadButton('-', onPressed: () {}),
            ),
          ),
          Cell.implicit(
            rowSpan: 2,
            child: _ActionTheme(
              child: LargeTextPadButton('+', onPressed: () {}),
            ),
          ),
          Cell(
            row: 3,
            column: 0,
            child: LargeTextPadButton('1', onPressed: () {}),
          ),
          LargeTextPadButton('2', onPressed: () {}),
          LargeTextPadButton('3', onPressed: () {}),
          Cell(
            row: 4,
            column: 0,
            child: LargeTextPadButton('0', onPressed: () {}),
          ),
          LargeTextPadButton('.', onPressed: () {}),
          _RemoveTheme(child: IconPadButton(Icons.backspace, onPressed: () {})),
          Cell.implicit(
            columnSpan: 2,
            child: _ActionTheme(
              child: LargeTextPadButton('=', onPressed: () {}),
            ),
          ),
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

  const _ActionTheme({Key? key, required this.child}) : super(key: key);

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

  const _RemoveTheme({Key? key, required this.child}) : super(key: key);

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
