import 'package:example/components/blueprint.dart';
import 'package:example/components/pad_theme_provider.dart';
import 'package:example/components/pin_pad.dart';
import 'package:example/theme.dart';
import 'package:flutter/material.dart';
import 'package:grid_pad/grid_pad.dart';
import 'package:grid_pad/grid_pad_diagnostic.dart';

import 'components/engineering_calculator_pad.dart';
import 'components/interactive_pin_pad.dart';
import 'components/simple_calculator_pad.dart';
import 'components/simple_priority_calculator_pad.dart';

void main() {
  _initDiagnostic();
  runApp(const MyApp());
}

_initDiagnostic() {
  GridPadDiagnosticLogger().skippingItemCallback = (String message) {
    debugPrint(message);
  };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GridPad Demo',
      theme: darkThemeData,
      darkTheme: darkThemeData,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GridPad'),
      ),
      body: const ListOfPads(),
    );
  }
}

class ListOfPads extends StatelessWidget {
  const ListOfPads({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: const [
      InteractivePinPadCard(),
      EngineeringCalculatorPadCard(),
      SimplePriorityCalculatorPadCard(),
      SimpleCalculatorPadCard(),
      SimpleBlueprintCard(),
      CustomSizeBlueprintCard(),
      SimpleBlueprintCardWithContent(),
      SimpleBlueprintCardWithContentMixOrdering(),
      SimpleBlueprintCardWithSpansOverlapped(),
      SimpleBlueprintCardPolicyHorizontalSeTb(),
      SimpleBlueprintCardPolicyHorizontalEsTb(),
      SimpleBlueprintCardPolicyHorizontalSeBt(),
      SimpleBlueprintCardPolicyHorizontalEsBt(),
      SimpleBlueprintCardPolicyVerticalSeTb(),
      SimpleBlueprintCardPolicyVerticalEsTb(),
      SimpleBlueprintCardPolicyVerticalSeBt(),
      SimpleBlueprintCardPolicyVerticalEsBt(),
      SimpleBlueprintCardPolicyHorizontalSeTbRtl(),
    ]);
  }
}

class PadCard extends StatelessWidget {
  final double ratio;
  final Widget child;

  const PadCard({
    Key? key,
    required this.ratio,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: ratio,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: child,
          ),
        ),
      ),
    );
  }
}

class BlueprintCard extends StatelessWidget {
  final double ratio;
  final String? title;
  final Widget child;

  const BlueprintCard({
    Key? key,
    this.ratio = 1,
    this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: ratio,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: andreaBlue,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (title != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        title!,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16)
                    ],
                  ),
                Expanded(child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WeightGrid extends StatelessWidget {
  final int rowCount;
  final int columnCount;

  const WeightGrid({
    Key? key,
    required this.rowCount,
    required this.columnCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridPad(
      gridPadCells: GridPadCells.gridSize(
        rowCount: rowCount,
        columnCount: columnCount,
      ),
      children: [
        for (var i = 0; i < rowCount * columnCount; i++) const BlueprintBox()
      ],
    );
  }
}

class InteractivePinPadCard extends StatelessWidget {
  const InteractivePinPadCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: PadThemeProvider(
            theme: PinPadTheme(
              colors: PinPadColors(
                content: white,
                removeColor: heatWave,
                background: aswadBlack,
              ),
            ),
            child: InteractivePinPad(),
          ),
        ),
      ),
    );
  }
}

class EngineeringCalculatorPadCard extends StatelessWidget {
  const EngineeringCalculatorPadCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PadCard(
      ratio: 1.1,
      child: PadThemeProvider(
        theme: EngineeringCalculatorPadTheme(
          colors: EngineeringCalculatorPadColors(
            content: aswadBlack,
            removeContent: heatWave,
            actionsContent: andreaBlue,
            functionsContent: barneyPurple,
            background: white,
            numBackground: Colors.white10,
          ),
        ),
        child: EngineeringCalculatorPad(),
      ),
    );
  }
}

