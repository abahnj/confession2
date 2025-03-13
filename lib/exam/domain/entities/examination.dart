import 'package:confession/core/base/view_data.dart';

class Examination extends ViewData {
  const Examination({
    required this.id,
    required this.examinationText,
    required this.activeText,
    required this.count,
    required this.isCustom,
  });

  final int id;
  final String examinationText;
  final String activeText;
  final int count;
  final bool isCustom;

  Examination copyWith({
    String? examinationText,
    int? count,
  }) {
    return Examination(
      id: id,
      examinationText: examinationText ?? this.examinationText,
      activeText: activeText,
      count: count ?? this.count,
      isCustom: isCustom,
    );
  }

  @override
  List<Object> get props => [examinationText, count, id, isCustom, activeText];
}

class ExaminationsList extends ViewDataList<Examination> implements ViewData {
  const ExaminationsList({required super.data});

  @override
  List<Object> get props => [data];
}
