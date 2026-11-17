import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/controllers/umkm_controller.dart';
import 'app/routes/app_routes.dart';
import 'app/services/umkm_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const UmkmApp());
}

class UmkmApp extends StatelessWidget {
  const UmkmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'UMKM Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF176B5B),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7F6),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF5F7F6),
          foregroundColor: Color(0xFF153A33),
          elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFDCE5E1)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFDCE5E1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF176B5B), width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        ),
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(UmkmService(), permanent: true);
        Get.put(UmkmController(Get.find<UmkmService>()), permanent: true);
      }),
      initialRoute: AppRoutes.umkmList,
      getPages: AppRoutes.pages,
    );
  }
}
