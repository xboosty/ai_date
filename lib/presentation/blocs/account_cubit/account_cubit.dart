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
      print(e.toString());
      emit(
        AccountState(
          status: UserRegisterStatus.failure,
          errorMessage: e.toString(),
        ),
      );
      print('Hubo un error');
      rethrow;
    }
  }

  Future<void> verificationCode(Map<String, dynamic> verification) async {
    emit(const AccountState(status: UserRegisterStatus.loading));
    try {
      await repo.verificationCodeRepository(verification);
      emit(const AccountState(status: UserRegisterStatus.success));
      print('Se verifico perfecto');
    } catch (e) {
      print(e.toString());
      emit(
        AccountState(
          status: UserRegisterStatus.failure,
          errorMessage: e.toString(),
        ),
      );
      print('Hubo un error en verificacion');
      rethrow;
    }
  }

  Future<void> signInUser(Map<String, dynamic> credentials) async {
    emit(const AccountState(status: UserRegisterStatus.loading));
    try {
      final user = await repo.signInUserRepository(credentials);
      emit(AccountState(status: UserRegisterStatus.success, user: user));
      print('SignIn Success');
    } catch (e) {
      print(e.toString());
      emit(
        AccountState(
          status: UserRegisterStatus.failure,
          errorMessage: e.toString(),
        ),
      );
      print('SignIn Failure');
      rethrow;
    }
  }

  Future<void> logOutUser() async {
    emit(const AccountState(status: UserRegisterStatus.loading));
    try {
      await repo.logOutRepository();
    } catch (e) {
      print(e.toString());
      emit(
        AccountState(
          status: UserRegisterStatus.failure,
          errorMessage: e.toString(),
        ),
      );
      print('SignIn Failure');
      rethrow;
    }
  }

  Future<void> changePasswordUser(Map<String, dynamic> passwords) async {
    emit(const AccountState(status: UserRegisterStatus.loading));
    try {
      await repo.changePasswordRepository(passwords);
      emit(const AccountState(status: UserRegisterStatus.success));
      print('SignIn Success');
    } catch (e) {
      print(e.toString());
      emit(
        AccountState(
          status: UserRegisterStatus.failure,
          errorMessage: e.toString(),
        ),
      );
      print('SignIn Failure');
      rethrow;
    }
  }

  Future<void> forgotPasswordUser(
      {required String code, required String number}) async {
    emit(const AccountState(status: UserRegisterStatus.loading));
    try {
      await repo.forgotPasswordRepository(code: code, number: number);
      emit(const AccountState(status: UserRegisterStatus.success));
      print('SignIn Success');
    } catch (e) {
      print(e.toString());
      emit(
        AccountState(
          status: UserRegisterStatus.failure,
          errorMessage: e.toString(),
        ),
      );
      print('SignIn Failure');
      rethrow;
    }
  }
}
