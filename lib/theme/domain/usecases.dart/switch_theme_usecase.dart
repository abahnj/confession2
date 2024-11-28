import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/theme/data/mappers/theme_mapper.dart';
import 'package:confession/theme/domain/entities/theme.dart';
import 'package:confession/theme/domain/repositories/theme_repository.dart';

class SwitchThemeUseCase implements AsyncParamUseCase<SaveThemeParam> {
  const SwitchThemeUseCase({
    required ThemeRepository themeRepository,
    required ThemeMapper themeMapper,
  })  : _repository = themeRepository,
        _mapper = themeMapper;

  final ThemeRepository _repository;
  final ThemeMapper _mapper;

  @override
  Future<void> call(SaveThemeParam param) => _repository.saveThemeSettings(_mapper.toDomainModel(param.theme));
}

class SaveThemeParam extends Param {
  const SaveThemeParam({required this.theme});

  final AppThemeMode theme;

  @override
  List<Object?> get props => [theme];
}
