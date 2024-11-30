part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class GetProfileLoading extends ProfileState {}

class GetProfileSuccess extends ProfileState {
  final UserData data;

  GetProfileSuccess({required this.data});

  @override
  // TODO: implement props
  List<Object> get props => [data];
}

class GetProfileError extends ProfileState {
  final String? message;

  GetProfileError({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message ?? ""];
}

class ChangeSickLoading extends ProfileState {}

class ChangeSickSuccess extends ProfileState {}

class ChangeSickError extends ProfileState {
  final String? message;

  const ChangeSickError({required this.message});
  @override
  List<Object> get props => [message ?? ""];
}
