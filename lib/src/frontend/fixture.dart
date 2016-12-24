import 'dart:async';

import 'dart:html';
import 'package:angular2/angular2.dart';
import 'package:angular_test/src/frontend/stabilizer.dart';

class NgTestFixture<T> {
  final ApplicationRef _applicationRef;
  final ComponentRef _rootComponentRef;
  final NgTestStabilizer _testStabilizer;

  factory NgTestFixture(
    ApplicationRef applicationRef,
    ComponentRef rootComponentRef,
    NgTestStabilizer testStabilizer,
  ) = NgTestFixture<T>._;

  NgTestFixture._(
    this._applicationRef,
    this._rootComponentRef,
    this._testStabilizer,
  );

  /// Destroys the test case, returning a future that completes after disposed.
  ///
  /// In most cases, it is preferable to use `disposeAnyRunningTest`.
  Future<Null> dispose() async {
    await update();
    _rootComponentRef.destroy();
    _applicationRef.dispose();
  }

  /// Root element.
  Element get rootElement => _rootComponentRef.location.nativeElement;

  /// Returns a future that completes after the DOM is reported stable.
  ///
  /// It is import to `update` before making an assertion on the DOM, as Angular
  /// (and other services) could be waiting (asynchronously) to make a change -
  /// and often you'd want to assert against the _final_ state.
  ///
  /// #Example use
  /// ```dart
  /// expect(fixture.text, contains('Loading...'));
  /// await fixture.update();
  /// expect(fixture.text, contains('Hello World'));
  /// ```
  ///
  /// Optionally, pass a [run] to run _before_ stabilizing:
  /// await fixture.update((c) {
  ///   c.value = 5;
  /// });
  /// expect(fixture.text, contains('5 little piggies'));
  Future<Null> update({void run(T instance)}) {
    return _testStabilizer.stabilize(run: () {
      if (run != null) {
        new Future<Null>.sync(() {
          run(_rootComponentRef.instance);
        });
      }
    });
  }

  /// All text nodes within the fixture.
  ///
  /// Provided as a convenience to do simple `expect` matchers.
  String get text => rootElement.text;
}
