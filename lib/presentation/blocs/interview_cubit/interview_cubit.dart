import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ai_date/config/config.dart' show AIInterviewRepository, getIt;

import '../../../domain/domain.dart';

part 'interview_state.dart';

class InterviewCubit extends Cubit<List<InterviewState>> {
  InterviewCubit() : super([]);

  final repo = getIt<AIInterviewRepository>();

  Future<void> selectInterviews() async {
    emit(const [InterviewState(status: InterviewStatus.isLoading)]);
    try {
      final interviews = await repo.getInterviewsRepository();
      final interviewsStates = interviews.map((i) {
        // Assign status based on progress

        // Assign interviews
      }).toList();
      // emit(interviewsStates);
    } catch (e) {
      final currentData = state; // Guarda los datos actuales
      final errorState = [
        const InterviewState(status: InterviewStatus.error)
      ]; // Crea un estado de error

      emit([...currentData, ...errorState]);
      rethrow;
    }
  }
}
