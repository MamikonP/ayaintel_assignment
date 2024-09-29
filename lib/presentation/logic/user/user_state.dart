part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState({this.userEntity, this.error});

  final UserEntity? userEntity;
  final String? error;

  @override
  List<Object?> get props => [userEntity, error];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {
  UserLoading(UserState initState) : super(userEntity: initState.userEntity);
}

final class UserLoaded extends UserState {
  const UserLoaded(UserEntity? userEntity) : super(userEntity: userEntity);
}

final class UserLoggedIn extends UserState {
  const UserLoggedIn(UserEntity? userEntity) : super(userEntity: userEntity);
}

final class UserFailed extends UserState {
  UserFailed(UserState initState, String error)
      : super(userEntity: initState.userEntity, error: error);
}
