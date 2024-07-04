part of 'office_bloc.dart';

@immutable
sealed class OfficeState extends Equatable {}

final class OfficeInitial extends OfficeState {
  @override
  List<Object?> get props => [];
}

final class OfficeLoading extends OfficeState {
  @override
  List<Object?> get props => [];
}

final class OfficeSuccess extends OfficeState {
  final List<Office> list;

  OfficeSuccess({required this.list});

  @override
  List<Object?> get props => [list];
}

final class OfficeFailure extends OfficeState {
  final String? message;

  OfficeFailure({this.message});

  @override
  List<Object?> get props => [message];
}
