#!/bin/bash

# Make sure dartfmt is run on everything
echo "Checking dartfmt..."
NEEDS_DARTFMT="$(dartfmt -n .)"
if [[ ${NEEDS_DARTFMT} != "" ]]
then
  echo "FAILED"
  echo "${NEEDS_DARTFMT}"
  exit 1
fi
echo "PASSED"

# Make sure we pass the analyzer
echo "Checking dartanalyzer..."
FAILS_ANALYZER="$(find bin lib test -name "*.dart" | xargs dartanalyzer)"
if [[ $FAILS_ANALYZER == *"[error]"* || $FAILS_ANALYZER == *"[lint]"* || $FAILS_ANALYZER == *"[hint]"* ]]
then
  echo "FAILED"
  echo "${FAILS_ANALYZER}"
  exit 1
fi
echo "PASSED"

# Fail on anything that fails going forward.
set -e

# Run any simple tests that just require the use of the VM
pub run test -p vm -x aot

# Run e2e-like tests that use Angular AoT compilation
if [ "$TRAVIS" = "true" ]
then
  # TODO(kevmoo) Enable these once we figure out what's wrong with travis
  echo "Skipping 'pub run angular_test' - see https://github.com/dart-lang/angular_test/issues/23"
else
  pub run angular_test
fi
