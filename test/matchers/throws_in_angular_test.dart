import 'package:angular2/src/facade/exceptions.dart';
import 'package:angular_test/src/matchers.dart';
import 'package:test/test.dart';

void main() {
  test('should catch a non-wrapped exception', () {
    expect(() => throw new StateError('Test'), throwsInAngular(isStateError));
  });

  test('should catch a view-wrapped exception', () {
    expect(
      () => throw new WrappedException('', new StateError('Test'), null, null),
      throwsInAngular(isStateError),
    );
  });
}
