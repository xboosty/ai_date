import 'package:get_it/get_it.dart';
// Configs
import '../../config.dart' show HandlerNotification, NavigationsApp, VersionApp;
// Infrastructure
import '../../../infrastructure/infrastructure.dart';
export '../../../infrastructure/infrastructure.dart';
// Blocs
import '../../../presentation/blocs/blocs.dart';
export '../../../presentation/blocs/blocs.dart';

GetIt getIt = GetIt.instance;

void serviceLocatorBlocsInit() {
  getIt.registerSingleton(AccountCubit());
  getIt.registerSingleton(InterviewCubit());
  getIt.registerSingleton(CouplesCubit());
  getIt.registerSingleton(BlockCubit());
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
  getIt.registerSingleton(
    AIInterviewRepository(datasource: AIInterviewDatasource.ds),
  );
  getIt.registerSingleton(
    AIAccountRepository(datasource: AIAccountAuthDatasource.ds),
  );
}

void serviceLocatorNotificationInit() {
  getIt.registerSingleton(HandlerNotification());
}

void serviceNavigationAppInit() {
  getIt.registerSingleton(NavigationsApp());
}

void serviceVersionPackagesAppInit() {
  getIt.registerSingleton(VersionApp);
}
