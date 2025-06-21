import 'package:architect/bloc/SubscriptionPlans/subscription_repository.dart';
import 'package:architect/bloc/state/state_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/SubscriptionPlans/subscription_cubit.dart';
import '../bloc/add_edit_post/add_edit_post_cubit.dart';
import '../bloc/add_edit_post/add_edit_post_repository.dart';
import '../bloc/architect_list/architect_cubit.dart';
import '../bloc/architect_list/architect_repository.dart';
import '../bloc/login/login_cubit.dart';
import '../bloc/login/login_repository.dart';
import '../bloc/register/register_cubit.dart';
import '../bloc/register/register_repository.dart';
import '../bloc/state/state_repository.dart';
import '../services/remote_data_source.dart';

class StateInjector {
  static final repositoryProviders = <RepositoryProvider>[
    RepositoryProvider<RemoteDataSource>(
      create: (context) => RemoteDataSourceImpl(),
    ),
    RepositoryProvider<ArchitectRepository>(
      create: (context) =>
          ArchitectImpl(remoteDataSource: context.read<RemoteDataSource>()),
    ),
    RepositoryProvider<RegisterRepository>(
      create: (context) => RegisterRepositoryImpl(
        remoteDataSource: context.read<RemoteDataSource>(),
      ),
    ),
    RepositoryProvider<LoginOTPRepository>(
      create: (context) => LogInRepositoryImpl(
        remoteDataSource: context.read<RemoteDataSource>(),
      ),
    ),
    RepositoryProvider<AddEditPostRepository>(
      create: (context) => AddEditPostRepositoryImpl(
        remoteDataSource: context.read<RemoteDataSource>(),
      ),
    ),
    RepositoryProvider<SubscriptionRepository>(
      create: (context) =>
          GetsubplansImpl(remoteDataSource: context.read<RemoteDataSource>()),
    ),

    RepositoryProvider<StateRepo>(
      create: (context) =>
          StateImpl(remoteDataSource: context.read<RemoteDataSource>()),
    ),
  ];

  static final blocProviders = <BlocProvider>[
    BlocProvider<LoginOTPCubit>(
      create: (context) => LoginOTPCubit(context.read<LoginOTPRepository>()),
    ),
    BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(context.read<RegisterRepository>()),
    ),
    BlocProvider<ArchitectCubit>(
      create: (context) => ArchitectCubit(context.read<ArchitectRepository>()),
    ),
    BlocProvider<AddEditPostCubit>(
      create: (context) =>
          AddEditPostCubit(context.read<AddEditPostRepository>()),
    ),
    BlocProvider<SubscriptionCubit>(
      create: (context) =>
          SubscriptionCubit(context.read<SubscriptionRepository>()),
    ),
    BlocProvider<StateCubit>(
      create: (context) => StateCubit(context.read<StateRepo>()),
    ),
  ];
}
