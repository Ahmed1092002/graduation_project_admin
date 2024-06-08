part of 'recive_request_cubit.dart';

@immutable
sealed class ReciveRequestState {}

final class ReciveRequestInitial extends ReciveRequestState {}
class GetHelpingRequestLoading extends ReciveRequestState {}
class GetHelpingRequestSuccess extends ReciveRequestState {}
class GetHelpingRequestError extends ReciveRequestState {
  final String errorMessage;
  GetHelpingRequestError({required this.errorMessage});
}
class ChangeRequestStatusLoading extends ReciveRequestState {}
class ChangeRequestStatusSuccess extends ReciveRequestState {}
class ChangeRequestStatusError extends ReciveRequestState {
  final String errorMessage;
  ChangeRequestStatusError({required this.errorMessage});
}
