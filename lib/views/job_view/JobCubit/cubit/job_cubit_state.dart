part of 'job_cubit_cubit.dart';

@immutable
sealed class JobCubitState {}

final class JobCubitInitial extends JobCubitState {}

final class GetJobLoading extends JobCubitState {}

final class GetJobSuccess extends JobCubitState {}

final class GetJobError extends JobCubitState {}

final class AddJobError extends JobCubitState {}

final class AddJobLoading extends JobCubitState {}

final class AddJobsuccses extends JobCubitState {}
