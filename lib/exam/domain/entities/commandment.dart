import 'package:confession/core/base/view_data.dart';

class Commandment extends ViewData {
  const Commandment({
    required this.id,
    required this.commandment,
    required this.commandmentText,
  });

  final int id;
  final String commandment;
  final String commandmentText;

  @override
  List<Object> get props => [id, commandment, commandmentText];
}

class CommandmentList extends ViewDataList<Commandment> implements ViewData {
  const CommandmentList({required super.data});

  @override
  List<Object> get props => [data];
}
