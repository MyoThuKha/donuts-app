import 'package:donuts/features/home/domain/repositories/home_repository.dart';
import 'package:donuts/features/home/domain/vo/home_section_vo.dart';

class WatchHomeSectionsUseCase {
  const new(this._repository);

  final HomeRepository _repository;

  Stream<List<HomeSectionVO>> call() => _repository.watchSections();
}
