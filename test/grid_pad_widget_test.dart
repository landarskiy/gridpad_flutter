/*
 * MIT License
 *
 * Copyright (c) 2023 Touchlane LLC tech@touchlane.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grid_pad/grid_pad.dart';

void main() {
  Widget buildDefaultWidget(
    int rowCount,
    int columnCount,
    GridPadPlacementPolicy placementPolicy,
  ) {
    const rowCount = 3;
    const columnCount = 4;
    final List<Widget> children = [];
    for (var row = 0; row < rowCount; row++) {
      for (var col = 0; col < columnCount; col++) {
        children.add(Text('$row:$col'));
      }
    }
    return App(
      child: GridPad(
        gridPadCells: GridPadCells.gridSize(
          rowCount: rowCount,
          columnCount: columnCount,
        ),
        placementPolicy: placementPolicy,
        children: children,
      ),
    );
  }

  Widget buildWidgetWithSpan(
    int rowCount,
    int columnCount,
    GridPadPlacementPolicy placementPolicy,
  ) {
    const rowCount = 3;
    const columnCount = 4;
    return App(
      child: GridPad(
        gridPadCells: GridPadCells.gridSize(
          rowCount: rowCount,
          columnCount: columnCount,
        ),
        placementPolicy: placementPolicy,
        children: [
          const Text('0:0').implicitCell(rowSpan: 2, columnSpan: 2),
        ],
      ),
    );
  }

  testWidgets(
    'Check implicitly placement with different policies',
    (tester) async {
      const rowCount = 3;
      const columnCount = 4;
      validateExists(GridPadPlacementPolicy policy) {
        for (var row = 0; row < rowCount; row++) {
          for (var col = 0; col < columnCount; col++) {
            expect(
              find.text('$row:$col'),
              findsOneWidget,
              reason: policy.shortDescription(),
            );
          }
        }
      }

      List<GridPadPlacementPolicy> policies = [
        GridPadPlacementPolicy(
          mainAxis: Axis.horizontal,
          horizontalPolicy: HorizontalPolicy.startEnd,
          verticalPolicy: VerticalPolicy.topBottom,
        ),
        GridPadPlacementPolicy(
          mainAxis: Axis.horizontal,
          horizontalPolicy: HorizontalPolicy.endStart,
          verticalPolicy: VerticalPolicy.topBottom,
        ),
        GridPadPlacementPolicy(
          mainAxis: Axis.horizontal,
          horizontalPolicy: HorizontalPolicy.startEnd,
          verticalPolicy: VerticalPolicy.bottomTop,
        ),
        GridPadPlacementPolicy(
          mainAxis: Axis.horizontal,
          horizontalPolicy: HorizontalPolicy.endStart,
          verticalPolicy: VerticalPolicy.bottomTop,
        ),
        GridPadPlacementPolicy(
          mainAxis: Axis.vertical,
          horizontalPolicy: HorizontalPolicy.startEnd,
          verticalPolicy: VerticalPolicy.topBottom,
        ),
        GridPadPlacementPolicy(
          mainAxis: Axis.vertical,
          horizontalPolicy: HorizontalPolicy.endStart,
          verticalPolicy: VerticalPolicy.topBottom,
        ),
        GridPadPlacementPolicy(
          mainAxis: Axis.vertical,
          horizontalPolicy: HorizontalPolicy.startEnd,
          verticalPolicy: VerticalPolicy.bottomTop,
        ),
        GridPadPlacementPolicy(
          mainAxis: Axis.vertical,
          horizontalPolicy: HorizontalPolicy.endStart,
          verticalPolicy: VerticalPolicy.bottomTop,
        ),
      ];
      for (var policy in policies) {
        await tester.pumpWidget(
          buildDefaultWidget(
            rowCount,
            columnCount,
            policy,
          ),
        );
        validateExists(policy);
      }
    },
  );

  testWidgets(
    'Check placement spanned with different policies',
    (tester) async {
      const rowCount = 3;
      const columnCount = 4;
      validateExists(GridPadPlacementPolicy policy) {
        expect(
          find.text('0:0'),
          findsOneWidget,
          reason: policy.shortDescription(),
        );
      }

      List<GridPadPlacementPolicy> policies = [
        GridPadPlacementPolicy(
          mainAxis: Axis.horizontal,
          horizontalPolicy: HorizontalPolicy.startEnd,
          verticalPolicy: VerticalPolicy.topBottom,
        ),
        GridPadPlacementPolicy(
          mainAxis: Axis.horizontal,
          horizontalPolicy: HorizontalPolicy.endStart,
          verticalPolicy: VerticalPolicy.topBottom,
        ),
        GridPadPlacementPolicy(
          mainAxis: Axis.horizontal,
          horizontalPolicy: HorizontalPolicy.startEnd,
          verticalPolicy: VerticalPolicy.bottomTop,
        ),
        GridPadPlacementPolicy(
          mainAxis: Axis.horizontal,
          horizontalPolicy: HorizontalPolicy.endStart,
          verticalPolicy: VerticalPolicy.bottomTop,
        ),
        GridPadPlacementPolicy(
          mainAxis: Axis.vertical,
          horizontalPolicy: HorizontalPolicy.startEnd,
          verticalPolicy: VerticalPolicy.topBottom,
        ),
        GridPadPlacementPolicy(
          mainAxis: Axis.vertical,
          horizontalPolicy: HorizontalPolicy.endStart,
          verticalPolicy: VerticalPolicy.topBottom,
        ),
        GridPadPlacementPolicy(
          mainAxis: Axis.vertical,
          horizontalPolicy: HorizontalPolicy.startEnd,
          verticalPolicy: VerticalPolicy.bottomTop,
        ),
        GridPadPlacementPolicy(
          mainAxis: Axis.vertical,
          horizontalPolicy: HorizontalPolicy.endStart,
          verticalPolicy: VerticalPolicy.bottomTop,
        ),
      ];
      for (var policy in policies) {
        await tester.pumpWidget(
          buildWidgetWithSpan(
            rowCount,
            columnCount,
            policy,
          ),
        );
        validateExists(policy);
      }
    },
  );
}

class App extends StatelessWidget {
  final Widget child;

  const App({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: child));
  }
}

extension GridPadPlacementPolicyExtension on GridPadPlacementPolicy {
  String shortDescription() {
    String msg = '';
    if (mainAxis == Axis.horizontal) {
      msg += 'H-';
    } else {
      msg += 'V-';
    }
    if (horizontalPolicy == HorizontalPolicy.startEnd) {
      msg += 'SE:';
    } else {
      msg += 'ES:';
    }
    if (verticalPolicy == VerticalPolicy.topBottom) {
      msg += 'TB';
    } else {
      msg += 'BT';
    }
    return msg;
  }
}
