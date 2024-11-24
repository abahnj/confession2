import 'package:confession/domain/datasources/local_storage_datasource.dart';
import 'package:confession/domain/dtos/models/user_domain_model.dart';

abstract class UserLocalDataSource
    extends LocalStorageEntity<UserDomainModel> {}
