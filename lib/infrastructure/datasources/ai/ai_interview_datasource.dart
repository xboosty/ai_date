import 'package:dio/dio.dart';

import '../../../domain/domain.dart' show InterviewDatasource, InterviewEntity;

class AIInterviewDatasource extends InterviewDatasource<InterviewEntity> {
  AIInterviewDatasource._();
  static final ds = AIInterviewDatasource._();

  // DIO Instance
  final dio = Dio();

  @override
  Future<List<InterviewEntity>> getInterviews() async {
    // TODO: implement getInterviews
    throw UnimplementedError();
  }
}
