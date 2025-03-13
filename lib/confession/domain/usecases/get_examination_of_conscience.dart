import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/prayers/data/mappers/prayers_mapper.dart';
import 'package:confession/prayers/domain/entities/prayer.dart';
import 'package:confession/prayers/domain/repositories/prayers_repository.dart';

class GetExaminationOfConscienceUsecase extends AsyncViewDataUseCase<Prayer> {
  GetExaminationOfConscienceUsecase({
    required PrayersRepository repository,
    required PrayersMapper prayersMapper,
  })  : _repository = repository,
        _mapper = prayersMapper;

  final PrayersRepository _repository;
  final PrayersMapper _mapper;

  static const int _defaultExaminationOfConscienceId = 2;

  @override
  Future<Prayer> call() async {
    final prayer =
        await _repository.getPrayerById(_defaultExaminationOfConscienceId);

    return _mapper.toViewData(prayer);
  }
}
