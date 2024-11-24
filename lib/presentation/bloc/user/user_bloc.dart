import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/core/base/bloc/bloc_state.dart';
import 'package:confession/core/base/bloc/module_bloc.dart';
import 'package:confession/domain/entities/user.dart';
import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/domain/usecases/user_usecases.dart';

class UserBloc extends ModuleBloc<BlocEvent<UserParams>, User> {
  UserBloc({
    required GetUserUseCase getUser,
    required SaveUserUseCase saveUser,
    required DeleteUserUseCase deleteUser,
  })  : _getUser = getUser,
        _saveUser = saveUser,
        _deleteUser = deleteUser,
        super(const BlocState.initial()) {
    on<BlocEvent<UserParams>>(handleEvent);
  }
  final GetUserUseCase _getUser;
  final SaveUserUseCase _saveUser;
  final DeleteUserUseCase _deleteUser;

  Future<void> _onLoadUser(
    LoadUser event,
    Emitter<BlocState<User>> emit,
  ) async {
    try {
      emit(const BlocState.loading());
      final user = await _getUser(const NoParams());
      emit(BlocState.success(data: user));
    } catch (e) {
      emit(const BlocState.error());
    }
  }

  Future<void> _onUpdateUser(
    UpdateUser event,
    Emitter<BlocState<User>> emit,
  ) async {
    try {
      emit(const BlocState.loading());
      await _saveUser(event.user);
      emit(BlocState.success(data: event.user));
    } catch (e) {
      emit(const BlocState.error());
    }
  }

  Future<void> _onDeleteUser(
    DeleteUser event,
    Emitter<BlocState<User>> emit,
  ) async {
    try {
      emit(const BlocState.loading());
      await _deleteUser(const NoParams());
      emit(const BlocState.initial());
    } catch (e) {
      emit(const BlocState.error());
    }
  }

  @override
  Future<void> handleEvent(
    BlocEvent<UserParams> event,
    Emitter<BlocState<User>> emit,
  ) =>
      switch (event.argument) {
        LoadUser() => _onLoadUser(event.argument as LoadUser, emit),
        UpdateUser() => _onUpdateUser(event.argument as UpdateUser, emit),
        DeleteUser() => _onDeleteUser(event.argument as DeleteUser, emit),
      };
}

sealed class UserParams extends Param {
  const UserParams();

  @override
  List<Object?> get props => [];
}

class LoadUser extends UserParams {
  const LoadUser();
}

class UpdateUser extends UserParams {
  const UpdateUser(this.user);

  final User user;

  @override
  List<Object?> get props => [user];
}

class DeleteUser extends UserParams {
  const DeleteUser();
}
