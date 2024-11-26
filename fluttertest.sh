#!/bin/bash


flutter test --coverage --test-randomize-ordering-seed random

lcov --remove coverage/lcov.info \
  'lib/**/*.g.dart' \
  -o coverage/lcov.info 

genhtml coverage/lcov.info -o coverage/