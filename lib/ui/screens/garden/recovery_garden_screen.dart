import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../state/app_state.dart';
import '../../widgets/tactile_button.dart';

class RecoveryGardenScreen extends StatefulWidget {
  final AppState appState;

  const RecoveryGardenScreen({super.key, required this.appState});

  @override
  State<RecoveryGardenScreen> createState() => _RecoveryGardenScreenState();
}

class _RecoveryGardenScreenState extends State<RecoveryGardenScreen> {
  int _selectedTabIndex = 0; // 0: Vườn Hồi Phục, 1: Tủ Đồ Cú Vọ

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Column(
            children: [
              _buildSegmentedSwitcher(),
              const SizedBox(height: 16),
              if (_selectedTabIndex == 0)
                _buildRecoveryGardenView()
              else
                _buildWardrobeView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSegmentedSwitcher() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTabIndex = 0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _selectedTabIndex == 0
                      ? AppColors.primaryContainer
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(9999),
                  boxShadow: _selectedTabIndex == 0
                      ? const [
                          BoxShadow(
                            color: AppColors.primaryShadow,
                            offset: Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_florist_rounded,
                      size: 18,
                      color: _selectedTabIndex == 0 ? Colors.white : AppColors.onSurfaceVariant,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Vườn Hồi Phục',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: _selectedTabIndex == 0 ? Colors.white : AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTabIndex = 1),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _selectedTabIndex == 1
                      ? AppColors.primaryContainer
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(9999),
                  boxShadow: _selectedTabIndex == 1
                      ? const [
                          BoxShadow(
                            color: AppColors.primaryShadow,
                            offset: Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.checkroom_rounded,
                      size: 18,
                      color: _selectedTabIndex == 1 ? Colors.white : AppColors.onSurfaceVariant,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Tủ Đồ Cú Vọ',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: _selectedTabIndex == 1 ? Colors.white : AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecoveryGardenView() {
    final kid = widget.appState.currentKid;

    return Column(
      children: [
        // Heart Recovery Banner
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.surfaceDim, width: 1.5),
            boxShadow: const [
              BoxShadow(color: AppColors.surfaceDim, offset: Offset(0, 6)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.tertiaryFixed,
                                borderRadius: BorderRadius.circular(9999),
                              ),
                              child: Text(
                                '❤️ Còn ${kid.hearts}/5 Tim',
                                style: const TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.tertiary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: const [
                                Icon(Icons.hourglass_top_rounded, color: AppColors.tertiary, size: 14),
                                SizedBox(width: 2),
                                Text(
                                  '12:45',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Luyện tập thư giãn!',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Học nhẹ nhàng không tính điểm phạt, hái hoa bắt sâu để nạp đầy 5 trái tim nhé!',
                          style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant, height: 1.3),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.tertiaryFixedDim.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.volunteer_activism_rounded, color: AppColors.tertiary, size: 36),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Quick Heart Meter
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(kid.maxHearts, (i) {
                        final isFull = i < kid.hearts;
                        return Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Icon(
                            Icons.favorite_rounded,
                            size: 20,
                            color: isFull ? AppColors.tertiary : AppColors.outlineVariant,
                          ),
                        );
                      }),
                    ),
                    const Text(
                      '+1 Tim mỗi bài xong',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Quest 1: Done
        _buildQuestCard(
          title: 'Tưới cây Bảng Nhân 2',
          desc: 'Đã phục hồi sinh lực mầm non',
          heartsText: '+1 ❤️',
          icon: Icons.shower_rounded,
          iconBg: AppColors.primaryFixed,
          iconColor: AppColors.primary,
          isCompleted: true,
          buttonText: 'Đã hoàn thành',
          onTap: null,
        ),
        const SizedBox(height: 12),

        // Quest 2: Active (+2 Hearts)
        _buildQuestCard(
          title: 'Bắt sâu Phép Trừ 🐛',
          desc: 'Trừ có nhớ vui nhộn với bọ rùa',
          heartsText: '+2 ❤️❤️',
          icon: Icons.pest_control_rounded,
          iconBg: AppColors.secondaryFixed,
          iconColor: AppColors.secondary,
          isCompleted: false,
          badgeText: 'Thử ngay',
          buttonText: 'Bắt đầu ngay',
          onTap: () {
            widget.appState.completeQuest('q-2');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('🎉 Bé đã hoàn thành bắt sâu phép trừ và được hồi phục +2 Tim ❤️!'),
                backgroundColor: AppColors.primaryContainer,
              ),
            );
          },
        ),
        const SizedBox(height: 12),

        // Quest 3: Fraction Flower (+2 Hearts)
        _buildQuestCard(
          title: 'Ghép hoa Phân Số 🌸',
          desc: 'Xếp cánh hoa 1/2 và 1/4 nhẹ nhàng',
          heartsText: '+2 ❤️❤️',
          icon: Icons.local_florist_rounded,
          iconBg: AppColors.surfaceVariant,
          iconColor: AppColors.primary,
          isCompleted: false,
          buttonText: 'Vào Vườn Hoa',
          onTap: () {
            widget.appState.completeQuest('q-3');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('🌸 Bé đã ghép thành công hoa phân số và nhận +2 Tim ❤️!'),
                backgroundColor: AppColors.secondaryShadow,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildQuestCard({
    required String title,
    required String desc,
    required String heartsText,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required bool isCompleted,
    required String buttonText,
    String? badgeText,
    VoidCallback? onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceDim, width: 1.5),
        boxShadow: const [
          BoxShadow(color: AppColors.surfaceDim, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 26),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppColors.onSurface,
                          ),
                        ),
                        if (badgeText != null) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryContainer,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              badgeText,
                              style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      desc,
                      style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.tertiaryFixed,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  heartsText,
                  style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: AppColors.tertiary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (isCompleted)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 18),
                  SizedBox(width: 6),
                  Text(
                    'Đã hoàn thành',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            )
          else
            TactileButton.primary(
              onPressed: onTap,
              height: 46,
              child: Text(buttonText),
            ),
        ],
      ),
    );
  }

  Widget _buildWardrobeView() {
    final kid = widget.appState.currentKid;

    return Column(
      children: [
        // Mascot Podium Stage
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.surfaceDim, width: 1.5),
            boxShadow: const [
              BoxShadow(color: AppColors.surfaceDim, offset: Offset(0, 6)),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainer,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: const Text(
                      'Level 4: Cú Con Học Giỏi 🎓',
                      style: TextStyle(fontFamily: 'Rubik', fontSize: 11, fontWeight: FontWeight.w800),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryFixed,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star_rounded, color: AppColors.secondary, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${kid.stars} Sao',
                          style: const TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 3D Mascot Character Display
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: AppColors.primaryFixedDim.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(color: AppColors.primaryShadow, offset: Offset(0, 8)),
                      ],
                    ),
                    child: const Center(
                      child: Text('🦉', style: TextStyle(fontSize: 60)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Text(
                'Linh Vật Cú Mathy',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: AppColors.onSurface,
                ),
              ),
              const Text(
                'Bé có thể đổi sao để mua trang phục độc quyền!',
                style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Wardrobe Items Grid
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.15,
          children: [
            _buildWardrobeItemCard('Mũ Cử Nhân 🎓', 'Đã trang bị', true, 0),
            _buildWardrobeItemCard('Kính Thần Đồng 👓', '150 Sao', false, 150),
            _buildWardrobeItemCard('Áo Choàng Siêu Nhân 🦸', '200 Sao', false, 200),
            _buildWardrobeItemCard('Cúp Vương Miện 👑', '300 Sao', false, 300),
          ],
        ),
      ],
    );
  }

  Widget _buildWardrobeItemCard(String name, String priceOrStatus, bool isEquipped, int cost) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isEquipped ? AppColors.primaryContainer : AppColors.surfaceDim,
          width: isEquipped ? 2 : 1,
        ),
        boxShadow: const [
          BoxShadow(color: AppColors.surfaceDim, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isEquipped ? AppColors.primaryFixed : AppColors.secondaryFixed,
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Text(
              priceOrStatus,
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: isEquipped ? AppColors.primary : AppColors.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
