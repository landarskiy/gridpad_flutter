import 'package:example/components/pad_theme_provider.dart';
import 'package:flutter/material.dart';

class IconPadButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onPressed;

  const IconPadButton(
    this.iconData, {
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return PadButton(
      onPressed: onPressed,
      child: Center(
        child: Icon(
          iconData,
          color: context.theme().colors.content,
        ),
      ),
    );
  }
}

class LargeTextPadButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const LargeTextPadButton(
    this.text, {
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextPadButton(
      text: text,
      style: Theme.of(context).textTheme.displaySmall,
      onPressed: onPressed,
    );
  }
}

class MediumTextPadButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const MediumTextPadButton(
    this.text, {
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextPadButton(
      text: text,
      style: Theme.of(context).textTheme.headlineMedium,
      onPressed: onPressed,
    );
  }
}

class SmallTextPadButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const SmallTextPadButton(
    this.text, {
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextPadButton(
      text: text,
      style: Theme.of(context).textTheme.titleMedium,
      onPressed: onPressed,
    );
  }
}

class TextPadButton extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final VoidCallback? onPressed;

  const TextPadButton({
    super.key,
    required this.text,
    this.style,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return PadButton(
      onPressed: onPressed,
      child: Center(
        child: Text(
          text,
          style: style?.copyWith(color: context.theme().colors.content),
        ),
      ),
    );
  }
}

class PadButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;

  const PadButton({super.key, this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.all(0),
          backgroundColor: context.theme().colors.background,
        ),
        child: child,
      ),
    );
  }
}

class PadButtonColors {
  final Color? content;
  final Color? background;

  const PadButtonColors({
    this.content,
    this.background,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PadButtonColors &&
          runtimeType == other.runtimeType &&
          content == other.content &&
          background == other.background;

  @override
  int get hashCode => content.hashCode ^ background.hashCode;
}

class PadButtonTheme {
  final PadButtonColors colors;

  const PadButtonTheme({this.colors = const PadButtonColors()});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PadButtonTheme &&
          runtimeType == other.runtimeType &&
          colors == other.colors;

  @override
  int get hashCode => colors.hashCode;
}

extension _ThemeExtension on BuildContext {
  PadButtonTheme theme() {
    return PadThemeProvider.of<PadButtonTheme>(this)?.theme ??
        const PadButtonTheme();
  }
}
