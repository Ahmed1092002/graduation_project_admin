part of 'admin_cubit.dart';

@immutable
sealed class AdminState {}

final class AdminInitial extends AdminState {}

final class AdminLoading extends AdminState {}

final class AdminLoaded extends AdminState {}

final class AdminError extends AdminState {}
final class GetAdminByIdLoading extends AdminState {}
final class GetAdminByIdLoaded extends AdminState {
  final AdminModel adminModel;
  GetAdminByIdLoaded(this.adminModel);
}
final class GetAdminByIdError extends AdminState {}
final class AddPersonLoading extends AdminState {}
final class AddPersonLoaded extends AdminState {
  final PersonModel personModel;
  AddPersonLoaded(this.personModel);
}
final class AddPersonError extends AdminState {}
final class AddUserLoading extends AdminState {}
final class AddUserLoaded extends AdminState {

}
final class AddUserError extends AdminState {}
final class AddAdminLoading extends AdminState {}
final class AddAdminLoaded extends AdminState {

}
final class AddAdminError extends AdminState {}
final class DeleteAdminLoading extends AdminState {}
final class DeleteAdminLoaded extends AdminState {

}
final class DeleteAdminError extends AdminState {}

