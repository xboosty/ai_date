part of 'interview_cubit.dart';

enum InterviewStatus { isNew, inProgress, done, error, isLoading }

class InterviewState extends Equatable {
  const InterviewState({this.interview, required this.status});

  final InterviewEntity? interview;
  final InterviewStatus status;

  @override
  List<Object?> get props => [interview, status];
}
