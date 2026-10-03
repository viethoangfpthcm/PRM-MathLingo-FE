enum NodeStatus { completed, active, locked }

enum NodeType { standard, treasure, boss, gate }

class LessonNode {
  final String id;
  final String title;
  final String subtitle;
  final NodeStatus status;
  final NodeType type;
  final int starsEarned; // 0 to 3
  final int xpReward;
  final double horizontalOffset; // offset from center: -1.0 (left) to 1.0 (right)

  const LessonNode({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.status,
    this.type = NodeType.standard,
    this.starsEarned = 0,
    this.xpReward = 20,
    this.horizontalOffset = 0.0,
  });

  LessonNode copyWith({
    String? id,
    String? title,
    String? subtitle,
    NodeStatus? status,
    NodeType? type,
    int? starsEarned,
    int? xpReward,
    double? horizontalOffset,
  }) {
    return LessonNode(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      status: status ?? this.status,
      type: type ?? this.type,
      starsEarned: starsEarned ?? this.starsEarned,
      xpReward: xpReward ?? this.xpReward,
      horizontalOffset: horizontalOffset ?? this.horizontalOffset,
    );
  }
}
