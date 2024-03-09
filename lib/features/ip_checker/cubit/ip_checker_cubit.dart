import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_checker/core/exception/exception.dart';
import 'package:ip_checker/core/services/network_info_service.dart';
import 'package:ip_checker/core/utils/app_util.dart';
import 'package:ip_checker/features/ip_checker/cubit/ip_checker_state.dart';
import 'package:ip_checker/features/ip_checker/repository/ip_repository.dart';

class IPCheckerCubit extends Cubit<IPCheckerState> {
  final IPRepository _ipRepository;
  IPCheckerCubit({required IPRepository ipRepository})
      : _ipRepository = ipRepository,
        super(const IPCheckerState());

  Future<void> getIPInfo(String ip) async {
    try {
      if (state.status == IPCheckerStatus.loading || AppUtil.checkIsNull(ip)) {
        return;
      }
      emit(const IPCheckerState(status: IPCheckerStatus.loading));
      final response = await _ipRepository.getIPInfo(ip.trim());
      emit(IPCheckerState(status: IPCheckerStatus.success, ipInfo: response));
    } on BaseException catch (e) {
      emit(IPCheckerState(status: IPCheckerStatus.error, message: e.message));
    } catch (e) {
      emit(
          IPCheckerState(status: IPCheckerStatus.error, message: e.toString()));
    }
  }

  Future<String?> get getMyPublicIP async =>
      await NetworkInfoService.myPublicIP;
}
