import 'package:confession/core/base/view_data.dart';

class Inspiration extends ViewData {
  const Inspiration({
    required this.author,
    required this.quote,
  });

  final String author;
  final String quote;

  @override
  List<Object> get props => [author, quote];
}
