import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/theme/data/mappers/theme_mapper.dart';
import 'package:confession/theme/domain/entities/theme.dart';
import 'package:confession/theme/domain/repositories/theme_repository.dart';

class SwitchThemeUseCase implements UseCase<void, AppThemeMode> {
  const SwitchThemeUseCase({
    required ThemeRepository themeRepository,
    required ThemeMapper themeMapper,
  })  : _repository = themeRepository,
        _mapper = themeMapper;

  final ThemeRepository _repository;
  final ThemeMapper _mapper;

  @override
  Future<void> call(AppThemeMode params) =>
      _repository.saveThemeSettings(_mapper.toDomainModel(params));
}
