import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global_widgets/go_button.dart';
import '../../../global_widgets/nav_bar.dart';
import '../../../global_widgets/responsive.dart';
import '../../../global_widgets/section_label.dart';
import '../../../global_widgets/site_footer.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';
import '../controllers/contact_controller.dart';

class ContactView extends GetView<ContactController> {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    final gutter = Responsive.gutter(context);
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      backgroundColor: AppColors.bone,
      appBar: const NavBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: gutter, vertical: 90),
              child: Builder(builder: (context) {
                final leftColumn = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SectionLabel(text: 'GET IN TOUCH'),
                    const SizedBox(height: 18),
                    Text('Join the\nList.', style: AppTypography.headline(size: 44)),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: isDesktop ? 380 : double.infinity,
                      child: Text(
                        'Early access to new drops, fitting notes, and the '
                        'occasional word from the studio. No noise.',
                        style: AppTypography.body(color: AppColors.ink.withOpacity(0.7)),
                      ),
                    ),
                    const SizedBox(height: 36),
                    Text('EMAIL', style: AppTypography.kinetic(size: 12, color: AppColors.steel)),
                    const SizedBox(height: 8),
                    Text('hello@go-eyewear.com', style: AppTypography.body(size: 15)),
                    const SizedBox(height: 20),
                    Text('STUDIO', style: AppTypography.kinetic(size: 12, color: AppColors.steel)),
                    const SizedBox(height: 8),
                    Text('Nairobi · Milan · Tokyo', style: AppTypography.body(size: 15)),
                  ],
                );

                final rightColumn = Obx(
                  () => controller.submitted.value ? const _ThankYou() : _Form(controller: controller),
                );

                if (isDesktop) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 4, child: leftColumn),
                      const SizedBox(width: 80),
                      Expanded(flex: 5, child: rightColumn),
                    ],
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [leftColumn, const SizedBox(height: 48), rightColumn],
                );
              }),
            ),
            const SiteFooter(),
          ],
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  final ContactController controller;
  const _Form({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel('NAME'),
        _TextField(controller: controller.nameController, hint: 'Your name'),
        const SizedBox(height: 24),
        _FieldLabel('EMAIL'),
        _TextField(controller: controller.emailController, hint: 'you@email.com'),
        const SizedBox(height: 24),
        _FieldLabel('MESSAGE (OPTIONAL)'),
        _TextField(controller: controller.messageController, hint: 'Anything on your mind', maxLines: 4),
        const SizedBox(height: 32),
        GoButton(label: 'SUBSCRIBE', onPressed: controller.submit),
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(text, style: AppTypography.kinetic(size: 11, color: AppColors.steel)),
    );
  }
}

class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  const _TextField({required this.controller, required this.hint, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: AppTypography.body(size: 15),
      cursorColor: AppColors.signal,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTypography.body(color: AppColors.steel, size: 15),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.steel)),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.signal, width: 1.4)),
      ),
    );
  }
}

class _ThankYou extends StatelessWidget {
  const _ThankYou();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      color: AppColors.boneSoft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('YOU\'RE ON THE LIST', style: AppTypography.kinetic(size: 14, color: AppColors.signal)),
          const SizedBox(height: 12),
          Text(
            'Thanks for signing up — keep an eye on your inbox for the SS26 drop.',
            style: AppTypography.body(),
          ),
        ],
      ),
    );
  }
}
