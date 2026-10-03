class DailyActivity {
  final String dayName; // "T2", "T3", etc.
  final int minutes;
  final bool isMetGoal;
  final bool isToday;

  const DailyActivity({
    required this.dayName,
    required this.minutes,
    required this.isMetGoal,
    this.isToday = false,
  });
}

class SkillMastery {
  final String title;
  final int percentage;
  final String statusText;
  final String level; // "Tốt", "Đang tiến bộ", "Cần hỗ trợ"

  const SkillMastery({
    required this.title,
    required this.percentage,
    required this.statusText,
    required this.level,
  });
}

class RecoveryQuest {
  final String id;
  final String title;
  final String desc;
  final int heartsReward;
  final bool isCompleted;
  final String iconName;

  const RecoveryQuest({
    required this.id,
    required this.title,
    required this.desc,
    required this.heartsReward,
    required this.isCompleted,
    required this.iconName,
  });

  RecoveryQuest copyWith({bool? isCompleted}) {
    return RecoveryQuest(
      id: id,
      title: title,
      desc: desc,
      heartsReward: heartsReward,
      isCompleted: isCompleted ?? this.isCompleted,
      iconName: iconName,
    );
  }
}
