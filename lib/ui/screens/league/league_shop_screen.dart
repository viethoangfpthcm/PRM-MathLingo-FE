import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../state/app_state.dart';
import '../../widgets/tactile_button.dart';

class LeagueShopScreen extends StatefulWidget {
  final AppState appState;

  const LeagueShopScreen({super.key, required this.appState});

  @override
  State<LeagueShopScreen> createState() => _LeagueShopScreenState();
}

class _LeagueShopScreenState extends State<LeagueShopScreen> {
  int _tabIndex = 0; // 0: Đấu Trường, 1: Cửa Hàng Sao

  final List<Map<String, dynamic>> _leaderboard = [
    {'rank': 1, 'name': 'Hoàng Long', 'avatar': '🦁', 'xp': 510, 'badge': '🥇'},
    {'rank': 2, 'name': 'Bảo Anh', 'avatar': '🦊', 'xp': 465, 'badge': '🥈'},
    {'rank': 3, 'name': 'Minh Khôi', 'avatar': '👦', 'xp': 420, 'badge': '🥉', 'isUser': true},
    {'rank': 4, 'name': 'Thảo My', 'avatar': '🐰', 'xp': 390, 'badge': ''},
    {'rank': 5, 'name': 'Tuấn Kiệt', 'avatar': '🐼', 'xp': 360, 'badge': ''},
    {'rank': 6, 'name': 'Gia Huy', 'avatar': '🐯', 'xp': 310, 'badge': ''},
  ];

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
              // Segmented Switcher
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _tabIndex = 0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _tabIndex == 0 ? AppColors.secondaryContainer : Colors.transparent,
                            borderRadius: BorderRadius.circular(9999),
                            boxShadow: _tabIndex == 0
                                ? const [BoxShadow(color: AppColors.secondaryShadow, offset: Offset(0, 3))]
                                : null,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.leaderboard_rounded,
                                size: 18,
                                color: _tabIndex == 0 ? AppColors.onSecondaryContainer : AppColors.onSurfaceVariant,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Đấu Trường Hạng Vàng',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: _tabIndex == 0 ? AppColors.onSecondaryContainer : AppColors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _tabIndex = 1),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _tabIndex == 1 ? AppColors.primaryContainer : Colors.transparent,
                            borderRadius: BorderRadius.circular(9999),
                            boxShadow: _tabIndex == 1
                                ? const [BoxShadow(color: AppColors.primaryShadow, offset: Offset(0, 3))]
                                : null,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.storefront_rounded,
                                size: 18,
                                color: _tabIndex == 1 ? Colors.white : AppColors.onSurfaceVariant,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Cửa Hàng Sao',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: _tabIndex == 1 ? Colors.white : AppColors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              if (_tabIndex == 0)
                _buildLeaderboardView()
              else
                _buildShopView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeaderboardView() {
    return Column(
      children: [
        // Trophy Banner
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.secondaryContainer, AppColors.secondaryFixedDim],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(color: AppColors.secondaryShadow, offset: Offset(0, 6)),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text('🏆', style: TextStyle(fontSize: 32)),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Bảng Đấu Hạng Vàng 👑',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: AppColors.onSecondaryContainer,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Top 5 bạn đứng đầu tuần này sẽ được thăng hạng lên Hạng Kim Cương!',
                      style: TextStyle(fontSize: 12, color: AppColors.onSecondaryContainer, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Leaderboard List
        ..._leaderboard.map((item) {
          final isUser = item['isUser'] == true;

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: isUser ? AppColors.surfaceContainerLow : AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isUser ? AppColors.primaryContainer : AppColors.surfaceDim,
                width: isUser ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: isUser ? AppColors.primaryShadow : AppColors.surfaceDim,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Text(
                    item['badge'] != '' ? item['badge'] : '#${item['rank']}',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: item['badge'] != '' ? 18 : 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onSurface,
                    ),
                  ),
                ),
                Text(item['avatar'], style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 10),
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        item['name'],
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 14,
                          fontWeight: isUser ? FontWeight.w900 : FontWeight.w700,
                          color: isUser ? AppColors.primary : AppColors.onSurface,
                        ),
                      ),
                      if (isUser) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer,
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: const Text(
                            'BẠN',
                            style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Text(
                  '${item['xp']} XP',
                  style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildShopView() {
    return Column(
      children: [
        _buildShopItem(
          icon: '❤️',
          title: 'Nạp Đầy 5 Tim Ngay',
          desc: 'Hồi phục sinh lực tức thì để tiếp tục hành trình',
          cost: 100,
          onBuy: () {
            widget.appState.refillHearts();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('❤️ Đã nạp đầy 5 tim thành công!'),
                backgroundColor: AppColors.primaryContainer,
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildShopItem(
          icon: '⚡',
          title: 'Thần Dược x2 XP',
          desc: 'Nhân đôi điểm kinh nghiệm trong 30 phút học tập',
          cost: 150,
          onBuy: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('⚡ Đã kích hoạt Thần Dược x2 XP trong 30 phút!'),
                backgroundColor: AppColors.secondaryShadow,
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildShopItem(
          icon: '🛡️',
          title: 'Khiên Đóng Băng Chuỗi Ngày',
          desc: 'Bảo vệ chuỗi ngọn lửa streak không bị đứt đoạn nếu bé quên vào học 1 ngày',
          cost: 200,
          onBuy: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('🛡️ Khiên bảo vệ Streak đã sẵn sàng kích hoạt!'),
                backgroundColor: AppColors.primaryContainer,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildShopItem({
    required String icon,
    required String title,
    required String desc,
    required int cost,
    required VoidCallback onBuy,
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
              Text(icon, style: const TextStyle(fontSize: 32)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontFamily: 'Rubik', fontSize: 14, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      desc,
                      style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TactileButton.secondary(
            onPressed: onBuy,
            height: 44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star_rounded, size: 18),
                const SizedBox(width: 4),
                Text('ĐỔI VỚI $cost SAO'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
