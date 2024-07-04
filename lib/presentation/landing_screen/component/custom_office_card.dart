import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:office_staff_management/data/dto/office.dart';
import 'package:office_staff_management/presentation/utils/base_colors.dart';

import '../../utils/base_assets.dart';
import '../../utils/base_strings.dart';

class CustomOfficeCard extends StatefulWidget {
  final Office? officeDto;
  final Function()? editIconTap;
  final Function()? onTap;

  const CustomOfficeCard({super.key, this.officeDto, this.editIconTap, this.onTap});

  @override
  State<CustomOfficeCard> createState() => _CustomOfficeCardState();
}

class _CustomOfficeCardState extends State<CustomOfficeCard> {
  final tileKey = GlobalKey();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: BaseColors.shadowColor, width: 1.0),
          borderRadius: BorderRadius.circular(8),
        ),
        color: BaseColors.whiteColor,
        borderOnForeground: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAnimatedGradientContainer(),
            _buildContentSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedGradientContainer() {
    return AnimatedContainer(
      width: 12,
      constraints: BoxConstraints(
        minHeight: isVisible ? 330 : 140,
        maxHeight: double.infinity,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        ),
        gradient: LinearGradient(
          colors: [
            colorPalette[widget.officeDto?.companyCardColor ?? 0],
            colorPalette[widget.officeDto?.companyCardColor ?? 0],
            colorPalette[widget.officeDto?.companyCardColor ?? 0].withOpacity(0.8),
            colorPalette[widget.officeDto?.companyCardColor ?? 0].withOpacity(0.8),
            colorPalette[widget.officeDto?.companyCardColor ?? 0].withOpacity(0.5),
            colorPalette[widget.officeDto?.companyCardColor ?? 0].withOpacity(0.5),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.35, 0.35, 0.7, 0.7, 1.0],
        ),
      ),
      duration: const Duration(milliseconds: 500),
    );
  }

  Widget _buildContentSection() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCompanyNameSection(),
            _buildEmployeeSection(),
            const Divider(color: BaseColors.iconColor),
            GestureDetector(
                onTap: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                child: _buildMoreInfoSection()),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyNameSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.officeDto?.companyName ?? "",
          style: const TextStyle(
            fontFamily: BaseStrings.interSemiBoldFontFamily,
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: BaseColors.textColor,
          ),
        ),
        GestureDetector(
          onTap: widget.editIconTap,
          child: SvgPicture.asset(BaseAssets.editIconSvg),
        ),
      ],
    );
  }

  Widget _buildEmployeeSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 12.0,
            ),
            child: SvgPicture.asset(BaseAssets.peopleIconSvg),
          ),
          RichText(
            text: TextSpan(
              text: "${widget.officeDto?.noOfEmployee}",
              style: const TextStyle(
                fontFamily: BaseStrings.interFontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: BaseColors.textColor,
              ),
              children: const [
                TextSpan(
                  text: BaseStrings.staffMembersInOfficeText,
                  style: TextStyle(
                    fontFamily: BaseStrings.interFontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: BaseColors.textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoreInfoSection() {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                BaseStrings.moreInfoText,
                style: TextStyle(
                  fontFamily: BaseStrings.interFontFamily,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: BaseColors.textColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: isVisible
                    ? SvgPicture.asset(BaseAssets.arrowUpIconSvg)
                    : SvgPicture.asset(BaseAssets.arrowDownIconSvg),
              )
            ],
          ),
          Visibility(
            visible: isVisible,
            maintainAnimation: true,
            maintainState: true,
            child: AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: isVisible ? 1 : 0,
              child: Column(
                children: [
                  _buildInfoRow(
                      BaseAssets.phoneIconSvg, widget.officeDto?.companyNumber ?? ""),
                  _buildInfoRow(
                      BaseAssets.emailIconSvg, widget.officeDto?.companyEmail ?? ""),
                  _buildInfoRow(BaseAssets.peopleIconSvg,
                      "Office Capacity: ${widget.officeDto?.companyCapacity}"),
                  _buildInfoRow(
                      BaseAssets.locationIconSvg, widget.officeDto?.companyAddress ?? ""),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String iconAsset, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SvgPicture.asset(iconAsset),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: BaseStrings.interSemiBoldFontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: BaseColors.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
