import '../datasources/couples_datasource.dart';

abstract class CouplesRepository<T> {
  CouplesRepository({required this.datasource});
  final CouplesDatasource<T> datasource;

  Future<List<T>> getFakeCouplesRepository();
}
