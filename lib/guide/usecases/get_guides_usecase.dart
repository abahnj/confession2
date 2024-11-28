import 'package:confession/domain/usecases/usecase.dart';
import 'package:confession/guide/data/mappers/guides_mapper.dart';
import 'package:confession/guide/domain/entities/guide.dart';
import 'package:confession/guide/domain/repositories/guides_repository.dart';

class GetGuidesUsecase
    extends AsyncViewDataParamUseCase<GuideList, GuideParam> {
  GetGuidesUsecase({
    required GuidesRepository repository,
    required GuidesMapper guidesMapper,
  })  : _repository = repository,
        _mapper = guidesMapper;

  final GuidesRepository _repository;
  final GuidesMapper _mapper;

  @override
  Future<GuideList> call(GuideParam param) async {
    final guides = await _repository.getGuidesForId(param.id);

    return GuideList(data: guides.map(_mapper.toViewData).toList());
  }
}

class GuideParam extends Param {
  const GuideParam({required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}
