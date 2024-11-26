import 'package:confession/core/base/view_data.dart';
import 'package:equatable/equatable.dart';

/// `BlocState` is a generic bloc-state defined for all unified bloc-states usecases across features.
/// This is strongly tied to `ViewEntity` for consistent expected response in the presentation-layer.
///
/// Example - 1:
/// [**emit** state in bloc using any of the below methods]
/// ```dart
/// emit(BlocState<SampleViewEntity>.initial())
/// emit(const Initial<SampleViewEntity>())
/// ```
///
/// Example - 2:
/// [**map** states in `BlocBuilder` widget]
/// ```dart
/// BlocBuilder<SampleBloc, BlocState<SampleViewEntity>>(
///   builder: (context, state) {
///     return state.map(
///       initial: () => InitialWidget(),
///       loading: () => LoadingWidget(),
///       success: (data) => SuccessWidget(data: data),
///       error: () => ErrorWidget(),
///     );
///   }
/// );
/// ```
///
/// Example - 3:
/// [**mapOrElse** states in `BlocBuilder` widget]
/// ```dart
/// BlocBuilder<SampleBloc, BlocState<SampleViewEntity>>(
///   builder: (context, state) {
///     return state.mapOrElse(
///       orElse: () => LoadingWidget(),
///       success: (data) => SuccessWidget(data: data),
///       error: () => ErrorWidget(),
///     );
///   }
/// );
/// ```
///
///
sealed class BlocState<T extends ViewData> extends Equatable {
  const BlocState();

  const factory BlocState.initial() = Initial<T>;
  const factory BlocState.loading() = Loading<T>;
  const factory BlocState.success({required T data}) = Success<T>;
  const factory BlocState.error() = Error<T>;

  E map<E>({
    required E Function() initial,
    required E Function() loading,
    required E Function(T data) success,
    required E Function() error,
  }) {
    return switch (this) {
      Initial<T>() => initial(),
      Loading<T>() => loading(),
      Success<T>(:final data) => success(data),
      Error<T>() => error(),
    };
  }

  E mapOrElse<E>({
    required E Function() orElse,
    E Function()? initial,
    E Function()? loading,
    E Function(T data)? success,
    E Function()? error,
  }) {
    return switch (this) {
      Initial<T>() => initial != null ? initial() : orElse(),
      Loading<T>() => loading != null ? loading() : orElse(),
      Success<T>(:final data) => success != null ? success(data) : orElse(),
      Error<T>() => error != null ? error() : orElse(),
    };
  }

  void maybeMap({
    void Function()? initial,
    void Function()? loading,
    void Function(T data)? success,
    void Function()? error,
  }) {
    return switch (this) {
      Initial<T>() => initial?.call(),
      Loading<T>() => loading?.call(),
      Success<T>(:final data) => success?.call(data),
      Error<T>() => error?.call(),
    };
  }
}

class Initial<T extends ViewData> extends BlocState<T> {
  const Initial();

  @override
  List<Object?> get props => [];
}

class Loading<T extends ViewData> extends BlocState<T> {
  const Loading();

  @override
  List<Object?> get props => [];
}

class Success<T extends ViewData> extends BlocState<T> {
  const Success({required this.data});
  final T data;

  @override
  List<Object?> get props => [data];
}

class Error<T extends ViewData> extends BlocState<T> {
  const Error();

  @override
  List<Object?> get props => [];
}
