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

import 'package:flutter_test/flutter_test.dart';
import 'package:grid_pad/grid_pad_cells.dart';

void main() {
  test('Check equals and hashCode for the same GridPadCells', () {
    final left = GridPadCellsBuilder(rowCount: 2, columnCount: 4)
        .columnSize(1, const Weight(2))
        .rowSize(0, const Fixed(24))
        .build();
    final right = GridPadCellsBuilder(rowCount: 2, columnCount: 4)
        .columnSize(1, const Weight(2))
        .rowSize(0, const Fixed(24))
        .build();
    expect(left.hashCode, right.hashCode);
    expect(left, right);
  });

  test('Check equals and hashCode for the same TotalSize ', () {
    const weight = 1.0;
    const fixed = 2.0;
    // ignore: prefer_const_constructors
    final left = TotalSize(weight: weight, fixed: fixed);
    // ignore: prefer_const_constructors
    final right = TotalSize(weight: weight, fixed: fixed);
    expect(left.hashCode, right.hashCode);
    expect(left, right);
  });

  test('Check internal fields', () {
    final cells = GridPadCellsBuilder(rowCount: 2, columnCount: 4)
        .rowSize(0, const Weight(3))
        .rowSize(1, const Fixed(24))
        .columnSize(0, const Fixed(12))
        .columnSize(1, const Weight(2))
        .columnSize(2, const Fixed(10))
        .build();
    expect(2, cells.rowCount);
    expect(4, cells.columnCount);
    expect(24, cells.rowsTotalSize.fixed);
    expect(3, cells.rowsTotalSize.weight);
    expect(22, cells.columnsTotalSize.fixed);
    expect(3, cells.columnsTotalSize.weight);
    expect([const Weight(3), const Fixed(24)], cells.rowSizes);
    expect([
      const Fixed(12),
      const Weight(2),
      const Fixed(10),
      const Weight(1),
    ], cells.columnSizes);
  });

  test('Check constructors of GridPadCells', () {
    final expected = GridPadCellsBuilder(rowCount: 2, columnCount: 2).build();
    expect(expected, GridPadCells.gridSize(rowCount: 2, columnCount: 2));
    expect(
      expected,
      GridPadCells.sizes(
        rowSizes: WeightExtension.weightSame(2, 1),
        columnSizes: WeightExtension.weightSame(2, 1),
      ),
    );
  });

  test('Check GridPadCellsBuilder methods', () {
    final actual = GridPadCellsBuilder(rowCount: 2, columnCount: 3)
        .rowSize(0, const Fixed(30))
        .rowSize(1, const Fixed(30))
        .columnSize(0, const Weight(2))
        .columnSize(1, const Weight(2))
        .columnSize(2, const Weight(2))
        .build();
    final expected = GridPadCellsBuilder(rowCount: 2, columnCount: 3)
        .rowsSize(const Fixed(30))
        .columnsSize(const Weight(2))
        .build();
    expect(actual, expected);
  });

  test('Check extensions', () {
    expect([const Fixed(1), const Fixed(1)], FixedExtension.fixedSame(2, 1));
    expect([const Fixed(1), const Fixed(2)], FixedExtension.fixedSizes([1, 2]));
    expect(
      [const Weight(0.5), const Weight(0.5)],
      WeightExtension.weightSame(2, 0.5),
    );
    expect(
      [const Weight(0.5), const Weight(1.5)],
      WeightExtension.weightSizes([0.5, 1.5]),
    );
  });

  test('Check total size calculation', () {
    expect(
      const TotalSize(weight: 3, fixed: 22),
      [
        const Fixed(12),
        const Weight(2),
        const Fixed(10),
        const Weight(1),
      ].calculateTotalSize(),
    );
  });

  test(
    'Check fx() extension',
    () => {expect(12.5.fx(), const Fixed(12.5))},
  );

  test(
    'Check wt() extension',
    () => {expect(12.5.wt(), const Weight(12.5))},
  );
}
