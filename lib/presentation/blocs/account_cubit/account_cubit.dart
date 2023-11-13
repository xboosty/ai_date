import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../config/config.dart'
    show AIAccountRepository, NtsAccountAuthRepository, getIt;
import '../../../domain/domain.dart' show UserEntity;

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit()
      : super(const AccountState(status: UserRegisterStatus.initial));

  final repo = getIt<NtsAccountAuthRepository>();
  final repoApi = getIt<AIAccountRepository>();

  Future<void> registerUser(Map<String, dynamic> userRegister) async {
    // final Map<String, dynamic> userAI = {
    //   "email": userRegister['email'],
    //   "avatar": "string"
    // };
    emit(const AccountState(status: UserRegisterStatus.loading));
    try {
      final hasConnected = await InternetConnectionChecker().hasConnection;
      if (hasConnected) {
        final user = await repo.registerUserRepository(userRegister);
        emit(AccountState(status: UserRegisterStatus.success, user: user));
      } else {
        throw 'You don\'t have an internet connection';
      }
    } catch (e) {
      emit(
        AccountState(
          status: UserRegisterStatus.failure,
          errorMessage: e.toString(),
        ),
      );
      rethrow;
    }
  }

  Future<void> registerUserSocial(Map<String, dynamic> userRegister) async {
    emit(const AccountState(status: UserRegisterStatus.loading));
    try {
      final user = await repo.registerUserSocialRepository(userRegister);
      emit(AccountState(status: UserRegisterStatus.success, user: user));
    } catch (e) {
      emit(
        AccountState(
          status: UserRegisterStatus.failure,
          errorMessage: e.toString(),
        ),
      );
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
      emit(AccountState(status: UserRegisterStatus.initial, user: user));
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

  Future<void> signInUserSocial(String token) async {
    emit(const AccountState(status: UserRegisterStatus.loading));
    try {
      final user = await repo.signInUserSocialRepository(token);
      if (user != null) {
        emit(AccountState(status: UserRegisterStatus.success, user: user));
        print('SignIn Success');
        emit(AccountState(status: UserRegisterStatus.initial, user: user));
      } else {
        emit(
            const AccountState(user: null, status: UserRegisterStatus.initial));
        print('User does not exist');
      }
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
      emit(const AccountState(status: UserRegisterStatus.success, user: null));
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

  Future<void> forgotPasswordUser({required String email}) async {
    emit(const AccountState(status: UserRegisterStatus.loading));
    try {
      await repo.forgotPasswordRepository(email: email);
      emit(const AccountState(status: UserRegisterStatus.success));
      print('Forgot success');
    } catch (e) {
      print(e.toString());
      emit(
        AccountState(
          status: UserRegisterStatus.failure,
          errorMessage: e.toString(),
        ),
      );
      print('Forgot Failure');
      rethrow;
    }
  }

  Future<void> recoveryCredential(Map<String, dynamic> recoveryCred) async {
    emit(const AccountState(status: UserRegisterStatus.loading));
    try {
      await repo.recoveryPassword(recoveryCred);
      emit(const AccountState(status: UserRegisterStatus.success));
      print('Recovery success');
    } catch (e) {
      print(e.toString());
      emit(
        AccountState(
          status: UserRegisterStatus.failure,
          errorMessage: e.toString(),
        ),
      );
      print('Recovery Failure');
      rethrow;
    }
  }

  Future<void> editAccount(FormData userUpdate) async {
    emit(const AccountState(status: UserRegisterStatus.loading));
    try {
      final user = await repo.updateAccountRepository(userUpdate);
      emit(AccountState(status: UserRegisterStatus.success, user: user));
      emit(AccountState(status: UserRegisterStatus.initial, user: user));
    } catch (e) {
      emit(
        AccountState(
          status: UserRegisterStatus.failure,
          errorMessage: e.toString(),
        ),
      );
      rethrow;
    }
  }

  Future<void> getSecurityToken() async {
    emit(const AccountState(status: UserRegisterStatus.loading));
    try {
      final hasConnected = await InternetConnectionChecker().hasConnection;
      if (hasConnected) {
        // await repoApi.securityTokenRepository();
        emit(const AccountState(status: UserRegisterStatus.success));
      } else {
        throw Exception('You do not have internet, please connect');
      }
    } catch (e) {
      emit(
        AccountState(
          status: UserRegisterStatus.failure,
          errorMessage: e.toString(),
        ),
      );
      rethrow;
    }
  }
}
