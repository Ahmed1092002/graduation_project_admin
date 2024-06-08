part of 'feed_back_cubit.dart';

@immutable
sealed class FeedBackState {}

final class FeedBackInitial extends FeedBackState {}
class GetFeedbackLoading extends FeedBackState {}
class GetFeedbackSuccess extends FeedBackState {}
class GetFeedbackError extends FeedBackState {
  final String errorMessage;
  GetFeedbackError({required this.errorMessage});
}