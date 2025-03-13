import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/prayers/data/mappers/prayers_mapper.dart';
import 'package:confession/prayers/domain/entities/inspiration.dart';
import 'package:confession/prayers/domain/repositories/prayers_repository.dart';

class GetRandomInspirationUsecase extends AsyncViewDataUseCase<Inspiration> {
  GetRandomInspirationUsecase({
    required PrayersRepository repository,
    required InspirationsMapper inspirationsMapper,
  })  : _repository = repository,
        _mapper = inspirationsMapper;

  final PrayersRepository _repository;
  final InspirationsMapper _mapper;

  @override
  Future<Inspiration> call() async {
    final inspiration = await _repository.getRandomInspiration();

    if (inspiration == null) {
      throw Exception('No inspiration found');
    }

    return _mapper.toViewData(inspiration);
  }
}
