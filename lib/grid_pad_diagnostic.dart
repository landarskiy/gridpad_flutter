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

/// Used to send diagnostic signals.
///
/// Default implementation is `null` and doing nothing, to handle need
/// to set custom [skippingItemCallback]
class GridPadDiagnosticLogger {
  static final GridPadDiagnosticLogger _instance =
      GridPadDiagnosticLogger._internal();

  /// Called when item has been skipped due to out the grid bounds.
  SkippingItemCallback? skippingItemCallback;

  factory GridPadDiagnosticLogger() {
    return _instance;
  }

  GridPadDiagnosticLogger._internal();

  ///Send skipped item signal [message] to [skippingItemCallback] callback.
  onItemSkipped(String message) {
    skippingItemCallback?.call(message);
  }
}

typedef SkippingItemCallback = void Function(String message);
