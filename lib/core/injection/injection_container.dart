import 'package:get_it/get_it.dart';
import 'package:target/core/services/session_service.dart';
import 'package:target/modules/auth/data/datasources/auth_datasource.dart';
import 'package:target/modules/auth/data/datasources/auth_datasource_mock.dart';
import 'package:target/modules/auth/data/repositories/auth_repository_impl.dart';
import 'package:target/modules/auth/domain/repositories/auth_repository.dart';
import 'package:target/modules/auth/domain/usecases/login_usecase.dart';
import 'package:target/modules/auth/presentation/stores/auth_store.dart';
import 'package:target/modules/listing/presentation/stores/listing_store.dart';


final getIt = GetIt.instance;

Future<void> setupInjection() async {

  // SessionService 
  getIt.registerLazySingleton<SessionService>(() => SessionService());


  // Datasources
  getIt.registerLazySingleton<AuthDatasource>(() => AuthDatasourceMock());

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(datasource: getIt<AuthDatasource>()),
  );

  // Usecases
  getIt.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(getIt<AuthRepository>()),
  );

  // Stores 
  getIt.registerFactory<AuthStore>(
    () => AuthStore(
      loginUsecase: getIt<LoginUsecase>(),
      sessionService: getIt<SessionService>(),
    ),
  );

  getIt.registerFactory<ListingStore>(
    () => ListingStore(),
  );
}
