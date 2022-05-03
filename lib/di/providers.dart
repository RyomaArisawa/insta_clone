import 'package:insta_clone/models/db/database_manager.dart';
import 'package:insta_clone/models/location/location_manager.dart';
import 'package:insta_clone/models/repositories/post_repository.dart';
import 'package:insta_clone/models/repositories/user_repository.dart';
import 'package:insta_clone/viewmodels/post_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../viewmodels/login_view_model.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

List<SingleChildWidget> independentModels = [
  Provider<DatabaseManager>(
    create: (_) => DatabaseManager(),
  ),
  Provider<LocationManager>(
    create: (_) => LocationManager(),
  ),
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<DatabaseManager, UserRepository>(
    update: (_, databaseManager, repository) =>
        UserRepository(databaseManager: databaseManager),
  ),
  ProxyProvider2<DatabaseManager, LocationManager, PostRepository>(
    update: (_, databaseManager, locationManager, repository) => PostRepository(
        databaseManager: databaseManager, locationManager: locationManager),
  ),
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider(
    create: (context) => LoginViewModel(
      userRepository: context.read<UserRepository>(),
    ),
  ),
  ChangeNotifierProvider(
    create: (context) => PostViewModel(
      userRepository: context.read<UserRepository>(),
      postRepository: context.read<PostRepository>(),
    ),
  ),
];
