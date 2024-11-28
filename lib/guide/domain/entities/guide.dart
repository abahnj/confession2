import 'package:confession/core/base/view_data.dart';

class Guide extends ViewData {
  const Guide({
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  List<Object> get props => [title, text];
}

class GuideList extends ViewDataList<Guide> implements ViewData {
  const GuideList({required super.data});

  @override
  List<Object> get props => [data];
}
