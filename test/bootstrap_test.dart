// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@Tags(const ['aot'])
@TestOn('browser')
import 'dart:html';

import 'package:angular2/angular2.dart';
import 'package:angular_test/src/bootstrap.dart';
import 'package:test/test.dart';

@AngularEntrypoint()
void main() {
  test(
    'should create a new component in the DOM',
    NewComponentInDom._runTest,
  );
  test(
    'should call a handler before initial load',
    BeforeChangeDetection._runTest,
  );
}

@Component(
  selector: 'new-component-in-dom',
  template: 'Hello World',
)
class NewComponentInDom {
  static _runTest() async {
    final host = new Element.div();
    final test = await bootstrapForTest(
      NewComponentInDom,
      host,
    );
    expect(host.text, contains('Hello World'));
    test.destroy();
  }
}

@Component(
    selector: 'before-change-detection', template: 'Hello {{users.first}}!')
class BeforeChangeDetection {
  static _runTest() async {
    final host = new Element.div();
    final test = await bootstrapForTest/*<BeforeChangeDetection>*/(
      BeforeChangeDetection,
      host,
      beforeChangeDetection: (comp) => comp.users.add('Mati'),
    );
    expect(host.text, contains('Hello Mati!'));
    test.destroy();
  }

  // This will fail with an NPE if not initialized before change detection.
  final users = <String>[];
}
