import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_checker/core/utils/app_constant.dart';
import 'package:ip_checker/core/utils/app_util.dart';
import 'package:ip_checker/features/ip_checker/cubit/ip_checker_cubit.dart';
import 'package:ip_checker/features/ip_checker/cubit/ip_checker_state.dart';
import 'package:ip_checker/features/ip_checker/view/widgets/disabled_widget.dart';
import 'package:ip_checker/features/ip_checker/view/widgets/submit_button.dart';
import 'package:ip_checker/common/widgets/custom_textfield.dart';

/// `SearchSubmit` is a `StatefulWidget` responsible for handling IP address search submission.
class SearchSubmit extends StatefulWidget {
  const SearchSubmit({super.key});

  @override
  State<SearchSubmit> createState() => _SearchSubmitState();
}

class _SearchSubmitState extends State<SearchSubmit> {
  // Private controller used for interacting with the IP textField
  late TextEditingController _ipTextController;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  // Initializes data and sets up the IP address text controller.
  // Retrieves current device's IP address using NetworkInfoService.
  // Checks if the current widget is attached to the widget tree and IP address is not null,
  // then displays the IP address in textField and sends a request to get IP address information.
  Future<void> _initData() async {
    _ipTextController = TextEditingController();
    var myIPAddress = await context.read<IPCheckerCubit>().getMyPublicIP;
    AppUtil.debugPrint(myIPAddress);
    if (context.mounted && !AppUtil.checkIsNull(myIPAddress)) {
      _ipTextController.text = myIPAddress!;
      _onSubmit(myIPAddress);
    }
  }

  // dispose textField controller to prevent memory leak
  @override
  void dispose() {
    super.dispose();
    _ipTextController.dispose();
  }

  // Dynamically builds the widget based on the screen width and state of IPCheckerCubit.
  // If width of current device's screen is equal to or bigger than minimum Ipad screen,
  // then width of the card is set to equal to total width/2.
  // If the state is in a loading state, builds disabled widget (non-interactive).
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    if (screenSize.width >= AppConstant.minIpadScreenSizeWidth) {
      width = screenSize.width / 2;
    }

    return SizedBox(
      width: width,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: BlocBuilder<IPCheckerCubit, IPCheckerState>(
            builder: (context, state) {
              if (state.status == IPCheckerStatus.loading) {
                return DisabledWidget(disabled: true, child: _buildWidget());
              }
              return _buildWidget();
            },
          ),
        ),
      ),
    );
  }

  // Builds the widget containing the IP address search input field and submit button.
  Widget _buildWidget() {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            onSubmitted: _onSubmit,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            controller: _ipTextController,
            hintText: "Search for any IP address or domain",
          ),
        ),
        SubmitButton(
          onTap: () => _onSubmit(_ipTextController.text),
        ),
      ],
    );
  }

  // Handles the IP address submission by triggering the IPCheckerCubit to fetch the IP address information.
  Future<void> _onSubmit(String ip) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (AppUtil.checkIsNull(ip)) {
      AppUtil.showSnackBar(context, "Please enter IP address");
      return;
    }
    await context.read<IPCheckerCubit>().getIPInfo(ip);
  }
}
