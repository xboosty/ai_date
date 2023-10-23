part of 'block_cubit.dart';

sealed class BlockState extends Equatable {
  const BlockState();

  @override
  List<Object> get props => [];
}

class BlockedUsersInitial extends BlockState {}

class BlockedUsersLoading extends BlockState {}

class BlockedUsersData extends BlockState {
  final List<UserEntity> users;

  const BlockedUsersData({required this.users});

  @override
  List<Object> get props => [users];
}

class BlockedUsersError extends BlockState {
  final String error;

  const BlockedUsersError({required this.error});

  @override
  List<Object> get props => [error];
}
