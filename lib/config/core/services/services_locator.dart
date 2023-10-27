import 'package:get_it/get_it.dart';
// Configs
import '../../config.dart' show HandlerNotification;
// Infrastructure
import '../../../infrastructure/infrastructure.dart';
export '../../../infrastructure/infrastructure.dart';
// Blocs
import '../../../presentation/blocs/blocs.dart';
export '../../../presentation/blocs/blocs.dart';

GetIt getIt = GetIt.instance;

void serviceLocatorBlocsInit() {
  getIt.registerSingleton(AccountCubit());
  getIt.registerSingleton(BlockCubit());
  getIt.registerSingleton(CouplesCubit());
}

void serviceLocatorRepositoryInit() {
  getIt.registerSingleton(
    NtsAccountAuthRepository(datasource: NtsAccountAuthDatasource.ds),
  );
  getIt.registerSingleton(
    NtsBlockRepository(datasource: NtSprintBlockDatasource.ds),
  );
  getIt.registerSingleton(
    NtsCouplesRepository(datasource: NtSprintCouplesDatasource.ds),
  );
}

void serviceLocatorNotificationInit() {
  getIt.registerSingleton(HandlerNotification());
}
