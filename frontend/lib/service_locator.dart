import 'package:frontend/features/admin/data/repostiroy/admin_setting_repo.dart';
import 'package:frontend/features/admin/data/repostiroy/analytics_repo.dart';
import 'package:frontend/features/admin/data/service/admin_setting_service.dart';
import 'package:frontend/features/admin/data/service/analytics_service.dart';
import 'package:frontend/features/auth/data/repo/auth_repository.dart';
import 'package:frontend/features/auth/data/services/auth_services.dart';
import 'package:frontend/features/receptionist/data/repository/booking_repo.dart';
import 'package:frontend/features/receptionist/data/repository/inventory_repo.dart';
import 'package:frontend/features/receptionist/data/repository/receptionist_settings_repo.dart';
import 'package:frontend/features/receptionist/data/repository/receptionist_staff_repo.dart';
import 'package:frontend/features/receptionist/data/services/booking_service.dart';
import 'package:frontend/features/receptionist/data/services/inventory_service.dart';
import 'package:frontend/features/receptionist/data/services/receptionist_settings_service.dart';
import 'package:frontend/features/receptionist/data/services/receptionist_staff_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {

  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());

  getIt.registerLazySingleton<VehicleBookingServices>(() => VehicleBookingServices());
  getIt.registerLazySingleton<BookingRepository>(() => BookingRepository());

  getIt.registerLazySingleton<AdminSettingsService>(() => AdminSettingsService());
  getIt.registerLazySingleton<AdminSettingsRepository>(() => AdminSettingsRepository());

  getIt.registerLazySingleton<ReceptionistSettingsService>(() => ReceptionistSettingsService());
  getIt.registerLazySingleton<ReceptionistSettingsRepository>(() => ReceptionistSettingsRepository());

  getIt.registerLazySingleton<ReceptionistStaffService>(() => ReceptionistStaffService());
  getIt.registerLazySingleton<ReceptionistStaffRepository>(() => ReceptionistStaffRepository());

  getIt.registerLazySingleton<AnalyticsService>(() => AnalyticsService());
  getIt.registerLazySingleton<AnalyticsRepository>(() => AnalyticsRepository());

  getIt.registerLazySingleton<InventoryServices>(() => InventoryServices());
  getIt.registerLazySingleton<InventoryRepository>(() => InventoryRepository());

  // Services
  // getIt.registerLazySingleton<AuthService>(() => AuthService());
  // getIt.registerLazySingleton<VehicleBookingServices>(() => VehicleBookingServices());
  // getIt.registerLazySingleton<InventoryServices>(() => InventoryServices());
  // getIt.registerLazySingleton<ReceptionistStaffServices>(() => ReceptionistStaffServices());

  // You can also register Repositories here if you decide to use them later
}