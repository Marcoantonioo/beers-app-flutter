import 'package:app_miles/app_miles.dart';
import 'package:app_miles/core/local_store/local_store.dart';
import 'package:app_miles/core/local_store/local_store_impl.dart';
import 'package:get_it/get_it.dart';

class SessionDI {
  static void registerAll(GetIt container) {

    container.registerSingleton<LocalStore>(
      LocalStoreImpl(key: SessionDao.key),
    );

    container.registerFactory<SessionStore>(
        () => SessionDao(localStore: container.get()));

    container.registerFactory<SessionRepository>(
        () => SessionDataRepository(dao: container.get()));
  }
}
