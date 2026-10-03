import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../state/app_state.dart';

class CurrencyShelfHeader extends StatelessWidget {
  final AppState appState;
  final VoidCallback? onProfileTap;

  const CurrencyShelfHeader({
    super.key,
    required this.appState,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    final kid = appState.currentKid;

    return Container(
      color: AppColors.surface.withValues(alpha: 0.92),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        bottom: 10,
        left: 16,
        right: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Brand Logo
          Row(
            children: [
              Text(
                'MathLingo',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                      fontSize: 22,
                    ),
              ),
            ],
          ),

          // Currency Badges
          Row(
            children: [
              // Streak 🔥
              _buildCurrencyPill(
                icon: Icons.local_fire_department_rounded,
                iconColor: AppColors.streakOrange,
                value: '${kid.streakDays}',
                textColor: AppColors.secondary,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('🔥 Bé đã học liên tiếp ${kid.streakDays} ngày! Cố lên nhé!'),
                      backgroundColor: AppColors.streakOrangeDark,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
              const SizedBox(width: 6),

              // Stars ⭐
              _buildCurrencyPill(
                icon: Icons.star_rounded,
                iconColor: AppColors.secondaryContainer,
                value: '${kid.stars}',
                textColor: AppColors.secondary,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('⭐ Bé có ${kid.stars} ngôi sao lấp lánh để đổi quà trong Cửa Hàng!'),
                      backgroundColor: AppColors.secondaryShadow,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
              const SizedBox(width: 6),

              // Hearts ❤️
              _buildCurrencyPill(
                icon: Icons.favorite_rounded,
                iconColor: AppColors.tertiaryContainer,
                value: '${kid.hearts}',
                textColor: AppColors.tertiary,
                onTap: () => _showHeartRefillDialog(context),
              ),
              const SizedBox(width: 8),

              // Profile Avatar
              GestureDetector(
                onTap: onProfileTap ?? () => _showProfileSwitcher(context),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.surfaceDim, width: 2),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.surfaceDim,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      kid.avatarEmoji,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyPill({
    required IconData icon,
    required Color iconColor,
    required String value,
    required Color textColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(color: AppColors.surfaceDim, width: 1),
          boxShadow: const [
            BoxShadow(
              color: AppColors.surfaceDim,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: iconColor),
            const SizedBox(width: 4),
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showHeartRefillDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceContainerLowest,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: const [
            Icon(Icons.favorite_rounded, color: AppColors.tertiary, size: 28),
            SizedBox(width: 8),
            Text('Năng Lượng Tim ❤️', style: TextStyle(fontWeight: FontWeight.w800)),
          ],
        ),
        content: Text(
          'Bé hiện có ${appState.currentKid.hearts}/${appState.currentKid.maxHearts} tim.\n'
          'Khi làm sai bài tập, bé sẽ bị trừ 1 tim.\n'
          'Bé có thể vào "Vườn Hồi Phục" để luyện tập thư giãn và nhận thêm tim!',
          style: const TextStyle(fontSize: 14, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () {
              appState.refillHearts();
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('✨ Đã nạp đầy 5 tim cho bé!'),
                  backgroundColor: AppColors.primaryContainer,
                ),
              );
            },
            child: const Text('Nạp Đầy 5 Tim (Demo)', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  void _showProfileSwitcher(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceContainerLowest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Chọn Hồ Sơ Học Sinh 🎒',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            ...appState.profiles.asMap().entries.map((entry) {
              final idx = entry.key;
              final p = entry.value;
              final isSelected = idx == appState.currentProfileIndex;

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.surfaceContainerLow : AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? AppColors.primaryContainer : AppColors.surfaceDim,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: ListTile(
                  leading: Text(p.avatarEmoji, style: const TextStyle(fontSize: 28)),
                  title: Text(
                    p.nickname,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: isSelected ? AppColors.primary : AppColors.onSurface,
                    ),
                  ),
                  subtitle: Text('Lớp ${p.grade} • 🔥 ${p.streakDays} ngày • ⭐ ${p.stars} sao'),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle_rounded, color: AppColors.primaryContainer)
                      : null,
                  onTap: () {
                    appState.switchProfile(idx);
                    Navigator.pop(ctx);
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
