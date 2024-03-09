import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_checker/core/services/storage_service.dart';
import 'package:ip_checker/core/utils/app_constant.dart';
import 'package:ip_checker/features/setting/cubit/cache/cache_state.dart';

class CacheCubit extends Cubit<CacheState> {
  CacheCubit() : super(const CacheState());

  Future<void> removeAll() async {
    emit(const CacheState(status: CacheStateStatus.loading));
    bool result = await StorageService.removeWithPrefix(AppConstant.cacheKey);
    if (result) {
      emit(const CacheState(
          status: CacheStateStatus.success, message: "Successfully cleared"));
    } else {
      emit(const CacheState(
          status: CacheStateStatus.error, message: "No data in cache"));
    }
  }
}
