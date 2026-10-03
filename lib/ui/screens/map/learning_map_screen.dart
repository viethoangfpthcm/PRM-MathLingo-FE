import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../state/app_state.dart';
import '../lesson/interactive_lesson_screen.dart';

class LearningMapScreen extends StatelessWidget {
  final AppState appState;

  const LearningMapScreen({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 12,
            bottom: 110,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                children: [
                  _buildUnitHeaderBanner(context),
                  const SizedBox(height: 16),
                  _buildDailyChallengeCard(context),
                  const SizedBox(height: 12),
                  _buildSinuousLearningPath(context),
                ],
              ),
            ),
          ),
        ),

        // Floating Quick-Action Pills at Bottom-Right
        Positioned(
          right: 16,
          bottom: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Ask Owl Camera Solve Button
              _buildFloatingActionPill(
                context,
                icon: Icons.photo_camera_rounded,
                iconBg: AppColors.secondaryFixed,
                iconColor: AppColors.secondary,
                title: 'Hỏi Cú giải toán ✨',
                subtitle: 'Chụp ảnh đề khó',
                bgColor: AppColors.surfaceContainerLowest,
                shadowColor: AppColors.surfaceDim,
                onTap: () {
                  _showCameraTutorModal(context);
                },
              ),
              const SizedBox(height: 10),
              // Weekly Tournament League Badge
              _buildFloatingActionPill(
                context,
                icon: Icons.emoji_events_rounded,
                iconBg: AppColors.secondaryContainer,
                iconColor: AppColors.onSecondaryContainer,
                title: 'Hạng Vàng 🏆',
                subtitle: 'Top 3 • 420đ',
                bgColor: AppColors.secondaryContainer,
                shadowColor: AppColors.secondaryShadow,
                textColor: AppColors.onSecondaryContainer,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('🏆 Bé đang đứng Top 3 Bảng Vàng tuần này! Tiếp tục phát huy nhé!'),
                      backgroundColor: AppColors.secondaryShadow,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUnitHeaderBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primaryContainer,
            AppColors.primaryFixedDim,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: AppColors.primaryShadow,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.menu_book_rounded, size: 14, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      'LỚP 3 • TUẦN 4',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.onPrimaryContainer.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.offline_pin_rounded, size: 14, color: AppColors.primaryFixed),
                    SizedBox(width: 4),
                    Text(
                      'Đã tải offline',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryFixed,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Chương 2: Phép nhân & Thừa số kỳ thú',
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Chinh phục bảng cửu chương cùng Cú Thông Thái',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryFixed,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.onPrimaryContainer.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Tiến độ chặng',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      '12 / 24 ⭐',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        color: AppColors.secondaryFixed,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(9999),
                  child: Container(
                    height: 10,
                    color: Colors.white.withValues(alpha: 0.25),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 160,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.secondaryContainer, AppColors.secondaryFixed],
                          ),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyChallengeCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceDim, width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: AppColors.surfaceDim,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.secondaryFixed.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Center(
              child: Icon(Icons.bolt_rounded, color: AppColors.secondary, size: 26),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'NHIỆM VỤ HÔM NAY',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: AppColors.secondary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primaryFixed.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: const Text(
                        '+40 XP',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                const Text(
                  'Hoàn thành 2 bài toán bảng nhân 3',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.onSurface),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.outline),
        ],
      ),
    );
  }

  Widget _buildSinuousLearningPath(BuildContext context) {
    return Column(
      children: [
        // Node 1: Completed (Offset Right)
        _buildCompletedNode(
          context,
          title: '1. Bảng nhân 3',
          stars: 3,
          horizontalAlignment: 0.5,
        ),
        const SizedBox(height: 24),

        // Node 2: Completed (Offset Left)
        _buildCompletedNode(
          context,
          title: '2. Đếm nhảy thừa số',
          stars: 2,
          horizontalAlignment: -0.5,
        ),
        const SizedBox(height: 28),

        // Node 3: ACTIVE NODE WITH OWL MASCOT SPEECH BUBBLE & PULSE
        _buildActiveNode(context),
        const SizedBox(height: 28),

        // Node 4: Milestone Treasure Chest (Offset Right)
        _buildTreasureNode(context, horizontalAlignment: 0.55),
        const SizedBox(height: 24),

        // Node 5: Practice (Offset Left - Locked)
        _buildLockedNode(
          title: 'Bài 4: Luyện tập phép nhân',
          icon: Icons.fitness_center_rounded,
          horizontalAlignment: -0.4,
        ),
        const SizedBox(height: 24),

        // Node 6: Word Problem (Offset Right - Locked)
        _buildLockedNode(
          title: 'Bài 5: Đố vui chia kẹo',
          icon: Icons.psychology_rounded,
          horizontalAlignment: 0.45,
        ),
        const SizedBox(height: 28),

        // Node 7: Boss Challenge (Center)
        _buildBossNode(context),
        const SizedBox(height: 28),

        // Chapter 3 Gateway Divider
        _buildChapterGatewayDivider(),
        const SizedBox(height: 20),

        // Node 8: Chapter 3 Starter (Offset Left - Locked)
        _buildLockedNode(
          title: '1. Làm quen phép chia',
          icon: Icons.lock_outline_rounded,
          horizontalAlignment: -0.45,
        ),
      ],
    );
  }

  Widget _buildCompletedNode(
    BuildContext context, {
    required String title,
    required int stars,
    required double horizontalAlignment,
  }) {
    return Align(
      alignment: Alignment(horizontalAlignment, 0),
      child: Column(
        children: [
          // Stars pill above
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(color: AppColors.surfaceDim),
              boxShadow: const [
                BoxShadow(color: AppColors.surfaceDim, offset: Offset(0, 2)),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                final isLit = i < stars;
                return Icon(
                  Icons.star_rounded,
                  size: 15,
                  color: isLit ? AppColors.secondaryContainer : AppColors.outlineVariant,
                );
              }),
            ),
          ),
          const SizedBox(height: 6),
          // 3D Emerald Button
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: AppColors.primaryShadow,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 58,
                height: 58,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded, color: Colors.white, size: 34),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.surfaceDim),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Rubik',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveNode(BuildContext context) {
    return Column(
      children: [
        // Speech Bubble from Owl
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.surfaceDim),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A07006C),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('🦉 ', style: TextStyle(fontSize: 16)),
              Text(
                'Cùng làm bài kéo thả nào! 🎯',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Glowing Active Button with Owl Mascot
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Ambient outer glow
            Container(
              width: 105,
              height: 105,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryFixedDim.withValues(alpha: 0.3),
              ),
            ),
            // Tactile 3D Play Node
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => InteractiveLessonScreen(appState: appState),
                  ),
                );
              },
              child: Container(
                width: 86,
                height: 86,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryFixed, AppColors.primaryContainer],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.primaryShadow,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.play_arrow_rounded, color: AppColors.onPrimaryContainer, size: 40),
                      Text(
                        'BẮT ĐẦU',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: AppColors.onPrimaryContainer,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Node Title Tag
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(9999),
            boxShadow: const [
              BoxShadow(color: AppColors.primaryShadow, offset: Offset(0, 3)),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.fiber_manual_record, color: AppColors.primaryFixed, size: 10),
              SizedBox(width: 6),
              Text(
                'Bài 3: Thừa số & Tích',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTreasureNode(BuildContext context, {required double horizontalAlignment}) {
    return Align(
      alignment: Alignment(horizontalAlignment, 0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(9999),
              boxShadow: const [
                BoxShadow(color: AppColors.secondaryShadow, offset: Offset(0, 2)),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.lock_rounded, color: Colors.white, size: 12),
                SizedBox(width: 4),
                Text(
                  '+50 Ngọc',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.secondaryFixed,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(color: AppColors.secondaryShadow, offset: Offset(0, 6)),
              ],
            ),
            child: Center(
              child: Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(Icons.card_giftcard_rounded, color: AppColors.onSecondaryContainer, size: 34),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.surfaceDim),
            ),
            child: const Text(
              'Rương Kho Báu',
              style: TextStyle(fontFamily: 'Rubik', fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.secondary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLockedNode({
    required String title,
    required IconData icon,
    required double horizontalAlignment,
  }) {
    return Align(
      alignment: Alignment(horizontalAlignment, 0),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(color: AppColors.outlineVariant, offset: Offset(0, 4)),
              ],
            ),
            child: Center(
              child: Container(
                width: 46,
                height: 46,
                decoration: const BoxDecoration(
                  color: AppColors.surfaceDim,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.outline, size: 22),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              title,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.outline),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBossNode(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.tertiary,
            borderRadius: BorderRadius.circular(9999),
            boxShadow: const [
              BoxShadow(color: AppColors.tertiaryShadow, offset: Offset(0, 2)),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 14),
              SizedBox(width: 4),
              Text(
                'Trùm Chương',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(color: AppColors.outlineVariant, offset: Offset(0, 6)),
            ],
          ),
          child: Center(
            child: Container(
              width: 58,
              height: 58,
              decoration: const BoxDecoration(
                color: AppColors.surfaceDim,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.military_tech_rounded, color: AppColors.outline, size: 34),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Thử thách Trùm Chương 2',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.outline),
          ),
        ),
      ],
    );
  }

  Widget _buildChapterGatewayDivider() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(9999),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.4), width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.lock_open_rounded, color: AppColors.primary, size: 16),
          SizedBox(width: 6),
          Flexible(
            child: Text(
              'MỞ KHÓA: CHƯƠNG 3 - PHÉP CHIA BÍ ẨN',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: AppColors.onSurfaceVariant,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionPill(
    BuildContext context, {
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Color bgColor,
    required Color shadowColor,
    Color textColor = AppColors.onSurface,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(9999),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              child: Center(child: Icon(icon, color: iconColor, size: 18)),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: textColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: textColor.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCameraTutorModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceContainerLowest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.secondaryFixed,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.camera_alt_rounded, color: AppColors.secondary, size: 32),
            ),
            const SizedBox(height: 16),
            const Text(
              'Hỏi Cú Giải Toán (AI Camera) 📸',
              style: TextStyle(fontFamily: 'Rubik', fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text(
              'Chụp ảnh bài toán trong sách vở. Cú Mathy sẽ hướng dẫn bé từng bước giải theo phương pháp gợi mở Socratic mà không đưa đáp án ngay!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: AppColors.onSurfaceVariant, height: 1.4),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('📷 Đang mô phỏng camera nhận diện bài toán...'),
                    backgroundColor: AppColors.primaryContainer,
                  ),
                );
              },
              icon: const Icon(Icons.photo_camera),
              label: const Text('Chụp Ảnh Thử Nghiệm'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryContainer,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
