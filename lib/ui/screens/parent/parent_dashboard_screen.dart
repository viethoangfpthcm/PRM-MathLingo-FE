import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/mock_data.dart';
import '../../../state/app_state.dart';
import 'parent_gate_dialog.dart';

class ParentDashboardScreen extends StatefulWidget {
  final AppState appState;

  const ParentDashboardScreen({super.key, required this.appState});

  @override
  State<ParentDashboardScreen> createState() => _ParentDashboardScreenState();
}

class _ParentDashboardScreenState extends State<ParentDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    if (!widget.appState.isParentPortalUnlocked) {
      return _buildLockedGatePlaceholder(context);
    }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSecurityReassuranceBar(context),
              const SizedBox(height: 16),
              _buildChildProfilesSection(context),
              const SizedBox(height: 16),
              _buildKpiTilesGrid(),
              const SizedBox(height: 16),
              _buildWeeklyActivityBarChart(),
              const SizedBox(height: 16),
              _buildMathSkillDiagnosticSection(),
              const SizedBox(height: 16),
              _buildSmartControlsSection(),
              const SizedBox(height: 16),
              _buildFamilySubscriptionCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLockedGatePlaceholder(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surfaceDim, width: 2),
              ),
              child: const Icon(Icons.lock_rounded, size: 40, color: AppColors.primary),
            ),
            const SizedBox(height: 18),
            const Text(
              'Cổng Quản Trị Phụ Huynh 🛡️',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Khu vực xem báo cáo tiến độ học tập, thiết lập giới hạn giờ màn hình và gói gia đình dành riêng cho phụ huynh.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: AppColors.onSurfaceVariant, height: 1.4),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => ParentGateDialog(
                    onUnlocked: () {
                      widget.appState.unlockParentPortal();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.key_rounded),
              label: const Text('Mở Khóa Cổng Phụ Huynh'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryContainer,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityReassuranceBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceDim),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.verified_user_rounded, color: AppColors.primary, size: 18),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Cổng Phụ Huynh Bảo Mật',
                        style: TextStyle(fontFamily: 'Rubik', fontSize: 12, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer,
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: const Text(
                          'Đã mở',
                          style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Đã xác minh: 14 × 6 = 84',
                    style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant),
                  ),
                ],
              ),
            ],
          ),
          TextButton.icon(
            onPressed: () => widget.appState.lockParentPortal(),
            icon: const Icon(Icons.lock_outline_rounded, size: 14),
            label: const Text('Khóa lại', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.onSurfaceVariant,
              backgroundColor: AppColors.surfaceContainerHigh,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildProfilesSection(BuildContext context) {
    final kid = widget.appState.currentKid;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Hồ sơ người học',
              style: TextStyle(fontFamily: 'Rubik', fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.onSurface),
            ),
            Text(
              'Gói Family (1/3 bé)',
              style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.surfaceDim, width: 1.5),
                  boxShadow: const [
                    BoxShadow(color: AppColors.surfaceDim, offset: Offset(0, 3)),
                  ],
                ),
                child: Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainerLow,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.surfaceDim),
                          ),
                          child: Center(
                            child: Text(kid.avatarEmoji, style: const TextStyle(fontSize: 26)),
                          ),
                        ),
                        Positioned(
                          right: -2,
                          bottom: -2,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: AppColors.primaryContainer,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.done, color: Colors.white, size: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                kid.nickname,
                                style: const TextStyle(fontFamily: 'Rubik', fontSize: 14, fontWeight: FontWeight.w800),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryFixed,
                                  borderRadius: BorderRadius.circular(9999),
                                ),
                                child: Text(
                                  'Lớp ${kid.grade}',
                                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.onPrimaryFixedVariant),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.local_fire_department_rounded, color: AppColors.streakOrange, size: 14),
                                  const SizedBox(width: 2),
                                  Text('${kid.streakDays} ngày', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                                ],
                              ),
                              const SizedBox(width: 12),
                              Row(
                                children: [
                                  const Icon(Icons.star_rounded, color: AppColors.secondaryContainer, size: 14),
                                  const SizedBox(width: 2),
                                  Text('${kid.stars}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 72,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.surfaceDim),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.person_add_rounded, color: AppColors.primary, size: 22),
                  SizedBox(height: 4),
                  Text('+ Thêm bé', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKpiTilesGrid() {
    return Row(
      children: [
        Expanded(
          child: _buildKpiTile(
            icon: Icons.schedule_rounded,
            iconColor: AppColors.primary,
            title: '3h 45m',
            subtitle: 'Thời gian tuần này',
            badgeText: 'Đạt chỉ tiêu',
            badgeBg: AppColors.primaryFixed,
            badgeTextColor: AppColors.primary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildKpiTile(
            icon: Icons.task_alt_rounded,
            iconColor: AppColors.secondary,
            title: '28 bài',
            subtitle: 'Đã hoàn thành',
            badgeText: '+6 bài',
            badgeBg: AppColors.secondaryFixed,
            badgeTextColor: AppColors.secondary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildKpiTile(
            icon: Icons.query_stats_rounded,
            iconColor: AppColors.primaryContainer,
            title: '89%',
            subtitle: 'Độ chính xác',
            badgeText: 'Rất tốt',
            badgeBg: AppColors.primaryFixed,
            badgeTextColor: AppColors.primaryContainer,
          ),
        ),
      ],
    );
  }

  Widget _buildKpiTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String badgeText,
    required Color badgeBg,
    required Color badgeTextColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.surfaceDim),
        boxShadow: const [
          BoxShadow(color: AppColors.surfaceDim, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: iconColor, size: 18),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: badgeBg.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: badgeTextColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontFamily: 'Rubik', fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.onSurface),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyActivityBarChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.surfaceDim, width: 1.5),
        boxShadow: const [
          BoxShadow(color: AppColors.surfaceDim, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Chuyên cần tuần qua',
                    style: TextStyle(fontFamily: 'Rubik', fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.onSurface),
                  ),
                  Text(
                    'Mục tiêu: 30 phút mỗi ngày',
                    style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.primaryContainer, shape: BoxShape.circle)),
                  const SizedBox(width: 4),
                  const Text('Đạt mốc', style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          // Chart Bars
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: MockData.weeklyActivities.map((act) {
              final double height = (act.minutes / 50.0).clamp(0.2, 1.0) * 80;
              final color = act.isMetGoal ? AppColors.primaryContainer : AppColors.secondaryContainer;

              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${act.minutes}m',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: act.isToday ? AppColors.primary : AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 26,
                    height: height,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    act.dayName,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: act.isToday ? AppColors.primary : AppColors.onSurface,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMathSkillDiagnosticSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.surfaceDim, width: 1.5),
        boxShadow: const [
          BoxShadow(color: AppColors.surfaceDim, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Năng lực Toán học',
                style: TextStyle(fontFamily: 'Rubik', fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.onSurface),
              ),
              Icon(Icons.psychology_rounded, color: AppColors.primary, size: 20),
            ],
          ),
          const Text(
            'Phân tích theo chuẩn chương trình Lớp 3',
            style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant),
          ),
          const SizedBox(height: 14),

          // Skill 1: Multiplication (92%)
          _buildSkillProgressBar(
            title: 'Bảng nhân & Phép nhân 2 chữ số',
            percent: 92,
            tag: '92% • Tốt',
            color: AppColors.primaryContainer,
          ),
          const SizedBox(height: 12),

          // Skill 2: Geometry (78%)
          _buildSkillProgressBar(
            title: 'Hình học & Đo chu vi',
            percent: 78,
            tag: '78% • Đang tiến bộ',
            color: AppColors.secondaryContainer,
          ),
          const SizedBox(height: 12),

          // Skill 3: Word Problems (65%)
          _buildSkillProgressBar(
            title: 'Toán có lời văn',
            percent: 65,
            tag: '65% • Cần hỗ trợ',
            color: AppColors.tertiaryContainer,
          ),
          const SizedBox(height: 16),

          // Socratic Advice Box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.surfaceDim),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('🦉', style: TextStyle(fontSize: 24)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Gợi ý từ Cú Gia sư Socratic:',
                        style: TextStyle(fontFamily: 'Rubik', fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.primary),
                      ),
                      SizedBox(height: 2),
                      Text(
                        MockData.socraticParentAdvice,
                        style: TextStyle(fontSize: 12, color: AppColors.onSurface, height: 1.35),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillProgressBar({
    required String title,
    required int percent,
    required String tag,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.onSurface),
            ),
            Text(
              tag,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(9999),
          child: Container(
            height: 8,
            color: AppColors.surfaceContainer,
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: percent / 100.0,
                child: Container(color: color),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSmartControlsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.surfaceDim, width: 1.5),
        boxShadow: const [
          BoxShadow(color: AppColors.surfaceDim, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Kiểm soát & Giới hạn thông minh',
                style: TextStyle(fontFamily: 'Rubik', fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.onSurface),
              ),
              Icon(Icons.tune_rounded, color: AppColors.outline, size: 20),
            ],
          ),
          const SizedBox(height: 14),

          // Control 1: Screen time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Giới hạn thời gian màn hình: ${widget.appState.screentimeLimitMinutes} phút',
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                    const Text(
                      'Tối đa thời gian học/ngày • Cảnh báo 20-20',
                      style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              Slider(
                value: widget.appState.screentimeLimitMinutes.toDouble(),
                min: 15,
                max: 90,
                divisions: 5,
                label: '${widget.appState.screentimeLimitMinutes}m',
                activeColor: AppColors.primaryContainer,
                onChanged: (val) {
                  widget.appState.setScreentimeLimit(val.toInt());
                },
              ),
            ],
          ),
          const Divider(height: 20, color: AppColors.surfaceContainer),

          // Control 2: Socratic Mode Toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Chế độ Gia sư AI Socratic',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                    Text(
                      'Đặt câu hỏi gợi mở, tuyệt đối không giải hộ đáp án',
                      style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              Switch(
                value: widget.appState.isSocraticModeEnabled,
                activeThumbColor: Colors.white,
                activeTrackColor: AppColors.primaryContainer,
                onChanged: (val) {
                  widget.appState.toggleSocraticMode(val);
                },
              ),
            ],
          ),
          const Divider(height: 20, color: AppColors.surfaceContainer),

          // Control 3: Change PIN
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Đổi mã PIN bảo mật phụ huynh',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
              OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Mã PIN hiện tại demo: 1234. Tính năng đổi mã PIN sẵn sàng!'),
                      backgroundColor: AppColors.primaryContainer,
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.surfaceDim),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                ),
                child: const Text('Thay đổi', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFamilySubscriptionCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryFixed, AppColors.primaryFixedDim],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: AppColors.primaryShadow, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.family_restroom_rounded, color: AppColors.onPrimaryContainer, size: 22),
                  SizedBox(width: 8),
                  Text(
                    'MathLingo Family Premium',
                    style: TextStyle(fontFamily: 'Rubik', fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.onPrimaryContainer),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: const Text(
                  'Còn 280 ngày',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Gói gồm 3 tài khoản học sinh độc lập, đồng bộ tiến độ không giới hạn và gia sư Socratic AI kèm cặp 24/7.',
            style: TextStyle(fontSize: 12, color: AppColors.onPrimaryContainer, height: 1.35),
          ),
        ],
      ),
    );
  }
}
