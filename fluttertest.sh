#!/bin/bash

# Run Flutter tests
flutter test --coverage --test-randomize-ordering-seed random

echo "Removing generated files from coverage report:"

if [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "darwin"* ]]; then
  # First let's print which files are being excluded (grep for "Excluding")
  lcov --remove coverage/lcov.info 'lib/**/*.g.dart' 'lib/**/*.t.dart' \
       -o coverage/lcov.info 2>&1 | grep "Excluding" 
  
  # Generate the HTML report quietly
  genhtml coverage/lcov.info -o coverage/ > /dev/null 2>&1
  echo "Coverage report generated at coverage/index.html"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
  # Windows version - capture and filter the output
  perl "C:\\ProgramData\\chocolatey\\lib\\lcov\\tools\\bin\\lcov" --remove coverage\\lcov.info "lib\\**\\*.g.dart" "lib\\**\\*.t.dart" -o coverage\\lcov.info 2>&1 | findstr "Excluding"
  
  # Generate HTML report quietly
  perl "C:\\ProgramData\\chocolatey\\lib\\lcov\\tools\\bin\\genhtml" -o coverage\\html coverage\\lcov.info > NUL 2>&1
  echo "Coverage report generated at coverage\\html\\index.html"
else
  echo "Unsupported OS: $OSTYPE"
  exit 1
fi

# Print a summary of the coverage percentage
if [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "darwin"* ]]; then
  echo "Coverage summary:"
  lcov --summary coverage/lcov.info | grep "lines\|functions\|branches"
else
  echo "Coverage summary:"
  perl "C:\\ProgramData\\chocolatey\\lib\\lcov\\tools\\bin\\lcov" --summary coverage\\lcov.info | findstr "lines\|functions\|branches"
fi