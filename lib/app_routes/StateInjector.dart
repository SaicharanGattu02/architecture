import 'package:architect/bloc/SubscriptionPlans/subscription_repository.dart';
import 'package:architect/bloc/city/city_cubit.dart';
import 'package:architect/bloc/create_payment/create_payment_cubit.dart';
import 'package:architect/bloc/paymentHistory/paymentHistory_cubit.dart';
import 'package:architect/bloc/paymentHistory/paymentHistory_repository.dart';
import 'package:architect/bloc/state/state_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/ArchitechAditionalInfo/architech_aditional_info_cubit.dart';
import '../bloc/ArchitechAditionalInfo/architech_aditional_info_repository.dart';
import '../bloc/ArchitechProfile/architech_profile_cubit.dart';
import '../bloc/ArchitechProfile/architech_profile_repository.dart';
import '../bloc/ArchitechProfileDetails/architech_profile_details_cubit.dart';
import '../bloc/ArchitechProfileDetails/architech_profile_details_repository.dart';
import '../bloc/CreateProfile/create_profile_cubit.dart';
import '../bloc/CreateProfile/create_profile_repository.dart';
import '../bloc/SubscriptionPlans/subscription_cubit.dart';
import '../bloc/add_edit_post/add_edit_post_cubit.dart';
import '../bloc/add_edit_post/add_edit_post_repository.dart';
import '../bloc/architect_list/architect_cubit.dart';
import '../bloc/architect_list/architect_repository.dart';
import '../bloc/categoryType/categoryType_cubit.dart';
import '../bloc/categoryType/categoryType_repository.dart';
import '../bloc/city/city_repository.dart';
import '../bloc/create_payment/create_payment_repository.dart';
import '../bloc/create_posted/create_post_cubit.dart';
import '../bloc/create_posted/create_post_repository.dart';
import '../bloc/internet_status/internet_status_bloc.dart';
import '../bloc/login/login_cubit.dart';
import '../bloc/login/login_repository.dart';
import '../bloc/register/register_cubit.dart';
import '../bloc/register/register_repository.dart';
import '../bloc/state/state_repository.dart';
import '../bloc/user_posts/user_posts_cubit.dart';
import '../bloc/user_posts/user_posts_repository.dart';
import '../bloc/user_posts_delete/user_post_deatails_cubit.dart';
import '../bloc/user_posts_delete/user_post_details_repository.dart';
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
    RepositoryProvider<CityRepo>(
      create: (context) =>
          CityImpl(remoteDataSource: context.read<RemoteDataSource>()),
    ),
    RepositoryProvider<CreateProfileRepository>(
      create: (context) =>
          CreateProfileImpl(remoteDataSource: context.read<RemoteDataSource>()),
    ),
    RepositoryProvider<CreatePostRepository>(
      create: (context) =>
          CreatePostImpl(remoteDataSource: context.read<RemoteDataSource>()),
    ),
    RepositoryProvider<UserPostsRepository>(
      create: (context) =>
          UserPostsImpl(remoteDataSource: context.read<RemoteDataSource>()),
    ),
    RepositoryProvider<ArchitechProfileRepository>(
      create: (context) => ArchitechProfileImpl(
        remoteDataSource: context.read<RemoteDataSource>(),
      ),
    ),
    RepositoryProvider<ArchitechProfileDetailsRepository>(
      create: (context) => ArchitechProfileDetailsImpl(
        remoteDataSource: context.read<RemoteDataSource>(),
      ),
    ),
    RepositoryProvider<ArchitechAditionalInfoRepository>(
      create: (context) => ArchitechAditionalInfoImpl(
        remoteDataSource: context.read<RemoteDataSource>(),
      ),
    ),
    RepositoryProvider<UserPostsDetailsRepository>(
      create: (context) => UserPostDetailsImpl(
        remoteDataSource: context.read<RemoteDataSource>(),
      ),
    ),
    RepositoryProvider<CreatePaymentRepository>(
      create: (context) =>
          CreatePaymentImpl(remoteDataSource: context.read<RemoteDataSource>()),
    ),
    RepositoryProvider<CategoryTypeRepo>(
      create: (context) =>
          CategoryTypeImpl(remoteDataSource: context.read<RemoteDataSource>()),
    ),
    RepositoryProvider<PaymentHistoryRepo>(
      create: (context) =>
          PaymentHistoryImpl(remoteDataSource: context.read<RemoteDataSource>()),
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
    BlocProvider<CityCubit>(
      create: (context) => CityCubit(context.read<CityRepo>()),
    ),
    BlocProvider<CreateProfileCubit>(
      create: (context) =>
          CreateProfileCubit(context.read<CreateProfileRepository>()),
    ),
    BlocProvider<CreatePostCubit>(
      create: (context) =>
          CreatePostCubit(context.read<CreatePostRepository>()),
    ),
    BlocProvider<UserPostsCubit>(
      create: (context) => UserPostsCubit(context.read<UserPostsRepository>()),
    ),
    BlocProvider<ArchitechProfileCubit>(
      create: (context) =>
          ArchitechProfileCubit(context.read<ArchitechProfileRepository>()),
    ),
    BlocProvider<ArchitechProfileDetailsCubit>(
      create: (context) => ArchitechProfileDetailsCubit(
        context.read<ArchitechProfileDetailsRepository>(),
      ),
    ),
    BlocProvider<ArchitechAditionalInfoCubit>(
      create: (context) => ArchitechAditionalInfoCubit(
        context.read<ArchitechAditionalInfoRepository>(),
      ),
    ),
    BlocProvider<UserPostDetailsCubit>(
      create: (context) =>
          UserPostDetailsCubit(context.read<UserPostsDetailsRepository>()),
    ),
    BlocProvider<CreatePaymentCubit>(
      create: (context) =>
          CreatePaymentCubit(context.read<CreatePaymentRepository>()),
    ),
    BlocProvider<CategoryTypeCubit>(
      create: (context) =>
          CategoryTypeCubit(context.read<CategoryTypeRepo>()),
    ),
    BlocProvider<PaymentHistoryCubit>(
      create: (context) =>
          PaymentHistoryCubit(context.read<PaymentHistoryRepo>()),
    ),
    BlocProvider<InternetStatusBloc>(create: (context) => InternetStatusBloc()),
  ];
}
