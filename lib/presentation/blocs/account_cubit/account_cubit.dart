import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../config/config.dart' show NtsAccountAuthRepository, getIt;
import '../../../domain/domain.dart' show UserEntity;

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit()
      : super(const AccountState(status: UserRegisterStatus.initial));

  final repo = getIt<NtsAccountAuthRepository>();

  Future<void> registerUser(Map<String, dynamic> userRegister) async {
    emit(const AccountState(status: UserRegisterStatus.loading));
    try {
      final user = await repo.registerUserRepository(userRegister);
      emit(AccountState(status: UserRegisterStatus.success, user: user));
      print('Se Inserto perfecto');
    } catch (e) {
      emit(
        AccountState(
          status: UserRegisterStatus.failure,
          errorMessage: e.toString(),
        ),
      );
      print('Hubo un error');
    }
  }

  Future<void> verificationCode(Map<String, dynamic> verification) async {
    emit(const AccountState(status: UserRegisterStatus.loading));
    try {
      final isVerify = await repo.verificationCodeRepository(verification);
      emit(
          AccountState(status: UserRegisterStatus.success, isVerify: isVerify));
      print('Se verifico perfecto');
    } catch (e) {
      emit(
        AccountState(
          status: UserRegisterStatus.failure,
          errorMessage: e.toString(),
          isVerify: false,
        ),
      );
      print('Hubo un error en verificacion');
    }
  }
}
