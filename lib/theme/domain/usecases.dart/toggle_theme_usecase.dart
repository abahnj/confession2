import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/theme/domain/entities/theme.dart';
import 'package:confession/theme/domain/repositories/theme_repository.dart';

class ToggleThemeUsecase implements UseCase<void, Theme> {
  const ToggleThemeUsecase({required ThemeRepository themeRepository})
      : _repository = themeRepository;

  final ThemeRepository _repository;

  @override
  Future<void> call(Theme params) =>
      _repository.saveThemeSettings(params.toDomain());
}
