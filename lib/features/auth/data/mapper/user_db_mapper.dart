import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/features/auth/domain/params/registration_params.dart';
import 'package:donuts/features/auth/domain/vo/user_vo.dart';
import 'package:drift/drift.dart';

extension UsersTableDataMapper on UsersTableData {
  UserVO toVO() => UserVO(
    id: id,
    phone: phone,
    firstName: firstName,
    lastName: lastName,
    dateOfBirth: dateOfBirth,
  );
}

extension RegistrationParamsDbMapper on RegistrationParams {
  UsersTableCompanion toCompanion({required DateTime createdAt}) =>
      UsersTableCompanion.insert(
        phone: phone,
        firstName: firstName,
        lastName: Value(lastName),
        dateOfBirth: dateOfBirth,
        createdAt: createdAt,
      );
}
