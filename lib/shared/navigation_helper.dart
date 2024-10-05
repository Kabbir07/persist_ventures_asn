import 'package:get/get.dart';

void goNextPage(page) {
  Get.to(page, transition: Transition.rightToLeft, duration: 500.milliseconds);
}
