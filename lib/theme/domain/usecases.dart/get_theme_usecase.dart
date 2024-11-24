import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/theme/domain/entities/theme.dart';
import 'package:confession/theme/domain/repositories/theme_repository.dart';

class GetThemeUseCase implements UseCase<Theme, NoParams> {
  const GetThemeUseCase({required ThemeRepository themeRepository})
      : _repository = themeRepository;

  final ThemeRepository _repository;

  @override
  Future<Theme> call(NoParams params) async {
    final model = await _repository.getThemeSettings();

    return model.toViewData();
  }
}
