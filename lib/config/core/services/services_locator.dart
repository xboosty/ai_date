import 'package:get_it/get_it.dart';
// Infrastructure
import '../../../infrastructure/infrastructure.dart';
export '../../../infrastructure/infrastructure.dart';
// Blocs
import '../../../presentation/blocs/blocs.dart';
export '../../../presentation/blocs/blocs.dart';

GetIt getIt = GetIt.instance;

void serviceLocatorBlocsInit() {
  getIt.registerSingleton(AccountCubit());
}

void serviceLocatorRepositoryInit() {
  getIt.registerSingleton(
    NtsAccountAuthRepository(datasource: NtsAccountAuthDatasource.ds),
  );
}
