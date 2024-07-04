import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_staff_management/presentation/add_office/bloc/state.dart';
import 'package:office_staff_management/presentation/utils/base_strings.dart';

import '../utils/base_colors.dart';
import '../utils/common_floating_action_button.dart';
import '../utils/loading_widget.dart';
import '../utils/routes.dart';
import 'bloc/office_bloc.dart';
import 'component/custom_office_card.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OfficeBloc>().add(GetAllOffices());
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        surfaceTintColor: BaseColors.backgroundColor,
        backgroundColor: BaseColors.backgroundColor,
      ),
      backgroundColor: BaseColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<PutStaffBloc, StaffState>(builder: (bContext, state) {
              if (state is StaffSuccess) {
                context.read<OfficeBloc>().add(GetAllOffices());
              }
              return Container();
            }),
            const Text(
              BaseStrings.allOfficesText,
              style: TextStyle(
                  fontFamily: BaseStrings.interFontFamily,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: BaseColors.textColor),
            ),
            BlocBuilder<OfficeBloc, OfficeState>(builder: (bContext, state) {
              if (state is OfficeLoading) {
                return const LoadingWidget();
              } else if (state is OfficeFailure) {
                return OfficeFailureWidget(message: BaseStrings.noOfficeAvailable);
              }
              return (state is OfficeSuccess)
                  ? state.list.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: state.list.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => CustomOfficeCard(
                                  officeDto: state.list[index],
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => OfficeDetailsScreen(
                                                  officeDto: state.list[index],
                                                )));
                                  },
                                  editIconTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => AddOfficeScreen(
                                                  isEdit: true,
                                                  officeDto: state.list[index],
                                                )));
                                  })),
                        )
                      : const Expanded(
                          child: Center(
                            child: Text(
                              BaseStrings.noOfficeAvailable,
                              style: TextStyle(
                                  fontFamily: BaseStrings.interFontFamily,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                  color: BaseColors.textColor),
                            ),
                          ),
                        )
                  : Container();
            }),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton(context, () {
        Navigator.of(context).pushNamed(Routes.addOfficeScreen);
      }),
    );
  }
}
