import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'interview_state.dart';

class InterviewCubit extends Cubit<InterviewState> {
  InterviewCubit() : super(InterviewInitial());
}
