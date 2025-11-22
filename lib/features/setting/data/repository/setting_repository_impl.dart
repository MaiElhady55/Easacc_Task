
import 'package:easacc_task/features/setting/data/data_source/remote/setting_remote_data_source.dart';
import 'package:easacc_task/features/setting/data/repository/setting_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SettingRepository)
class SettingRepositoryImpl extends SettingRepository {
  final SettingRemoteDataSource settingRemoteDataSource;
  SettingRepositoryImpl({required this.settingRemoteDataSource});

  
}
