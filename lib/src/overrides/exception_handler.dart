// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:angular2/di.dart';
import 'package:angular2/src/facade/exception_handler.dart';
import 'package:meta/meta.dart';

/// Encapsulates all exceptions caught by the [ExceptionHandler].
class NgCaughtException {
  /// Object that was thrown.
  final exception;

  /// Stack trace that was captured.
  final stackTrace;

  NgCaughtException._(this.exception, this.stackTrace);

  @override
  String toString() => '#$NgCaughtException {$exception, $stackTrace}';
}

/// Implements the an [ExceptionHandler], but throws whenever [call] is hit.
@Injectable()
class RethrowExceptionHandler implements ExceptionHandler {
  @literal
  const RethrowExceptionHandler();

  @override
  void call(exception, [stackTrace, _]) {
    throw new NgCaughtException._(exception, stackTrace);
  }
}
