part of "init_dependancies.dart";

final serviceLocator = GetIt.instance;

Future<void> initDependancies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.anonKey);
  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerFactory(() => InternetConnection());

  /// dependancies which are from core

  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerFactory<ConnectionCheck>(
      () => ConnectionCheckerImpl(serviceLocator()));
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(() => Hive.box(name: "blogs"));
}

void _initAuth() {
  ///Data Source
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImple(
        serviceLocator(),
      ),
    )
    //Repository
    ..registerFactory<AuthRepo>(
      () => AuthReposImple(serviceLocator(), serviceLocator()),
    )
    //Usecases
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignIn(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )

    //Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initBlog() {
  //DataSourece
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImple(serviceLocator()),
    )
    ..registerFactory<BlogLocalDataSource>(
        () => BlogLocalDataSourceImple(serviceLocator()))

    /// Repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImple(
          blogRemoteDataSource: serviceLocator(),
          blogLocalDataSource: serviceLocator(),
          connectionCheck: serviceLocator()),
    )

    /// Usecase
    ..registerFactory(
      () => UploadBlog(serviceLocator()),
    )
    ..registerFactory(
      () => GetAllBlogs(serviceLocator()),
    )
    //Bloc
    ..registerLazySingleton(
      () =>
          BlogBloc(getAllBlogs: serviceLocator(), uploadBlog: serviceLocator()),
    );
}
