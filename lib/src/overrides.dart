// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:angular_testing/src/overrides/exception_handler.dart';
import 'package:angular2/di.dart';

export 'package:angular_testing/src/overrides/exception_handler.dart'
    show NgCaughtException, RethrowExceptionHandler;

/// All default application overrides used in the test infrastructure.
const allTestingOverrides = const [
  // Instead of silently catching errors, rethrow them so we can expect.
  const Provider(ExceptionHandler, useClass: RethrowExceptionHandler),
];