class SimplePriorityCalculatorPadCard extends StatelessWidget {
  const SimplePriorityCalculatorPadCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PadCard(
      ratio: 1,
      child: PadThemeProvider(
        theme: SimplePriorityCalculatorPadTheme(
          colors: SimplePriorityCalculatorPadColors(
            content: white,
            background: aswadBlack,
            removeBackground: heatWave,
            actionsBackground: andreaBlue,
          ),
        ),
        child: SimplePriorityCalculatorPad(),
      ),
    );
  }
}

class SimpleCalculatorPadCard extends StatelessWidget {
  const SimpleCalculatorPadCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PadCard(
      ratio: 0.9,
      child: PadThemeProvider(
        theme: SimpleCalculatorPadTheme(
          colors: SimpleCalculatorPadColors(
            content: aswadBlack,
            removeContent: heatWave,
            actionsContent: andreaBlue,
            background: white,
          ),
        ),
        child: SimpleCalculatorPad(),
      ),
    );
  }
}

class SimpleBlueprintCard extends StatelessWidget {
  const SimpleBlueprintCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlueprintCard(
      ratio: 1.5,
      child: GridPad(
        gridPadCells: GridPadCells.gridSize(rowCount: 3, columnCount: 4),
        children: [for (var i = 0; i < 13; i++) const BlueprintBox()],
      ),
    );
  }
}

class CustomSizeBlueprintCard extends StatelessWidget {
  const CustomSizeBlueprintCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlueprintCard(
      ratio: 1.5,
      child: GridPad(
        gridPadCells: GridPadCellsBuilder(rowCount: 3, columnCount: 4)
            .rowSize(0, 2.wt())
            .columnSize(3, 30.fx())
            .build(),
        children: [for (var i = 0; i < 12; i++) const BlueprintBox()],
      ),
    );
  }
}

class SimpleBlueprintCardWithContent extends StatelessWidget {
  const SimpleBlueprintCardWithContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const rowCount = 3;
    const columnCount = 4;
    return BlueprintCard(
      ratio: 1.5,
      child: Stack(
        children: [
          const WeightGrid(rowCount: rowCount, columnCount: columnCount),
          GridPad(
            gridPadCells: GridPadCells.gridSize(
              rowCount: rowCount,
              columnCount: columnCount,
            ),
            children: const [
              ContentBlueprintBox(text: '[0;0]'),
              ContentBlueprintBox(text: '[0;1]'),
            ],
          ),
        ],
      ),
    );
  }
}

