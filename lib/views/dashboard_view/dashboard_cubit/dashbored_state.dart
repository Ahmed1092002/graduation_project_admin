part of 'dashbored_cubit.dart';

@immutable
sealed class DashboredState {}

final class DashboredInitial extends DashboredState {}
final class NumberofRefugeeLoading extends DashboredState {}
final class NumberofRefugeeSuccess extends DashboredState {
  final int refugeeCount;
  NumberofRefugeeSuccess({required this.refugeeCount});
}
final class NumberofRefugeeError extends DashboredState {
  final String errorMessage;
  NumberofRefugeeError({required this.errorMessage});
}
final class CountPerJobLoading extends DashboredState {}
final class CountPerJobSuccess extends DashboredState {
  final List<CountPerJobModel> countPerJobModel;
  CountPerJobSuccess({required this.countPerJobModel});
}
final class CountPerJobError extends DashboredState {
  final String errorMessage;
  CountPerJobError({required this.errorMessage});
}

class NumberOfUsersPerMonthLoading extends DashboredState {}
class NumberOfUsersPerMonthSuccess extends DashboredState {
  final List<NumberOfUsersPerMonthModel> numberOfUsersPerMonthModel;
  NumberOfUsersPerMonthSuccess({required this.numberOfUsersPerMonthModel});
}
class NumberOfUsersPerMonthError extends DashboredState {
  final String errorMessage;
  NumberOfUsersPerMonthError({required this.errorMessage});
}

class DashboredLoading extends DashboredState {}
class DashboredSuccess extends DashboredState {}
class DashboredError extends DashboredState {
  final String errorMessage;
  DashboredError({required this.errorMessage});
}
class GetFeedbackLoading extends DashboredState {}
class GetFeedbackSuccess extends DashboredState {}
class GetFeedbackError extends DashboredState {
  final String errorMessage;
  GetFeedbackError({required this.errorMessage});
}

class GetHelpingRequestLoading extends DashboredState {}
class GetHelpingRequestSuccess extends DashboredState {}
class GetHelpingRequestError extends DashboredState {
  final String errorMessage;
  GetHelpingRequestError({required this.errorMessage});
}

