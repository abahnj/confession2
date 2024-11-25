#!/bin/bash
# Script to generate Firebase configuration files for different environments/flavors
# Feel free to reuse and adapt this script for your own projects

if [[ $# -eq 0 ]]; then
  echo "Error: No environment specified. Use 'dev', 'stg', or 'prod'."
  exit 1
fi

case $1 in
  dev)
    flutterfire config \
      --project=confession-devj \
      --out=lib/firebase_options_development.dart \
      --ios-bundle-id=com.norvera.confession.dev \
      --ios-out=ios/flavors/development/GoogleService-Info.plist \
      --android-package-name=com.norvera.confession.dev \
      --android-out=android/app/src/development/google-services.json
    ;;
  stg)
    flutterfire config \
      --project=confession-stg \
      --out=lib/firebase_options_staging.dart \
      --ios-bundle-id=com.norvera.confession.stg \
      --ios-out=ios/flavors/staging/GoogleService-Info.plist \
      --android-package-name=com.norvera.confession.stg \
      --android-out=android/app/src/staging/google-services.json
    ;;
  prod)
    flutterfire config \
      --project=confession-flutter \
      --out=lib/firebase_options.dart \
      --ios-bundle-id=com.norvera.confession \
      --ios-out=ios/flavors/production/GoogleService-Info.plist \
      --android-package-name=com.norvera.confession \
      --android-out=android/app/src/google-services.json
    ;;
  *)
    echo "Error: Invalid environment specified. Use 'dev', 'stg', or 'prod'."
    exit 1
    ;;
esac