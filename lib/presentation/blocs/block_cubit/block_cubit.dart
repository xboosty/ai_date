import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../config/config.dart'
    show CouplesCubit, NtsBlockRepository, UserEntity, getIt;

part 'block_state.dart';

class BlockCubit extends Cubit<BlockState> {
  BlockCubit() : super(BlockedUsersInitial());

  final repo = getIt<NtsBlockRepository>();
  final couplesCubit = getIt<CouplesCubit>();

  Future<void> fetchBlockedUsers() async {
    await getUsersBloqued();
  }

  Future<void> getUsersBloqued() async {
    emit(BlockedUsersLoading());
    try {
      final users = await repo.userBloquedListRepository();
      emit(BlockedUsersData(users: users));
      print('Ya tiene data');
    } catch (e) {
      print(e.toString());
      emit(
        BlockedUsersError(
          error: e.toString(),
        ),
      );
      print('Hubo un error en cargar la data');
      rethrow;
    }
  }

  Future<void> blockedUser({required int id}) async {
    emit(BlockedUsersLoading());
    try {
      await repo.bloquedUserByIdRepository(id: id);
      // await fetchBlockedUsers();
      await couplesCubit.fetchCouplesUsers();
      emit(BlockedUsersInitial());
    } catch (e) {
      print(e.toString());
      emit(
        BlockedUsersError(
          error: e.toString(),
        ),
      );
      print('Hubo un error en verificacion');
      rethrow;
    }
  }

  Future<void> unBlockedUser({required int id}) async {
    emit(BlockedUsersLoading());
    try {
      await repo.unbloquedUserByIdRepository(id: id);
      await fetchBlockedUsers();
      await couplesCubit.fetchCouplesUsers();
      print('Se desbloqueo perfecto');
    } catch (e) {
      print(e.toString());
      emit(
        BlockedUsersError(
          error: e.toString(),
        ),
      );
      print('Hubo un error en verificacion');
      rethrow;
    }
  }
}
