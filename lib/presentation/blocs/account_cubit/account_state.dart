part of 'account_cubit.dart';

// Define los estados posibles
enum UserRegisterStatus { initial, loading, success, failure }

class AccountState extends Equatable {
  const AccountState({
    required this.status,
    this.errorMessage = '',
    this.user,
  });

  final UserRegisterStatus status;
  final String errorMessage;
  final UserEntity? user;

  @override
  List<Object?> get props => [user, errorMessage, status];
}

// final class AccountData extends AccountState {}

// final class AccountLoading extends AccountState {}

// final class AccountError extends AccountState {}
