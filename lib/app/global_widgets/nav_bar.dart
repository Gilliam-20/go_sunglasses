import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/repositories/bag_service.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'go_mark.dart';
import 'responsive.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final bool transparent;
  final bool light;

  const NavBar({super.key, this.transparent = false, this.light = false});

  @override
  Size get preferredSize => const Size.fromHeight(88);

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final fg = light ? AppColors.bone : AppColors.ink;

    return Container(
      width: double.infinity,
      color: transparent ? Colors.transparent : (light ? AppColors.ink : AppColors.bone),
      padding: EdgeInsets.symmetric(horizontal: Responsive.gutter(context)),
      height: 88,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.offAllNamed(Routes.home),
            child: GoMark(size: 24, light: light),
          ),
          const Spacer(),
          if (isDesktop) ..._navLinks(fg),
          if (isDesktop) const SizedBox(width: 36),
          _BagIcon(color: fg),
          if (!isDesktop) ...[
            const SizedBox(width: 20),
            _MobileMenuButton(color: fg),
          ],
        ],
      ),
    );
  }

  List<Widget> _navLinks(Color color) {
    final links = <String, String>{
      'SHOP': Routes.collection,
      'FIND YOUR FIT': Routes.findYourFit,
      'LOOKBOOK': Routes.lookbook,
      'ABOUT': Routes.about,
      'CONTACT': Routes.contact,
    };
    return links.entries
        .map((e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: _NavLink(label: e.key, route: e.value, color: color),
            ))
        .toList();
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final String route;
  final Color color;
  const _NavLink({required this.label, required this.route, required this.color});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: () => Get.toNamed(widget.route),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _hovering ? AppColors.signal : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(widget.label, style: AppTypography.kinetic(color: widget.color, size: 11)),
        ),
      ),
    );
  }
}

class _BagIcon extends StatelessWidget {
  final Color color;
  const _BagIcon({required this.color});

  @override
  Widget build(BuildContext context) {
    final bag = BagService.to;
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.bag),
      child: Obx(() {
        final count = bag.itemCount;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(Icons.shopping_bag_outlined, color: color, size: 24),
            if (count > 0)
              Positioned(
                right: -6,
                top: -6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: AppColors.signal, shape: BoxShape.circle),
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  child: Text(
                    '$count',
                    textAlign: TextAlign.center,
                    style: AppTypography.caption(color: AppColors.bone, size: 10),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  final Color color;
  const _MobileMenuButton({required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showMobileMenu(context),
      child: Icon(Icons.menu, color: color, size: 26),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.ink,
      builder: (context) {
        final links = <String, String>{
          'SHOP': Routes.collection,
          'FIND YOUR FIT': Routes.findYourFit,
          'LOOKBOOK': Routes.lookbook,
          'ABOUT': Routes.about,
          'CONTACT': Routes.contact,
          'BAG': Routes.bag,
        };
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: links.entries
                  .map((e) => ListTile(
                        title: Text(
                          e.key,
                          style: AppTypography.kinetic(color: AppColors.bone, size: 16),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed(e.value);
                        },
                      ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
