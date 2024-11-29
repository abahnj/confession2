import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/theme/data/mappers/theme_mapper.dart';
import 'package:confession/theme/domain/entities/theme.dart';
import 'package:confession/theme/domain/repositories/theme_repository.dart';

class GetThemeUseCase
    implements AsyncViewDataParamUseCase<AppThemeMode, NoParams> {
  const GetThemeUseCase({
    required ThemeRepository themeRepository,
    required ThemeMapper themeMapper,
  })  : _repository = themeRepository,
        _mapper = themeMapper;

  final ThemeRepository _repository;
  final ThemeMapper _mapper;

  @override
  Future<AppThemeMode> call(NoParams params) async {
    final model = await _repository.getThemeSettings();

    return _mapper.toViewData(model);
  }
}
