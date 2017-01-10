# angular_test

Testing infrastructure and runner for [AngularDart][gh_angular_dart].

[gh_angular_dart]: https://github.com/dart-lang/angular2

## Usage

`angular_test` is both a framework for writing tests for AngularDart components _and_ a
test _runner_ that delegates to both `pub serve` and `pub run test` to run component tests
using the AOT-compiler - `angular_test` **does not function in reflective mode**.

Example use:

```dart
@Tags(const ['aot'])
@TestOn('browser')
import 'dart:html';

import 'package:angular2/angular2.dart';
import 'package:angular_test/angular_test.dart';
import 'package:test/test.dart';

@AngularEntrypoint()
void main() {
  tearDown(() => disposeAnyRunningTest());

  test('should render "Hello World"', () async {
    final testBed = new NgTestBed<HelloWorldComponent>();
    final textFixture = await testBed.create();
    expect(testFixture.text, 'Hello World');
    await textFixture.update((c) => c.name = 'Universe');
    expect(textFixture.text, 'Hello Universe');
  });
}

@Component(selector: 'test', template: 'Hello {{name}}')
class HelloWorldComponent {
  String name = 'World';
}
```

## Running

Use `pub run angular_test` - it will automatically run `pub serve` to run code generation
(transformers) and `pub run test` to run browser tests on anything tagged with `'aot'`.:

```sh
$ pub run angular_test
```
