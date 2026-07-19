import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  final RxBool submitted = false.obs;

  final _emailRegex = RegExp(r'^[\w.+-]+@[\w-]+\.[a-zA-Z]{2,}$');

  void submit() {
    if (emailController.text.trim().isEmpty || !_emailRegex.hasMatch(emailController.text.trim())) {
      Get.snackbar(
        'CHECK YOUR EMAIL',
        'Enter a valid email address to join the list.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    submitted.value = true;
    nameController.clear();
    emailController.clear();
    messageController.clear();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
