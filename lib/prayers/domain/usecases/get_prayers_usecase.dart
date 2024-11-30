import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/prayers/data/mappers/prayers_mapper.dart';
import 'package:confession/prayers/domain/entities/prayer.dart';
import 'package:confession/prayers/domain/repositories/prayers_repository.dart';

class GetPrayersUsecase extends AsyncViewDataUseCase<PrayerList> {
  GetPrayersUsecase({
    required PrayersRepository repository,
    required PrayersMapper prayersMapper,
  })  : _repository = repository,
        _mapper = prayersMapper;

  final PrayersRepository _repository;
  final PrayersMapper _mapper;

  @override
  Future<PrayerList> call() async {
    final prayers = await _repository.getPrayers();

    return PrayerList(data: prayers.map(_mapper.toViewData).toList());
  }
}
