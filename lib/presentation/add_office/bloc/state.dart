import 'package:equatable/equatable.dart';
import 'package:office_staff_management/data/dto/office.dart';
import 'package:uuid/uuid.dart';

abstract class StaffState extends Equatable {
  @override
  List<Object> get props => [];
}

class AddStaffState extends StaffState {
  int selectedColorIndex;
  int avtarIndex;

  AddStaffState(this.selectedColorIndex, this.avtarIndex);

  @override
  List<Object> get props => [selectedColorIndex];

  AddStaffState copyWith({
    required final int selectedIndex,
    required final int avtarIndex,
  }) {
    return AddStaffState(selectedIndex, avtarIndex);
  }

  factory AddStaffState.initial() {
    return AddStaffState(0, -1);
  }
}

class PutStaffState extends StaffState {
  final Office officeDto;

  PutStaffState(this.officeDto);

  @override
  List<Object> get props => [officeDto];

  PutStaffState copyWith({required final Office officeDto}) {
    return PutStaffState(officeDto);
  }

  factory PutStaffState.initial() {
    return PutStaffState(
      Office(
        id: const Uuid().v4(),
        officeName: "",
        noOfStaff: 0,
        officeNumber: "",
        officeEmail: "",
        officeCapacity: 0,
        officeAddress: "",
        officeCardColor: 0,
      ),
    );
  }
}
