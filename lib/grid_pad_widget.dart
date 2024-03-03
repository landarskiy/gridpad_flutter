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

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'grid_pad_cells.dart';
import 'grid_pad_placement.dart';

/// A widget for specifying the additional configuration
/// for placement in the grid.
///
/// With this widget can be specified:
/// - location in a grid ([row] and [column] properties)
/// - span size ([rowSpan] and [columnSpan] properties)
class Cell extends ProxyWidget {
  final int row;
  final int column;
  final int rowSpan;
  final int columnSpan;
  final bool _implicitly;

  const Cell({
    super.key,
    required this.row,
    required this.column,
    this.rowSpan = 1,
    this.columnSpan = 1,
    required super.child,
  })  : _implicitly = false,
        assert(rowSpan > 0),
        assert(columnSpan > 0);

  const Cell.implicit({
    super.key,
    this.rowSpan = 1,
    this.columnSpan = 1,
    required super.child,
  })  : _implicitly = true,
        row = 0,
        column = 0,
        assert(rowSpan > 0),
        assert(columnSpan > 0);

  @override
  Element createElement() {
    return _CellElement(this);
  }
}

extension CellExtension on Widget {
  /// Wrap the Widget in a Cell
  Cell cell({
    Key? key,
    required int row,
    required int column,
    int rowSpan = 1,
    int columnSpan = 1,
  }) {
    return Cell(
      key: key,
      row: row,
      column: column,
      rowSpan: rowSpan,
      columnSpan: columnSpan,
      child: this,
    );
  }

  /// Wrap the Widget in a implicit Cell
  Cell implicitCell({
    Key? key,
    int rowSpan = 1,
    int columnSpan = 1,
  }) {
    return Cell.implicit(
      key: key,
      rowSpan: rowSpan,
      columnSpan: columnSpan,
      child: this,
    );
  }
}

class _CellElement extends ProxyElement {
  _CellElement(super.widget);

  @override
  void notifyClients(covariant ProxyWidget oldWidget) {}
}

class _GridPadDelegate extends MultiChildLayoutDelegate {
  final GridPadCells cells;
  final List<GridPadContent> content;
  final TextDirection direction;

  _GridPadDelegate(this.cells, this.content, this.direction);

  @override
  void performLayout(Size size) {
    final cellPlaces = calculateCellPlaces(cells, size.width, size.height);
    content.forEachIndexed((index, item) {
      double maxWidth = 0;
      for (var column = item.left; column <= item.right; column++) {
        maxWidth += cellPlaces[item.top][column].width;
      }
      double maxHeight = 0;
      for (var row = item.top; row <= item.bottom; row++) {
        maxHeight += cellPlaces[row][item.left].height;
      }
      layoutChild(
        index,
        BoxConstraints(maxHeight: maxHeight, maxWidth: maxWidth),
      );
      final cellPlace = cellPlaces[item.top][item.left];
      if (direction == TextDirection.ltr) {
        positionChild(index, Offset(cellPlace.x, cellPlace.y));
      } else {
        positionChild(
          index,
          Offset(size.width - cellPlace.x - cellPlace.width, cellPlace.y),
        );
      }
    });
  }

  @override
  bool shouldRelayout(covariant _GridPadDelegate oldDelegate) {
    // First - do fast check (only count), after - full comparing
    return direction != oldDelegate.direction ||
        cells.rowCount != oldDelegate.cells.rowCount ||
        cells.columnCount != oldDelegate.cells.columnCount ||
        cells != oldDelegate.cells;
  }

  List<List<_CellPlaceInfo>> calculateCellPlaces(
    GridPadCells cells,
    double width,
    double height,
  ) {
    final cellWidths = calculateSizesForDimension(
      width,
      cells.columnSizes,
      cells.columnsTotalSize,
    );
    final cellHeights = calculateSizesForDimension(
      height,
      cells.rowSizes,
      cells.rowsTotalSize,
    );
    double y = 0;
    return cellHeights.map((cellHeight) {
      double x = 0;
      double cellY = y;
      y += cellHeight;
      return cellWidths.map((cellWidth) {
        double cellX = x;
        x += cellWidth;
        return _CellPlaceInfo(
          x: cellX,
          y: cellY,
          width: cellWidth,
          height: cellHeight,
        );
      }).toList();
    }).toList();
  }

  List<double> calculateSizesForDimension(
    double availableSize,
    List<GridPadCellSize> cellSizes,
    TotalSize totalSize,
  ) {
    final availableWeight = availableSize - totalSize.fixed;
    return cellSizes.map((cellSize) {
      switch (cellSize) {
        case Fixed():
          return cellSize.size;
        case Weight():
          return availableWeight * cellSize.size / totalSize.weight;
      }
    }).toList();
  }
}

/// Layout for placing elements in the grid.
///
/// Layout allows place elements in a grid defined through [gridPadCells]
/// parameter. By default, all [children] placed sequentially,
/// according [placementPolicy].
///
/// To specify an exact location or span size other than 1, the child
/// should be wrapped with the [Cell] widget.
///
/// **Widget have to be limited on both sides (width and height) otherwise an
/// exception will be thrown.**
class GridPad extends StatelessWidget {
  final GridPadCells gridPadCells;
  final List<GridPadContent> _content = [];
  final GridPadPlacementPolicy placementPolicy;
  final PlacementStrategy _placementStrategy;

  GridPad({
    super.key,
    required this.gridPadCells,
    required List<Widget> children,
    this.placementPolicy = GridPadPlacementPolicy.defaultPolicy,
  }) : _placementStrategy = GridPlacementStrategy(
          gridPadCells,
          placementPolicy,
        ) {
    for (var contentCell in children) {
      final Cell cell;
      if (contentCell is Cell) {
        cell = contentCell;
      } else {
        cell = Cell.implicit(child: contentCell);
      }
      if (cell._implicitly) {
        _placementStrategy.placeImplicitly(
          rowSpan: cell.rowSpan,
          columnSpan: cell.columnSpan,
          content: cell.child,
        );
      } else {
        _placementStrategy.placeExplicitly(
          row: cell.row,
          column: cell.column,
          rowSpan: cell.rowSpan,
          columnSpan: cell.columnSpan,
          content: cell.child,
        );
      }
    }
    _content.addAll(_placementStrategy.content);
  }

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: _GridPadDelegate(
        gridPadCells,
        _content,
        Directionality.maybeOf(context) ?? TextDirection.ltr,
      ),
      children: <Widget>[
        for (var i = 0; i < _content.length; i++)
          LayoutId(
            id: i,
            child: _content[i].content,
          ),
      ],
    );
  }
}

/// Stores information about the position and size of the cell
/// in the parent bounds.
class _CellPlaceInfo {
  /// x position.
  final double x;

  /// y position.
  final double y;

  /// Cell width.
  final double width;

  /// Cell height.
  final double height;

  const _CellPlaceInfo({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });
}
