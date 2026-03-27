part of 'update_profile_cubit.dart';

sealed class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object?> get props => [];
}

final class UpdateProfileInitial extends UpdateProfileState {}

final class UpdateProfileLoading extends UpdateProfileState {}

final class UpdateProfileSuccess extends UpdateProfileState {
  final UpdateProfileResultEntity result;

  const UpdateProfileSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

final class UpdateProfileFailure extends UpdateProfileState {
  final String message;

  const UpdateProfileFailure(this.message);

  @override
  List<Object?> get props => [message];
}
