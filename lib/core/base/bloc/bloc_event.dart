import 'package:confession/domain/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

/// Generic bloc-event for all bloc event usecases. Requires all argument parsed to extend `Argument` type.
///
/// Example:
/// ```dart
/// class DoSomethingArgument extends Argument {
///   ...
/// }
///
/// final argument = DoSomethingArgument(...);
/// final event = BlocEvent(argument: argument);
/// ```
///
class BlocEvent<T extends Param> extends Equatable {
  const BlocEvent({required this.argument});

  const BlocEvent.noParam() : this(argument: noParam as T);
  final T argument;

  @override
  List<Object?> get props => [argument];
}
