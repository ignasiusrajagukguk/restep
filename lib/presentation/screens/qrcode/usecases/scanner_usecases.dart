import '../entities/scanner_entity.dart';
import '../repositories/scanner_repository.dart';

class GetRecentScansUseCase {
  final ScannerRepository _repository;
  const GetRecentScansUseCase({required ScannerRepository repository})
    : _repository = repository;
  Future<List<RecentScanEntity>> call() => _repository.getRecentScans();
}

class LookupPackageUseCase {
  final ScannerRepository _repository;
  const LookupPackageUseCase({required ScannerRepository repository})
    : _repository = repository;
  Future<ScanResultEntity> call(String valueScanned) =>
      _repository.lookupPackage(valueScanned);
}
