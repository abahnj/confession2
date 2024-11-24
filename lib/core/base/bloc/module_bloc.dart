import 'package:bloc/bloc.dart';
import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/base/domain_model.dart';
import 'package:confession/core/base/view_data.dart';
import 'package:meta/meta.dart';

export 'package:bloc/bloc.dart' show Emitter;

/// `ModuleBloc` extends Bloc<E, S> and ensures expected types are provided
///
/// Example:
/// ```dart
/// import 'package:casino/src/core/core.dart';
/// import 'package:casino/src/core/interfaces/bloc/module_bloc.dart';
/// import 'package:casino_common/casino_common.dart';
///
/// class TestArg extends Argument {
///   @override
///    List<Object?> get props => [];
/// }
///
/// class TestViewEntity extends ViewEntity {
///   @override
///   List<Object?> get props => throw UnimplementedError();
/// }
///
/// class TestBloc extends ModuleBloc<BlocEvent<TestArg>, BlocState<TestViewEntity>> {
///   TestBloc() : super(const BlocState<TestViewEntity>.initial());
/// }
/// ```
///
///
abstract class ModuleBloc<Event extends BlocEvent, ViewDataType extends ViewData<DomainModel<ViewDataType>>>
    extends Bloc<Event, BlocState<ViewDataType>> {
  ModuleBloc(super.initialState);

  @protected
  Future<void> handleEvent(Event event, Emitter<BlocState<ViewDataType>> emit);

  /// override when its required to reconnect to stream based on `AppLifecycleStatus`
  ///
  /// Example;
  /// ```dart
  /// class SomeBloc extends ModuleBloc<BlocEvent<SampleArgument>, BlocState<SampleType>> {
  ///   SomeBloc() {
  ///     listenToAppLifecycle();
  ///   }
  ///
  ///   StreamSubscription<AppLifecycleStatus>? _appLifecycleStatusStreamSubscription;
  ///
  ///   @override
  ///   Future<void> close() async {
  ///      await _appLifecycleStatusStreamSubscription?.cancel();
  ///      return super.close();
  ///   }
  ///
  ///   @override
  ///   void listenToAppLifecycle() {
  ///     _appLifecycleStatusStreamSubscription ??= _appLifecycleNotifier.subscribe().listen((status) async {
  ///       if (status == AppLifecycleStatus.resumed) {
  ///         // Do something!!!
  ///       }
  ///     });
  ///
  ///     if (status == AppLifecycleStatus.paused) {
  ///       // Do something!!!
  ///     }
  ///   }
  /// }
  /// ```
  ///
  @protected
  void listenToAppLifecycle() {
    throw UnimplementedError(
      '`listenToAppLifecycle` method should be overridden before calling only when required!!!',
    );
  }
}
