part of 'job_cubit_cubit.dart';

@immutable
sealed class JobCubitState {}

final class JobCubitInitial extends JobCubitState {}

final class GetJobLoading extends JobCubitState {}

final class GetJobSuccess extends JobCubitState {}

final class GetJobError extends JobCubitState {}

final class AddJobError extends JobCubitState {}

final class AddJobLoading extends JobCubitState {}

final class AddJobSuccess extends JobCubitState {}


final class FilterJobLoading extends JobCubitState {}

final class FilterJobSuccess extends JobCubitState {}

final class FilterJobError extends JobCubitState {}
final class GetAllRefugeesAppliedOnThisJobSuccess extends JobCubitState {}
final class GetAllRefugeesAppliedOnThisJobLoading extends JobCubitState {}
final class GetAllRefugeesAppliedOnThisJobError extends JobCubitState {}

final class GetCountryByIdLoading extends JobCubitState {}

final class GetCountryByIdLoaded extends JobCubitState {
  final CountryModel countryModel;
  GetCountryByIdLoaded(this.countryModel);
}

final class GetCountryByIdError extends JobCubitState {
  final String message;
  GetCountryByIdError(this.message);
}



// Path: lib/views/manage_user_view/RefugeeCubit/refugee_cubit.dart
final class GetRefugeeByIdLoading extends JobCubitState {}

final class GetRefugeeByIdLoaded extends JobCubitState {
  final RefugeeModel refugeeModel;
  GetRefugeeByIdLoaded(this.refugeeModel);
}

final class GetRefugeeByIdError extends JobCubitState {
  final String message;
  GetRefugeeByIdError(this.message);
}



final class GetDataRefugeesLooding extends JobCubitState {}

final class GetDataRefugeesLoaded extends JobCubitState {

}

final class GetDataRefugeesError extends JobCubitState {
  final String message;
  GetDataRefugeesError(this.message);
}
final class GetPersonByIdLoading extends JobCubitState {}

final class GetPersonByIdLoaded extends JobCubitState {
  final PersonModel personModel;
  GetPersonByIdLoaded(this.personModel);
}

final class GetPersonByIdError extends JobCubitState {
  final String message;
  GetPersonByIdError(this.message);
}
final class GetUserByIdLoading extends JobCubitState {}

final class GetUserByIdLoaded extends JobCubitState {

}

final class GetUserByIdError extends JobCubitState {
  final String message;
  GetUserByIdError(this.message);
}



// Path: lib/views/manage_user_view/RefugeeCubit/refugee_state.dart
final class AcceptOrRejectRefugeeLoading extends JobCubitState {}

final class AcceptOrRejectRefugeeSuccess extends JobCubitState {}

final class AcceptOrRejectRefugeeError extends JobCubitState {}
final class GetJobByIdLoading extends JobCubitState {}

final class GetJobByIdSuccess extends JobCubitState {

}

final class GetJobByIdError extends JobCubitState {}
final class getAllAppliedjobsLoading extends JobCubitState {}


final class getAllAppliedjobsSuccess extends JobCubitState {

}

final class getAllAppliedjobsError extends JobCubitState {}
