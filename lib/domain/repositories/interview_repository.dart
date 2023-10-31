import '../datasources/interview_datasource.dart';

abstract class InterviewRepository<T> {
  InterviewRepository({required this.datasource});
  final InterviewDatasource<T> datasource;

  Future<List<T>> getInterviewsRepository();
}