class SimpleBlueprintCardWithContentMixOrdering extends StatelessWidget {
  const SimpleBlueprintCardWithContentMixOrdering({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const rowCount = 3;
    const columnCount = 4;
    return BlueprintCard(
      ratio: 1.5,
      child: Stack(
        children: [
          const WeightGrid(rowCount: rowCount, columnCount: columnCount),
          GridPad(
            gridPadCells: GridPadCells.gridSize(
              rowCount: rowCount,
              columnCount: columnCount,
            ),
            children: const [
              Cell(
                row: 1,
                column: 2,
                child: ContentBlueprintBox(text: '[1;2]\nOrder: 1'),
              ),
              Cell(
                row: 0,
                column: 1,
                child: ContentBlueprintBox(text: '[0;1]\nOrder: 2'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SimpleBlueprintCardWithSpansOverlapped extends StatelessWidget {
  const SimpleBlueprintCardWithSpansOverlapped({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const rowCount = 3;
    const columnCount = 4;
    return BlueprintCard(
      ratio: 1.5,
      child: Stack(
        children: [
          const WeightGrid(rowCount: rowCount, columnCount: columnCount),
          GridPad(
            gridPadCells: GridPadCells.gridSize(
              rowCount: rowCount,
              columnCount: columnCount,
            ),
            children: const [
              Cell.implicit(
                rowSpan: 3,
                columnSpan: 2,
                child: ContentBlueprintBox(text: '[0;0]\nSpan: 3x2'),
              ),
              Cell(
                row: 2,
                column: 1,
                columnSpan: 3,
                child:
                    ContentBlueprintBox(text: '[2;1]\nSpan: 1x3, overlapped'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SimpleBlueprintCardPolicy extends StatelessWidget {
  final Axis mainAxis;
  final HorizontalPolicy horizontalPolicy;
  final VerticalPolicy verticalPolicy;

  const SimpleBlueprintCardPolicy(
      this.mainAxis, this.horizontalPolicy, this.verticalPolicy,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const rowCount = 3;
    const columnCount = 4;
    final TextDirection layoutDirection = Directionality.of(context);
    return BlueprintCard(
      ratio: 1.2,
      title:
          'LayoutDirection = $layoutDirection\nmainAxis = $mainAxis\nhorizontal = $horizontalPolicy\nvertical = $verticalPolicy',
      child: Stack(
        children: [
          const WeightGrid(rowCount: rowCount, columnCount: columnCount),
          GridPad(
            gridPadCells: GridPadCells.gridSize(
              rowCount: rowCount,
              columnCount: columnCount,
            ),
            placementPolicy: GridPadPlacementPolicy(
              mainAxis: mainAxis,
              horizontalPolicy: horizontalPolicy,
              verticalPolicy: verticalPolicy,
            ),
            children: [
              for (var i = 0; i < rowCount * columnCount; i++)
                ContentBlueprintBox(text: '$i'),
            ],
          ),
        ],
      ),
    );
  }
}

class SimpleBlueprintCardPolicyHorizontalSeTb extends StatelessWidget {
  const SimpleBlueprintCardPolicyHorizontalSeTb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SimpleBlueprintCardPolicy(
      Axis.horizontal,
      HorizontalPolicy.startEnd,
      VerticalPolicy.topBottom,
    );
  }
}

class SimpleBlueprintCardPolicyHorizontalSeTbRtl extends StatelessWidget {
  const SimpleBlueprintCardPolicyHorizontalSeTbRtl({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: SimpleBlueprintCardPolicyHorizontalSeTb(),
    );
  }
}

class SimpleBlueprintCardPolicyHorizontalEsTb extends StatelessWidget {
  const SimpleBlueprintCardPolicyHorizontalEsTb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SimpleBlueprintCardPolicy(
      Axis.horizontal,
      HorizontalPolicy.endStart,
      VerticalPolicy.topBottom,
    );
  }
}

class SimpleBlueprintCardPolicyHorizontalSeBt extends StatelessWidget {
  const SimpleBlueprintCardPolicyHorizontalSeBt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SimpleBlueprintCardPolicy(
      Axis.horizontal,
      HorizontalPolicy.startEnd,
      VerticalPolicy.bottomTop,
    );
  }
}

class SimpleBlueprintCardPolicyHorizontalEsBt extends StatelessWidget {
  const SimpleBlueprintCardPolicyHorizontalEsBt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SimpleBlueprintCardPolicy(
      Axis.horizontal,
      HorizontalPolicy.endStart,
      VerticalPolicy.bottomTop,
    );
  }
}

class SimpleBlueprintCardPolicyVerticalSeTb extends StatelessWidget {
  const SimpleBlueprintCardPolicyVerticalSeTb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SimpleBlueprintCardPolicy(
      Axis.vertical,
      HorizontalPolicy.startEnd,
      VerticalPolicy.topBottom,
    );
  }
}

class SimpleBlueprintCardPolicyVerticalEsTb extends StatelessWidget {
  const SimpleBlueprintCardPolicyVerticalEsTb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SimpleBlueprintCardPolicy(
      Axis.vertical,
      HorizontalPolicy.endStart,
      VerticalPolicy.topBottom,
    );
  }
}

class SimpleBlueprintCardPolicyVerticalSeBt extends StatelessWidget {
  const SimpleBlueprintCardPolicyVerticalSeBt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SimpleBlueprintCardPolicy(
      Axis.vertical,
      HorizontalPolicy.startEnd,
      VerticalPolicy.bottomTop,
    );
  }
}

class SimpleBlueprintCardPolicyVerticalEsBt extends StatelessWidget {
  const SimpleBlueprintCardPolicyVerticalEsBt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SimpleBlueprintCardPolicy(
      Axis.vertical,
      HorizontalPolicy.endStart,
      VerticalPolicy.bottomTop,
    );
  }
}
