import 'package:flutter/material.dart';
import 'package:ip_checker/core/utils/app_constant.dart';
import 'package:ip_checker/features/ip_checker/view/widgets/ip_info_card.dart';
import 'package:ip_checker/features/ip_checker/view/widgets/search_submit.dart';
import 'package:ip_checker/features/ip_checker/view/widgets/title_widget.dart';
import 'package:ip_checker/features/map/view/open_street_map_widget.dart';

import 'widgets/background_image.dart';

class IPChekerPage extends StatelessWidget {
  const IPChekerPage({super.key});

  final double _imgBGHeight = .35;
  final double _mapHeight = .65;
  final double _titlePosition = .07;
  final double _searchPosition = .13;
  final double _textFieldHeight = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    Size screenSize = MediaQuery.sizeOf(context);
    double infoCardMarginTop =
        screenSize.width >= AppConstant.minIpadScreenSizeWidth ? 40 : 20;
    return SingleChildScrollView(
      child: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: Stack(
          fit: StackFit.expand,
          alignment: AlignmentDirectional.topCenter,
          children: [
            BackgroundImage(
              width: screenSize.width,
              height: screenSize.height * _imgBGHeight,
            ),
            Positioned(
              top: screenSize.height * _titlePosition,
              child: const TitleWidget(),
            ),
            Positioned(
              top: screenSize.height * _searchPosition,
              child: const SearchSubmit(),
            ),
            Positioned(
              top: screenSize.height * _imgBGHeight,
              child: SizedBox(
                height: screenSize.height * _mapHeight,
                width: screenSize.width,
                child: const OpenStreetMapWidget(),
              ),
            ),
            Positioned(
              top: (screenSize.height * _searchPosition) +
                  _textFieldHeight +
                  infoCardMarginTop,
              child: const IPInfoCard(),
            ),
          ],
        ),
      ),
    );
  }
}
