import 'package:flutter/material.dart';
import 'package:ip_checker/core/utils/app_constant.dart';
import 'package:ip_checker/features/ip_checker/model/ip_info.dart';
import 'package:ip_checker/common/widgets/custom_card.dart';

class IPInfoResultCard extends StatelessWidget {
  const IPInfoResultCard({super.key, required this.ipInfo});

  final IpInfo ipInfo;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width >= AppConstant.minIpadScreenSizeWidth) {
      width = width * .8;
    }

    return CustomCard(
      width: width - 40,
      padding: const EdgeInsets.all(15),
      child: _buildWidget(context),
    );
  }

  Widget _buildWidget(context) {
    Widget ipItem = _InfoItem(label: "IP", value: ipInfo.ip);
    Widget locationItem = _InfoItem(
        label: "LOCATION",
        value:
            '${ipInfo.ipLocation.city}, ${ipInfo.ipLocation.region} ${ipInfo.ipLocation.postalCode}');
    Widget timeZoneItem =
        _InfoItem(label: "TIME ZONE", value: ipInfo.ipLocation.timezone);
    Widget ispItem = _InfoItem(label: "ISP", value: ipInfo.isp);
    return MediaQuery.of(context).size.width >=
            AppConstant.minIpadScreenSizeWidth
        ? IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(fit: FlexFit.tight, child: ipItem),
                const VerticalDivider(),
                Flexible(fit: FlexFit.tight, child: locationItem),
                const VerticalDivider(),
                Flexible(fit: FlexFit.tight, child: timeZoneItem),
                const VerticalDivider(),
                Flexible(fit: FlexFit.tight, child: ispItem),
              ],
            ),
          )
        : Column(children: [ipItem, locationItem, timeZoneItem, ispItem]);
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    var crossAxisAlignment =
        MediaQuery.of(context).size.width >= AppConstant.minIpadScreenSizeWidth
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
