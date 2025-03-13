import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

extension ContextX on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

// TODO(abahnj): localize this
String getTimeAgo(String time) {
  final now = DateTime.now();
  final date = DateTime.tryParse(time);

  if (date == null) {
    return '__________';
  }

  final diff = now.difference(date);

  if (diff.isNegative) {
    return '__________';
  }

  const daysInWeek = Duration(days: 7);
  const daysInMonth = Duration(days: 30);
  const daysInYear = Duration(days: 365);

  if (diff < const Duration(days: 2)) {
    return 'a day';
  }

  if (diff < daysInWeek) {
    return '${diff.inDays} days';
  }

  final weeks = diff.inDays ~/ 7;
  if (diff < daysInMonth) {
    return weeks == 1 ? 'a week' : '$weeks weeks';
  }

  final months = diff.inDays ~/ 30;
  if (diff < daysInYear) {
    return months == 1 ? 'a month' : '$months months';
  }

  final years = diff.inDays ~/ 365;
  return years == 1 ? 'a year' : '$years years';
}

Future<String> getDeviceInfo() async {
  final deviceInfoPlugin = DeviceInfoPlugin();
  final packageInfoPlugin = await PackageInfo.fromPlatform();

  final appVersion =
      '${packageInfoPlugin.appName}  ${packageInfoPlugin.buildNumber}  ${packageInfoPlugin.version} ${packageInfoPlugin.packageName}';

  final deviceInfo = await deviceInfoPlugin.deviceInfo;

  return 'Device info ${deviceInfo.data} \n\n $appVersion';
}
