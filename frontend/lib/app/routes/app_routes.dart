import 'package:get/get.dart';

import '../views/umkm_form_page.dart';
import '../views/umkm_view.dart';

class AppRoutes {
  static const String umkmList = '/umkm';
  static const String umkmForm = '/umkm/add';

  static final List<GetPage<dynamic>> pages = [
    GetPage(name: umkmList, page: () => const UmkmView()),
    GetPage(name: umkmForm, page: () => const UmkmFormPage()),
  ];
}
