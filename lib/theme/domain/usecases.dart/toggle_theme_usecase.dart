import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/theme/domain/entities/theme.dart';
import 'package:confession/theme/domain/repositories/theme_repository.dart';

class ToggleThemeUsecase implements UseCase<void, AppThemeMode> {
  const ToggleThemeUsecase({required ThemeRepository themeRepository})
      : _repository = themeRepository;

  final ThemeRepository _repository;

  @override
  Future<void> call(AppThemeMode params) =>
      _repository.saveThemeSettings(params.toDomain());
}
