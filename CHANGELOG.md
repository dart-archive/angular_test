# Changelog

## 1.0.0-alpha+3

- Fix a serious generic type error when `NgTestBed` is forked

## 1.0.0-alpha+2

- Fix a generic type error
- Added `compatibility.dart`, a temporary API to some users migrate

Changes to `compatibility.dart` might not be considered in future semver
updates, and it **highly suggested** you don't use these APIs for any new code.

## 1.0.0-alpha+1

- Change `NgTextFixture.update` to have a single optional parameter

## 1.0.0-alpha

- Initial commit with compatibility for AngularDart `2.2.0`
