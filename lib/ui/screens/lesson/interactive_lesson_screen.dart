import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/mock_data.dart';
import '../../../state/app_state.dart';
import '../../widgets/tactile_button.dart';

class InteractiveLessonScreen extends StatefulWidget {
  final AppState appState;

  const InteractiveLessonScreen({super.key, required this.appState});

  @override
  State<InteractiveLessonScreen> createState() => _InteractiveLessonScreenState();
}

class _InteractiveLessonScreenState extends State<InteractiveLessonScreen> {
  int? _selectedTile;
  bool _showSocraticHint = false;
  bool _isAnswerChecked = false;
  bool _isCorrect = false;

  final exercise = MockData.sampleExercise;

  void _onPickTile(int number) {
    if (_isAnswerChecked && _isCorrect) return;
    setState(() {
      _selectedTile = number;
      _isAnswerChecked = false;
    });
  }

  void _onClearSlot() {
    if (_isAnswerChecked && _isCorrect) return;
    setState(() {
      _selectedTile = null;
      _isAnswerChecked = false;
    });
  }

  void _checkAnswer() {
    if (_selectedTile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bé hãy chọn một số từ kho số bên dưới để điền vào ô trống nhé!'),
          backgroundColor: AppColors.secondaryShadow,
        ),
      );
      return;
    }

    final isCorrect = _selectedTile == exercise.correctAnswer;
    setState(() {
      _isAnswerChecked = true;
      _isCorrect = isCorrect;
    });

    if (!isCorrect) {
      widget.appState.loseHeart();
    }

    _showFeedbackSheet(isCorrect);
  }

  void _showFeedbackSheet(bool isCorrect) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(ctx).padding.bottom + 16,
          ),
          decoration: BoxDecoration(
            color: isCorrect ? const Color(0xFFECFDF5) : const Color(0xFFFEF2F2),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 20,
                offset: Offset(0, -6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isCorrect ? AppColors.primaryFixed : AppColors.tertiaryFixed,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        isCorrect ? Icons.sentiment_very_satisfied_rounded : Icons.help_outline_rounded,
                        color: isCorrect ? AppColors.primary : AppColors.tertiary,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isCorrect ? 'Chính xác tuyệt vời! 🎉' : 'Chưa hoàn toàn đúng rồi! 🤔',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: isCorrect ? AppColors.primary : AppColors.tertiary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          isCorrect ? exercise.explanation : 'Bạn thử đếm lần lượt các quả táo trong cả 4 giỏ xem ra bao nhiêu nhé!',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.onSurfaceVariant,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              TactileButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  if (isCorrect) {
                    widget.appState.completeCurrentLesson();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('🌟 Xuất sắc! Bé đã hoàn thành Bài 3 và mở khóa Rương Kho Báu!'),
                        backgroundColor: AppColors.primaryContainer,
                      ),
                    );
                  }
                },
                backgroundColor: isCorrect ? AppColors.primaryContainer : AppColors.tertiaryContainer,
                shadowColor: isCorrect ? AppColors.primaryShadow : AppColors.tertiaryShadow,
                child: Text(
                  isCorrect ? 'TIẾP TỤC BÀI HỌC' : 'THỬ LẠI NÀO',
                  style: const TextStyle(letterSpacing: 0.5),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.surfaceDim),
            ),
            child: const Icon(Icons.close_rounded, size: 20, color: AppColors.onSurfaceVariant),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Bài Học Tương Tác',
          style: TextStyle(fontFamily: 'Rubik', fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.onSurface),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(color: AppColors.surfaceDim),
            ),
            child: Row(
              children: [
                const Icon(Icons.favorite_rounded, color: AppColors.tertiaryContainer, size: 18),
                const SizedBox(width: 4),
                Text(
                  '${widget.appState.currentKid.hearts}',
                  style: const TextStyle(fontFamily: 'Rubik', fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.tertiary),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Lesson Progress Bar (3/10)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 14,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: 0.35,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer,
                            borderRadius: BorderRadius.circular(9999),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: const Text(
                    '3/10',
                    style: TextStyle(fontFamily: 'Rubik', fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),

          // Main Scroll Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSocraticOwlPromptCard(),
                      const SizedBox(height: 14),
                      _buildMathVisualIllustrationCard(),
                      const SizedBox(height: 14),
                      _buildEquationSlotsCard(),
                      const SizedBox(height: 18),
                      _buildNumberPaletteHeader(),
                      const SizedBox(height: 10),
                      _buildNumberTileGrid(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Bottom Action Bar
          Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
              bottom: MediaQuery.of(context).padding.bottom + 12,
            ),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1207006C),
                  blurRadius: 16,
                  offset: Offset(0, -4),
                ),
              ],
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TactileButton.primary(
                      onPressed: _checkAnswer,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.check_circle_rounded, size: 20),
                          SizedBox(width: 8),
                          Text('KIỂM TRA ĐÁP ÁN'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextButton(
                      onPressed: () {
                        setState(() => _showSocraticHint = !_showSocraticHint);
                      },
                      child: Text(
                        _showSocraticHint ? 'Ẩn gợi ý Socratic' : 'Xem giải thích chi tiết',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.onSurfaceVariant,
                        ),
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

  Widget _buildSocraticOwlPromptCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceDim),
        boxShadow: const [
          BoxShadow(color: AppColors.surfaceDim, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Owl Mascot Avatar
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryFixed,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text('🦉', style: TextStyle(fontSize: 26)),
                    ),
                  ),
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryContainer,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: const Text(
                        'AI',
                        style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cú Socratic nhắn nhủ:',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      exercise.mascotMessage,
                      style: const TextStyle(fontSize: 13, color: AppColors.onSurfaceVariant, height: 1.3),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Socratic Hint Scaffolding
          if (_showSocraticHint) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.surfaceDim),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.lightbulb_rounded, color: AppColors.secondaryContainer, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Gợi ý từng bước:',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: AppColors.secondary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          exercise.socraticHint,
                          style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant, height: 1.3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMathVisualIllustrationCard() {
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
              const Text(
                'Quan sát hình minh họa:',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.onSurface,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primaryFixed.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: const Text(
                  '4 giỏ × 3 táo',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // 2x2 Grid of Baskets
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.1,
            ),
            itemBuilder: (ctx, idx) {
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.surfaceDim),
                  boxShadow: const [
                    BoxShadow(color: AppColors.surfaceDim, offset: Offset(0, 2)),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 3 Apples
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('🍎', style: TextStyle(fontSize: 16)),
                        SizedBox(width: 4),
                        Text('🍎', style: TextStyle(fontSize: 16)),
                        SizedBox(width: 4),
                        Text('🍎', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '🧺 Giỏ ${idx + 1}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEquationSlotsCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceDim),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Slot 1: 4
          _buildEquationSlot(
            value: '4',
            label: 'Số giỏ',
            isFilled: true,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: Text(
              '×',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
          // Slot 2: 3
          _buildEquationSlot(
            value: '3',
            label: 'Số táo/giỏ',
            isFilled: true,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: Text(
              '=',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
          // Slot 3: Target Slot [ ? ]
          GestureDetector(
            onTap: _onClearSlot,
            child: _buildEquationSlot(
              value: _selectedTile != null ? '$_selectedTile' : '?',
              label: 'Tổng quả',
              isFilled: _selectedTile != null,
              isTarget: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEquationSlot({
    required String value,
    required String label,
    required bool isFilled,
    bool isTarget = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 64,
          height: 52,
          decoration: BoxDecoration(
            color: isTarget && !isFilled
                ? AppColors.surfaceContainerHigh
                : AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isTarget && isFilled
                  ? AppColors.primaryContainer
                  : isTarget
                      ? AppColors.socraticViolet
                      : AppColors.surfaceDim,
              width: isTarget ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isTarget && isFilled ? AppColors.primaryContainer : AppColors.surfaceDim,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: isTarget && !isFilled
                    ? AppColors.outlineVariant
                    : AppColors.primary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildNumberPaletteHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Kho số chọn lựa:',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: AppColors.onSurface,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() => _showSocraticHint = !_showSocraticHint);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(color: AppColors.surfaceDim),
              boxShadow: const [
                BoxShadow(color: AppColors.surfaceDim, offset: Offset(0, 2)),
              ],
            ),
            child: Row(
              children: const [
                Icon(Icons.psychology_rounded, size: 16, color: AppColors.secondary),
                SizedBox(width: 4),
                Text(
                  'Hỏi Cú Vọ 💡',
                  style: TextStyle(fontFamily: 'Rubik', fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.secondary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNumberTileGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: exercise.options.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.7,
      ),
      itemBuilder: (ctx, idx) {
        final num = exercise.options[idx];
        final isSelected = _selectedTile == num;

        return TactileButton(
          onPressed: () => _onPickTile(num),
          backgroundColor: isSelected ? AppColors.primaryContainer : AppColors.surfaceContainerLowest,
          shadowColor: isSelected ? AppColors.primaryShadow : AppColors.surfaceDim,
          textColor: isSelected ? Colors.white : AppColors.onSurface,
          borderRadius: 18,
          child: Text(
            '$num',
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: isSelected ? Colors.white : AppColors.onSurface,
            ),
          ),
        );
      },
    );
  }
}
