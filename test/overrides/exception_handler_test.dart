// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:angular_testing/src/overrides.dart';
import 'package:test/test.dart';

void main() {
  test('should throw any caught exception again', () {
    final handler = const RethrowExceptionHandler();
    expect(
      () => handler(new StateError('Testing')),
      throwsA(const isInstanceOf<NgCaughtException>()),
    );
  });
}
