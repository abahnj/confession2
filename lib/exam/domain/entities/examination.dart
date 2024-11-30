import 'package:confession/core/base/view_data.dart';

class Examination extends ViewData {
  const Examination({
    required this.id,
    required this.examinationText,
    required this.count,
    required this.isCustom,
  });

  final int id;
  final String examinationText;
  final int count;
  final bool isCustom;

  Examination copyWith({
    String? examinationText,
    int? count,
  }) {
    return Examination(
      id: id,
      examinationText: examinationText ?? this.examinationText,
      count: count ?? this.count,
      isCustom: isCustom,
    );
  }

  @override
  List<Object> get props => [examinationText, count, id, isCustom];
}

class ExaminationsList extends ViewDataList<Examination> implements ViewData {
  const ExaminationsList({required super.data});

  @override
  List<Object> get props => [data];
}
