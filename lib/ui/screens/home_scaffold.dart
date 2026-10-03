import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../state/app_state.dart';
import '../widgets/currency_shelf_header.dart';
import 'map/learning_map_screen.dart';
import 'garden/recovery_garden_screen.dart';
import 'league/league_shop_screen.dart';
import 'parent/parent_dashboard_screen.dart';
import 'parent/parent_gate_dialog.dart';

class HomeScaffold extends StatefulWidget {
  final AppState appState;

  const HomeScaffold({super.key, required this.appState});

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  int _currentNavIndex = 0;

  void _onSelectTab(int index) {
    if (index == 3) {
      // Parent Portal Gate check
      if (!widget.appState.isParentPortalUnlocked) {
        showDialog(
          context: context,
          builder: (ctx) => ParentGateDialog(
            onUnlocked: () {
              widget.appState.unlockParentPortal();
              setState(() => _currentNavIndex = 3);
            },
          ),
        );
        return;
      }
    }
    setState(() => _currentNavIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      LearningMapScreen(appState: widget.appState),
      RecoveryGardenScreen(appState: widget.appState),
      LeagueShopScreen(appState: widget.appState),
      ParentDashboardScreen(appState: widget.appState),
    ];

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Top Sticky Currency Shelf
            CurrencyShelfHeader(appState: widget.appState),
            // Current Screen Tab
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: screens[_currentNavIndex],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface.withValues(alpha: 0.95),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1207006C),
              blurRadius: 20,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Container(
            height: 68,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.map_rounded, 'Bản đồ'),
                _buildNavItem(1, Icons.yard_rounded, 'Hồi phục'),
                _buildNavItem(2, Icons.leaderboard_rounded, 'Đấu trường'),
                _buildNavItem(3, Icons.family_restroom_rounded, 'Phụ huynh'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentNavIndex == index;
    final color = isSelected ? AppColors.primaryContainer : AppColors.onSurfaceVariant;

    return GestureDetector(
      onTap: () => _onSelectTab(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        transform: isSelected ? Matrix4.diagonal3Values(1.08, 1.08, 1.0) : Matrix4.identity(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 26,
              color: color,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
