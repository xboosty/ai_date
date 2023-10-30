part of 'couples_cubit.dart';

sealed class CouplesState extends Equatable {
  const CouplesState();

  @override
  List<Object> get props => [];
}

class CouplesInitial extends CouplesState {}

class CouplesLoading extends CouplesState {}

class CouplesData extends CouplesState {
  final List<UserEntity> couples;

  const CouplesData({required this.couples});

  @override
  List<Object> get props => [couples];
}

class CouplesError extends CouplesState {
  final String error;

  const CouplesError({required this.error});

  @override
  List<Object> get props => [error];
}
