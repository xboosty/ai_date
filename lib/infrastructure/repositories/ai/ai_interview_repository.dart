import '../../../domain/domain.dart' show InterviewEntity, InterviewRepository;

class AIInterviewRepository extends InterviewRepository<InterviewEntity> {
  AIInterviewRepository({required super.datasource});

  @override
  Future<List<InterviewEntity>> getInterviewsRepository() async {
    final List<InterviewEntity> interviews = await datasource.getInterviews();
    return interviews;
  }
}
