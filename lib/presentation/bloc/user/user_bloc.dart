import 'package:confession/core/base/bloc/bloc_event.dart';
import 'package:confession/domain/entities/user.dart';
import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/domain/usecases/user_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<BlocEvent<UserParams>, User> {
  UserBloc({
    required GetUserUseCase getUser,
    required SaveUserUseCase saveUser,
    required DeleteUserUseCase deleteUser,
  })  : _getUser = getUser,
        _saveUser = saveUser,
        _deleteUser = deleteUser,
        super(const User.empty()) {
    on<BlocEvent<UserParams>>(handleEvent);
  }
  final GetUserUseCase _getUser;
  final SaveUserUseCase _saveUser;
  final DeleteUserUseCase _deleteUser;

  Future<void> _onLoadUser(
    LoadUser event,
    Emitter<User> emit,
  ) async {
    try {
      final user = await _getUser(const NoParams());
      emit(user);
    } catch (e) {
      emit(const User.empty());
    }
  }

  Future<void> _onUpdateUser(
    UpdateUser event,
    Emitter<User> emit,
  ) async {
    try {
      await _saveUser(event.user);
      emit(event.user);
    } catch (e) {
      emit(const User.empty());
    }
  }

  Future<void> _onDeleteUser(
    DeleteUser event,
    Emitter<User> emit,
  ) async {
    try {
      await _deleteUser(const NoParams());
      emit(const User.empty());
    } catch (e) {
      emit(const User.empty());
    }
  }

  Future<void> handleEvent(
    BlocEvent<UserParams> event,
    Emitter<User> emit,
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
