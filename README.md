# GridPad Flutter layout

![github_title](https://github.com/landarskiy/gridpad_flutter/assets/2251498/f50dfd02-92cf-4789-ab78-204af7610ccc)

**grid_pad** is a Flutter library that allows you to place UI elements in a predefined grid,
manage spans in two dimensions, have flexible controls to manage row and column sizes.

[![Pub Version](https://img.shields.io/pub/v/grid_pad?color=blue)](https://pub.dev/packages/grid_pad)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Build Status](https://github.com/touchlane/gridpad_flutter/actions/workflows/quality.yml/badge.svg)](https://github.com/touchlane/gridpad_flutter/actions)
[![codecov](https://codecov.io/gh/touchlane/gridpad_flutter/branch/master/graph/badge.svg?token=MIUHAFNRPI)](https://codecov.io/gh/touchlane/gridpad_flutter)

# Usage

GridPad is inspired by Row and Column APIs, which makes its use intuitive.

Key features and limitations:

* Follows slot API concept.
* Not lazy. All content will be measured and placed instantly.
* GridPad must have limited bounds.
* It's possible to specify the exact place on the grid for each element.
* A cell can contain more than one item. The draw order will be the same as the place order.
* Each item in a cell can have different spans.
* Each item can have horizontal and vertical spans simultaneously.
* Each row and column can have a specific size: fixed or weight-based.

![grid_examples](https://github.com/landarskiy/gridpad_flutter/assets/2251498/0617750b-cd3d-4b93-97b8-8a3b8703e25b)

## Install

```shell
flutter pub add grid_pad
```

The command above add the following dependency:

```yaml
dependencies:
  grid_pad: <last_version>
```

To start using the library is enough to import the package:

```dart
import 'package:grid_pad/grid_pad.dart';
```

## Define the grid

Specifying the exact grid size is required, but specifying each row and column size is optional. The
following code initializes a 3x4 grid with rows and columns weights equal to 1:

```dart
GridPad(
  gridPadCells: GridPadCells.gridSize(rowCount: 3, columnCount: 4),       
  children: [],
);
```

![simple_define_grid_dark](https://github.com/landarskiy/gridpad_flutter/assets/2251498/c0552052-d613-4da9-828d-e7c6bacd2969)


By default rows and columns have **weight** size equal to 1, but it's possible specify different
size to specific row or column.
The library support 2 types of sizes:

* **Fixed** - fixed size, not change when the bounds of GridPad change.
* **Weight** - a relative, depends on other weights, remaining space after placing fixed sizes, 
  and the GridPad bounds.

To define a specific size for a row or column you need to use `GridPadCellsBuilder` API:

```dart
GridPad(
  gridPadCells: GridPadCellsBuilder(rowCount: 3, columnCount: 4)
    .rowSize(0, const Weight(2))
    .columnSize(3, const Fixed(90))
    .build(),
  children: [],
);
```

Instead of using `Weight` and `Fixed` explicitly, the appropriate extension functions can be used:

```dart
GridPad(
  gridPadCells: GridPadCellsBuilder(rowCount: 3, columnCount: 4)
    .rowSize(0, 2.wt())
    .columnSize(3, 90.fx())
    .build(),
  children: [],
);
```

![custom_define_grid_dark](https://github.com/landarskiy/gridpad_flutter/assets/2251498/4a769913-c84d-427c-8f1b-10a1574d2bf2)

The algorithm for allocating available space between cells:

1. All fixed (**Fixed**) values are subtracted from the available space.
2. The remaining space is allocated between the remaining cells according to their weight value.

## Place the items

Items in a GridPad can be placed **explicitly** and **implicitly**. Implicit placing placed 
the item **next to the last placed item** (including span size). Placement direction and 
first placement position depend on [`placementPolicy`](#placement-policy). By default, 
the first placing will be at position \[0;0] with a horizontal direction from start to end.

```dart
GridPad(
  gridPadCells: GridPadCells.gridSize(rowCount: 4, columnCount: 3),       
  children: [
    // 1-st item, row = 0, column = 0
    ChildWidget(),
    // 2-nd item, row = 0, column = 1
    ChildWidget(),
    // 3-rd item, row = 0, column = 2
    ChildWidget(),
    // 4-th item, row = 1, column = 0
    ChildWidget(),
  ],
);
```

> :warning: When the placement reaches the last cell, the following items will be ignored.
> Placing items outside the grid is not allowed.

To place an item explicitly or specify row and column span for implicitly placement need to wrap
child widget into the `Cell` widget. When defines `row` and `column` property it's also possible 
to place all items in a different order without regard to the actual location.

```dart
GridPad(
  gridPadCells: GridPadCells.gridSize(rowCount: 3, columnCount: 4),       
  children: [
    Cell(
      row: 1,
      column: 2,
      child: ChildWidget(),
    ),
    Cell(
      row: 0,
      column: 1,
      child: ChildWidget(),
    ),
  ],
);
```

Alternatively, instead of the Cell widget, `Widget.cell()` extension functions can be applied:

```dart
GridPad(
  gridPadCells: GridPadCells.gridSize(rowCount: 3, columnCount: 4),       
  children: [
    ChildWidget().cell(row: 1, column: 2),
    ChildWidget().cell(row: 0, column: 1),
  ],
);
```

![place_items_specific_dark](https://github.com/landarskiy/gridpad_flutter/assets/2251498/f1bf96e4-f7d2-4614-bda6-4e90ff18a741)

> :warning: A cell can contain more than one item. The draw order will be the same as the place
> order. GridPad does not limit the item's size when the child has an explicit size. That means that
> the item can go outside the cell bounds.

## Placement policy

To define the direction of placement items in an implicit method used the `placementPolicy`
property.

```dart
GridPad(
  gridPadCells: GridPadCells.gridSize(rowCount: 3, columnCount: 4),
  placementPolicy: GridPadPlacementPolicy(
    mainAxis: Axis.horizontal,
    horizontalPolicy: HorizontalPolicy.startEnd,
    verticalPolicy: VerticalPolicy.topBottom,
  ),
  children: [],
);
```

The `GridPadPlacementPolicy` class has three properties that allow controlling different aspects
of placement items.

* `mainAxis` sets the axis along which the item will be placed. When the axis is filled to the end,
  the next item will be placed on the next axis. If `mainAxis` is `horizontal` then items will be
  placed sequentially one by one by horizontal line. If `mainAxis` is `vertical` then items will be
  placed sequentially one by one by vertical line.
* `horizontalPolicy` sets the direction of placement horizontally. When `mainAxis` is
  `horizontal` this property describes the direction of placement of the next item. When `mainAxis`
  is `vertical` this property describes the direction of moving to the next axis. The `startEnd`
  means that the direction of placement items or moving main axis will begin from the start layout
  direction and move to the end layout direction (depending on LTR or RTL). The `endStart` means
  the same but in the opposite order.
* `verticalPolicy` sets the direction of placement vertically. When `mainAxis` is
  `vertical` this property describes the direction of placement of the next item. When `mainAxis`
  is `horizontal` this property describes the direction of moving to the next axis. The `topBottom`
  means that the direction of placement items or moving main axis will begin from the top and
  move to the bottom. The `bottomTop` means the same but in the opposite order.

![placement_policy](https://github.com/landarskiy/gridpad_flutter/assets/2251498/87cae035-71b7-44f9-9b48-ecbf5b8dd0df)

## Spans

By default, each item has a span of 1x1. To change it, specify one or both of the `rowSpan`
and `columnSpan` properties of the `Cell` widget.

```dart
GridPad(
  gridPadCells: GridPadCells.gridSize(rowCount: 3, columnCount: 4),       
  children: [
    // row = 0, column = 0, rowSpan = 3, columnSpan = 2
    Cell.implicit(
      rowSpan: 3,
      columnSpan: 2,
      child: ChildWidget(),
    ),
    // row = 0, column = 2, rowSpan = 2, columnSpan = 1
    Cell.implicit(
      rowSpan: 2,
      columnSpan: 1,
      child: ChildWidget(),
    ),
  ],
);
```

![spanned_dark](https://github.com/landarskiy/gridpad_flutter/assets/2251498/4ef7492a-12ed-4dae-a712-1ec95db8350a)

When an item has a span that goes outside the grid, the item is skipped and doesn't draw at all.
You can handle skipping cases by [diagnostic logger](#diagnostic).

```dart
GridPad(
  gridPadCells: GridPadCells.gridSize(rowCount: 3, columnCount: 4),       
  children: [
    // will be skipped in a drawing process because the item is placed in the column range [3;5] 
    // but the maximum allowable is 3
    ChildWidget().cell(row: 1, column: 3, rowSpan: 1, columnSpan: 3),
  ],
);
```

> :warning: When you have a complex structure it's highly recommended to use an **explicit** method
> of placing all items to avoid unpredictable behavior and mistakes during the placement of the
> items.

## Anchor

When `rowSpan` or `columnSpan` is more than 1 then the content is placed relative to the implicit
parameter - **anchor**. The anchor is the point in the corner from which the span expands.
The value depends on `horizontalPolicy` and `verticalPolicy` values in the `placementPolicy`
property.

![anchor](https://github.com/touchlane/gridpad_flutter/assets/2251498/9ec4d525-5450-4aba-a456-3896ce553db4)

## Layout Direction

The library handles the parent's `TextDirection` value. That means that placement in **RTL**
direction with `horizontalPolicy = startEnd` will have the same behavior as **LTR** direction
with `horizontalPolicy = endStart`.

## Diagnostic

The library doesn't throw any exceptions when an item is tried to place outside of the defined grid.
Instead, the library just sends a signal through the special class `GridPadDiagnosticLogger`,
skipping this item and moving to the next one. This silent behavior might be not suitable during
the development process, so there is a way to have more control - define a custom listener.
As a dev solution, you can just redirect the message to the console log or throw an exception to
fix it immediately.

# Enjoy using this library?

Join [:dizzy:Stargazers](https://github.com/touchlane/gridpad_flutter/stargazers) to support future development.

# License

```
MIT License

Copyright (c) 2023 Touchlane LLC tech@touchlane.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
