import 'package:equatable/equatable.dart';
import 'package:office_staff_management/data/dto/office.dart';
import 'package:uuid/uuid.dart';

abstract class StaffState extends Equatable {
  @override
  List<Object> get props => [];
}

class AddOfficeState extends StaffState {
  int selectedIndex;
  int avtarIndex;

  AddOfficeState(this.selectedIndex, this.avtarIndex);

  @override
  List<Object> get props => [selectedIndex];

  AddOfficeState copyWith(
      {required final int selectedIndex, required final int avtarIndex}) {
    return AddOfficeState(selectedIndex, avtarIndex);
  }

  factory AddOfficeState.initial() {
    return AddOfficeState(0, -1);
  }
}

class PutOfficeState extends StaffState {
  final Office selectedIndex;

  PutOfficeState(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];

  PutOfficeState copyWith({required final Office selectedIndex}) {
    return PutOfficeState(
      selectedIndex,
    );
  }

  factory PutOfficeState.initial() {
    return PutOfficeState(Office(
        id: const Uuid().v4(),
        companyName: "companyName",
        noOfEmployee: 0,
        companyNumber: "companyNumber",
        companyEmail: "companyEmail",
        companyCapacity: 0,
        companyAddress: "companyAddress",
        companyCardColor: 1));
  }
}
