// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:angular2/src/core/application_ref.dart';
import 'package:angular2/src/core/linker/app_view_utils.dart';
import 'package:angular2/angular2.dart';
import 'package:angular2/platform/browser_static.dart';
import 'package:angular_testing/src/overrides.dart';

/// Returns a future that completes with a new instantiated component.
///
/// It is treated as the root component of a temporary application for testing
/// and created within the [hostElement] provided.
///
/// If [beforeChangeDetection] is specified, allows interacting with instance of
/// component created _before_ the initial change detection occurs; for example
/// setting up properties or state.
Future<ComponentRef> bootstrapForTest/*<E>*/(
  Type appComponentType,
  Element hostElement, {
  void beforeChangeDetection(component/*=E*/),
  List addProviders: const [],
}) {
  if (appComponentType == null) {
    throw new ArgumentError.notNull('appComponentType');
  }
  if (hostElement == null) {
    throw new ArgumentError.notNull('hostElement');
  }
  // This should be kept in sync with 'bootstrapStatic' as much as possible.
  final platformRef = browserStaticPlatform();
  final appInjector = ReflectiveInjector.resolveAndCreate([
    BROWSER_APP_PROVIDERS,
    allTestingOverrides,
    addProviders,
  ], platformRef.injector);
  appViewUtils ??= appInjector.get(AppViewUtils);
  final ApplicationRefImpl appRef = appInjector.get(ApplicationRef);
  return appRef.run(() {
    return _runAndLoadComponent(
      appRef,
      appComponentType,
      hostElement,
      appInjector,
      beforeChangeDetection: beforeChangeDetection,
    );
  });
}

Future<ComponentRef> _runAndLoadComponent/*<E>*/(
  ApplicationRefImpl appRef,
  Type appComponentType,
  Element hostElement,
  Injector appInjector, {
  void beforeChangeDetection(component/*=E*/),
}) async {
  final DynamicComponentLoader loader = appInjector.get(DynamicComponentLoader);
  final componentRef = await loader.loadAsRootIntoNode(
    appComponentType,
    appInjector,
    overrideNode: hostElement,
  );
  if (beforeChangeDetection != null) {
    beforeChangeDetection(componentRef.instance);
  }
  appRef.registerChangeDetector(componentRef.changeDetectorRef);
  componentRef.onDestroy(() {
    appRef.unregisterChangeDetector(componentRef.changeDetectorRef);
  });
  appRef.tick();
  return componentRef;
}
