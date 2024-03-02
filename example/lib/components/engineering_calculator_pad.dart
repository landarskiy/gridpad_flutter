import 'package:example/components/pad_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:grid_pad/grid_pad.dart';

import 'pad_button.dart';

class EngineeringCalculatorPad extends StatelessWidget {
  const EngineeringCalculatorPad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padTheme = context.theme();
    return PadThemeProvider(
      theme: PadButtonTheme(
        colors: PadButtonColors(
          content: padTheme.colors.content,
          background: padTheme.colors.background,
        ),
      ),
      child: GridPad(
        gridPadCells: GridPadCellsBuilder(rowCount: 5, columnCount: 5)
            .rowSize(0, 48.fx())
            .build(),
        children: [
          //BG space
          DecoratedBox(
            decoration: BoxDecoration(
              color: padTheme.colors.numBackground,
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Container(),
          ).cell(row: 1, column: 0, rowSpan: 4, columnSpan: 3),
          _FunctionTheme(
            child: SmallTextPadButton('sin', onPressed: () {}),
          ).cell(row: 0, column: 0),
          _FunctionTheme(child: SmallTextPadButton('cos', onPressed: () {})),
          _FunctionTheme(child: SmallTextPadButton('log', onPressed: () {})),
          _FunctionTheme(child: SmallTextPadButton('π', onPressed: () {})),
          _FunctionTheme(child: SmallTextPadButton('√', onPressed: () {})),
          LargeTextPadButton('7', onPressed: () {}),
          LargeTextPadButton('8', onPressed: () {}),
          LargeTextPadButton('9', onPressed: () {}),
          _ActionTheme(child: LargeTextPadButton('(', onPressed: () {})),
          _ActionTheme(child: LargeTextPadButton(')', onPressed: () {})),
          LargeTextPadButton('4', onPressed: () {}),
          LargeTextPadButton('5', onPressed: () {}),
          LargeTextPadButton('6', onPressed: () {}),
          _ActionTheme(child: LargeTextPadButton('×', onPressed: () {})),
          _ActionTheme(child: LargeTextPadButton('÷', onPressed: () {})),
          LargeTextPadButton('1', onPressed: () {}),
          LargeTextPadButton('2', onPressed: () {}),
          LargeTextPadButton('3', onPressed: () {}),
          _ActionTheme(child: LargeTextPadButton('-', onPressed: () {})),
          _ActionTheme(child: LargeTextPadButton('+', onPressed: () {})),
          _RemoveTheme(child: LargeTextPadButton('C', onPressed: () {})),
          LargeTextPadButton('.', onPressed: () {}),
          LargeTextPadButton('0', onPressed: () {}),
          _RemoveTheme(child: IconPadButton(Icons.backspace, onPressed: () {})),
          _ActionTheme(child: LargeTextPadButton('=', onPressed: () {})),
        ],
      ),
    );
  }
}

class EngineeringCalculatorPadColors {
  final Color? content;
  final Color? removeContent;
  final Color? actionsContent;
  final Color? functionsContent;
  final Color? background;
  final Color? numBackground;

  const EngineeringCalculatorPadColors({
    this.content,
    this.removeContent,
    this.actionsContent,
    this.functionsContent,
    this.background,
    this.numBackground,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EngineeringCalculatorPadColors &&
          runtimeType == other.runtimeType &&
          content == other.content &&
          removeContent == other.removeContent &&
          actionsContent == other.actionsContent &&
          functionsContent == other.functionsContent &&
          background == other.background &&
          numBackground == other.numBackground;

  @override
  int get hashCode =>
      content.hashCode ^
      removeContent.hashCode ^
      actionsContent.hashCode ^
      functionsContent.hashCode ^
      background.hashCode ^
      numBackground.hashCode;
}

class EngineeringCalculatorPadTheme {
  final EngineeringCalculatorPadColors colors;

  const EngineeringCalculatorPadTheme({
    this.colors = const EngineeringCalculatorPadColors(),
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EngineeringCalculatorPadTheme &&
          runtimeType == other.runtimeType &&
          colors == other.colors;

  @override
  int get hashCode => colors.hashCode;
}

class _FunctionTheme extends StatelessWidget {
  final Widget child;

  const _FunctionTheme({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padTheme = context.theme();
    return PadThemeProvider(
      theme: PadButtonTheme(
        colors: PadButtonColors(
          content: padTheme.colors.background,
          background: padTheme.colors.functionsContent,
        ),
      ),
      child: child,
    );
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

  const _RemoveTheme({Key? key, required this.child}) : super(key: key);

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

extension _ThemeExtension on BuildContext {
  EngineeringCalculatorPadTheme theme() {
    return PadThemeProvider.of<EngineeringCalculatorPadTheme>(this)?.theme ??
        const EngineeringCalculatorPadTheme();
  }
}
