import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/tactile_button.dart';

class ParentGateDialog extends StatefulWidget {
  final VoidCallback onUnlocked;

  const ParentGateDialog({super.key, required this.onUnlocked});

  @override
  State<ParentGateDialog> createState() => _ParentGateDialogState();
}

class _ParentGateDialogState extends State<ParentGateDialog> {
  // Math challenge: 14 × 6 = 84
  final int num1 = 14;
  final int num2 = 6;
  int get correctAnswer => num1 * num2; // 84

  String _input = '';
  String? _errorMessage;
  bool _usePinMode = false;
  final String correctPin = '1234';

  void _onKeyPress(String val) {
    if (_input.length < 4) {
      setState(() {
        _input += val;
        _errorMessage = null;
      });
    }
  }

  void _onDelete() {
    if (_input.isNotEmpty) {
      setState(() {
        _input = _input.substring(0, _input.length - 1);
        _errorMessage = null;
      });
    }
  }

  void _onConfirm() {
    if (_usePinMode) {
      if (_input == correctPin) {
        widget.onUnlocked();
        Navigator.pop(context);
      } else {
        setState(() {
          _errorMessage = 'Mã PIN chưa đúng (Mặc định demo: 1234)';
          _input = '';
        });
      }
    } else {
      final answer = int.tryParse(_input);
      if (answer == correctAnswer) {
        widget.onUnlocked();
        Navigator.pop(context);
      } else {
        setState(() {
          _errorMessage = 'Kết quả chưa chính xác! Vui lòng thử lại.';
          _input = '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surfaceContainerLowest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Shield Icon
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primaryContainer.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.security_rounded, color: AppColors.primary, size: 30),
            ),
            const SizedBox(height: 12),
            const Text(
              'Cổng Phụ Huynh Bảo Mật 🛡️',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: AppColors.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _usePinMode
                  ? 'Nhập mã PIN 4 số của phụ huynh để tiếp tục'
                  : 'Giải phép tính sau để xác minh bạn là phụ huynh:',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: 14),

            // Challenge Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.surfaceDim),
              ),
              child: Column(
                children: [
                  Text(
                    _usePinMode ? 'MÃ PIN BẢO VỆ' : '$num1  ×  $num2  =  ?',
                    style: const TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 140,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _errorMessage != null ? AppColors.tertiary : AppColors.primaryContainer,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _input.isEmpty ? 'Nhập đáp án' : _input,
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: _input.isEmpty ? AppColors.outlineVariant : AppColors.onSurface,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (_errorMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                _errorMessage!,
                style: const TextStyle(fontSize: 12, color: AppColors.tertiary, fontWeight: FontWeight.bold),
              ),
            ],

            const SizedBox(height: 16),

            // Custom Numeric Keypad
            _buildKeypad(),

            const SizedBox(height: 14),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _usePinMode = !_usePinMode;
                        _input = '';
                        _errorMessage = null;
                      });
                    },
                    child: Text(
                      _usePinMode ? 'Dùng Phép Tính' : 'Dùng Mã PIN',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: TactileButton.primary(
                    onPressed: _input.isNotEmpty ? _onConfirm : null,
                    height: 44,
                    child: const Text('MỞ KHÓA'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypad() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['1', '2', '3'].map(_buildKey).toList(),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['4', '5', '6'].map(_buildKey).toList(),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['7', '8', '9'].map(_buildKey).toList(),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActionKey(
              icon: Icons.clear_rounded,
              onTap: () => setState(() => _input = ''),
            ),
            _buildKey('0'),
            _buildActionKey(
              icon: Icons.backspace_rounded,
              onTap: _onDelete,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKey(String text) {
    return InkWell(
      onTap: () => _onKeyPress(text),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 60,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.surfaceDim),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.onSurface,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionKey({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 60,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Icon(icon, size: 20, color: AppColors.onSurfaceVariant),
        ),
      ),
    );
  }
}
