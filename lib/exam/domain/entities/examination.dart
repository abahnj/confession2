import 'package:confession/core/base/view_data.dart';

class Examination extends ViewData {
  const Examination({
    required this.id,
    required this.examinationText,
    required this.count,
  });

  final int id;
  final String examinationText;
  final int count;

  Examination copyWith({
    int? id,
    String? examinationText,
    int? count,
  }) {
    return Examination(
      id: id ?? this.id,
      examinationText: examinationText ?? this.examinationText,
      count: count ?? this.count,
    );
  }

  @override
  List<Object> get props => [examinationText, count, id];
}

class ExaminationsList extends ViewDataList<Examination> implements ViewData {
  const ExaminationsList({required super.data});

  @override
  List<Object> get props => [data];
}