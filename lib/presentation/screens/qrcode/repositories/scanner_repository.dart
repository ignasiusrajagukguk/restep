import '../entities/scanner_entity.dart';

abstract class ScannerRepository {
  Future<List<RecentScanEntity>> getRecentScans();
  Future<ScanResultEntity> lookupPackage(String valueScanned);
}
