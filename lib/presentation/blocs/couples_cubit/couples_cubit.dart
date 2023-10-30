import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../config/config.dart' show NtsCouplesRepository, getIt;
import '../../../domain/domain.dart' show UserEntity;

part 'couples_state.dart';

class CouplesCubit extends Cubit<CouplesState> {
  CouplesCubit() : super(CouplesInitial());

  final repo = getIt<NtsCouplesRepository>();

  Future<void> fetchCouplesUsers() async {
    await getCouplesFake();
  }

  Future<void> getCouplesFake() async {
    emit(CouplesLoading());
    try {
      final couples = await repo.getFakeCouplesRepository();
      emit(CouplesData(couples: couples));
      print('Ya tiene data');
    } catch (e) {
      print(e.toString());
      emit(
        CouplesError(
          error: e.toString(),
        ),
      );
      print('Hubo un error en cargar la data');
      rethrow;
    }
  }
}
