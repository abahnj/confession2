#!/bin/bash


flutter test --coverage --test-randomize-ordering-seed random

if [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "darwin"* ]]; then
  lcov --remove coverage/lcov.info 'lib/**/*.g.dart' \
  'lib/**/*.t.dart'
  -o coverage/lcov.info
  genhtml coverage/lcov.info -o coverage/
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
  perl "C:\\ProgramData\\chocolatey\\lib\\lcov\\tools\\bin\\lcov" --remove coverage\\lcov.info "lib\\**\\*.g.dart" "lib\\**\\*.t.dart" -o coverage\\lcov.info
  perl "C:\\ProgramData\\chocolatey\\lib\\lcov\\tools\\bin\\genhtml" -o coverage\\html coverage\\lcov.info
else
  echo "Unsupported OS: $OSTYPE"
  exit 1
fi