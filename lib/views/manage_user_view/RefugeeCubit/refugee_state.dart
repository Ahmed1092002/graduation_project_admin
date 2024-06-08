part of 'refugee_cubit.dart';

@immutable
sealed class RefugeeState {}

final class RefugeeInitial extends RefugeeState {}

final class RefugeeLoading extends RefugeeState {}

final class RefugeeLoaded extends RefugeeState {
  final List<RefugeeModel> refugeeModel;
  RefugeeLoaded(this.refugeeModel);
}

final class RefugeeError extends RefugeeState {
  final String message;
  RefugeeError(this.message);
}


// Path: lib/views/manage_user_view/RefugeeCubit/refugee_cubit.dart
final class GetRefugeeByIdLoading extends RefugeeState {}

final class GetRefugeeByIdLoaded extends RefugeeState {
  final RefugeeModel refugeeModel;
  GetRefugeeByIdLoaded(this.refugeeModel);
}

final class GetRefugeeByIdError extends RefugeeState {
  final String message;
  GetRefugeeByIdError(this.message);
}



final class GetDataRefugeesLooding extends RefugeeState {}

final class GetDataRefugeesLoaded extends RefugeeState {

}

final class GetDataRefugeesError extends RefugeeState {
  final String message;
  GetDataRefugeesError(this.message);
}
final class GetPersonByIdLoading extends RefugeeState {}

final class GetPersonByIdLoaded extends RefugeeState {
  final PersonModel personModel;
  GetPersonByIdLoaded(this.personModel);
}

final class GetPersonByIdError extends RefugeeState {
  final String message;
  GetPersonByIdError(this.message);
}
final class GetUserByIdLoading extends RefugeeState {}

final class GetUserByIdLoaded extends RefugeeState {

}

final class GetUserByIdError extends RefugeeState {
  final String message;
  GetUserByIdError(this.message);
}

final class BlockUser extends RefugeeState {}

final class BlockUserLoading extends RefugeeState {}

final class BlockUserLoaded extends RefugeeState {}

final class BlockUserError extends RefugeeState {}

final class UnblockUserLoading extends RefugeeState {}

final class UnblockUserLoaded extends RefugeeState {}

final class UnblockUserError extends RefugeeState {}

final class UnblockUser extends RefugeeState {}

final class GetCountryByIdLoading extends RefugeeState {}

final class GetCountryByIdLoaded extends RefugeeState {
  final CountryModel countryModel;
  GetCountryByIdLoaded(this.countryModel);
}

final class GetCountryByIdError extends RefugeeState {
  final String message;
  GetCountryByIdError(this.message);
}


