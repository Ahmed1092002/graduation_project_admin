part of 'content_cubit.dart';

@immutable
sealed class ContentState {}

final class ContentInitial extends ContentState {}

final class AddContentLoading extends ContentState {}

final class AddContentSuccess extends ContentState {}

final class AddContentFailure extends ContentState {}


final class GetContentLoading extends ContentState {}

final class GetContentSuccess extends ContentState {}

final class GetContentFailure extends ContentState {}

final class DeleteContentLoading extends ContentState {}

final class DeleteContentSuccess extends ContentState {}

final class DeleteContentFailure extends ContentState {}

final class UpdateContentLoading extends ContentState {}

final class UpdateContentSuccess extends ContentState {}

final class UpdateContentFailure extends ContentState {}

