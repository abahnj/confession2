import 'package:confession/core/base/view_data.dart';

class Prayer extends ViewData {
  const Prayer({
    required this.id,
    required this.prayerName,
    required this.text,
  });

  final int id;
  final String prayerName;
  final String text;

  @override
  List<Object> get props => [id, prayerName, text];
}

class PrayerList extends ViewDataList<Prayer> implements ViewData {
  const PrayerList({required super.data});

  @override
  List<Object> get props => [data];
}
