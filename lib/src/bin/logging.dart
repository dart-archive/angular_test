// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:ansicolor/ansicolor.dart';
import 'package:logging/logging.dart';

Logger _currentLogger;

final _green = new AnsiPen()..green();
final _red = new AnsiPen()..red();
final _yellow = new AnsiPen()..yellow();

void log(String message) {
  _currentLogger.info(message);
}

void success(String message) {
  _currentLogger.info(_green(message));
}

void warn(String message, {exception, stack}) {
  _currentLogger.warning(_yellow(message), exception, stack);
}

void error(String message, {exception, stack}) {
  _currentLogger.severe(_red(message), exception, stack);
}

/// Starts listening to a new logger and outputting it through `print`.
void initLogging(String name) {
  _currentLogger = new Logger(name);
  _currentLogger.onRecord.forEach((message) => print(message.message));
}
