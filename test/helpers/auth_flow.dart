import 'package:donuts/app/di/auth_module.dart';
import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/auth/domain/usecases/register_use_case.dart';
import 'package:donuts/features/auth/domain/usecases/request_otp_use_case.dart';
import 'package:donuts/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

import 'fakes.dart';

/// Mocked auth use cases, registered on [getIt] the way the app's auth
/// module registers the real ones.
class AuthFlowMocks {
  final MockRequestOtpUseCase requestOtp = MockRequestOtpUseCase();
  final MockVerifyOtpUseCase verifyOtp = MockVerifyOtpUseCase();
  final MockRegisterUseCase register = MockRegisterUseCase();

  Future<void> install() async {
    await getIt.reset();
    when(() => requestOtp(any())).thenAnswer((_) async => const Success(null));
    getIt
      ..registerSingleton<RequestOtpUseCase>(requestOtp)
      ..registerSingleton<VerifyOtpUseCase>(verifyOtp)
      ..registerSingleton<RegisterUseCase>(register)
      ..registerSingleton<DateTime Function()>(() => DateTime(2026, 11, 12));
    registerAuthStepCubits(getIt);
  }
}

/// Unmounts the app so cubit timers stop before the test ends.
Future<void> unmountApp(WidgetTester tester) =>
    tester.pumpWidget(const SizedBox.shrink());
