import 'models/kid_profile.dart';
import 'models/lesson_node.dart';
import 'models/exercise.dart';
import 'models/parent_models.dart';

class MockData {
  // Profiles
  static final List<KidProfile> profiles = [
    const KidProfile(
      id: 'kid-1',
      nickname: 'Minh Khôi',
      grade: 3,
      avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDUTRgMBX2A5PX0XdgxCDm2cOWPAEtdwc0aEo0CIECNLxuNNOuDdDGprC5Mjjl-RX_pYJ6l1XTEG5RbjaYRre6m4G1SYypeEZxi30APr5bb6QBt4N8z5QlhPLqe2YHGwjd_aRbK6TTV73tLCLwFOJwF8coURSS3pebmhcT4topUbNZ9XEhbsd050vGcDrwEqUdLTGZlJlyQ3QkVdIveh1PM7sisYH_cNcvTqOHrIcQuimF31f7sucwB',
      avatarEmoji: '👦',
      streakDays: 7,
      stars: 340,
      hearts: 5,
    ),
    const KidProfile(
      id: 'kid-2',
      nickname: 'Bé Bin',
      grade: 1,
      avatarUrl: '',
      avatarEmoji: '🦉',
      streakDays: 4,
      stars: 120,
      hearts: 4,
    ),
    const KidProfile(
      id: 'kid-3',
      nickname: 'Bé Na',
      grade: 2,
      avatarUrl: '',
      avatarEmoji: '🐱',
      streakDays: 12,
      stars: 560,
      hearts: 5,
    ),
  ];

  // Learning Map Nodes (Chương 2: Phép nhân & Thừa số kỳ thú)
  static final List<LessonNode> mapNodes = [
    const LessonNode(
      id: 'node-1',
      title: '1. Bảng nhân 3',
      subtitle: 'Ôn tập cơ bản',
      status: NodeStatus.completed,
      starsEarned: 3,
      xpReward: 20,
      horizontalOffset: 0.35,
    ),
    const LessonNode(
      id: 'node-2',
      title: '2. Đếm nhảy thừa số',
      subtitle: 'Bước nhảy số học',
      status: NodeStatus.completed,
      starsEarned: 2,
      xpReward: 25,
      horizontalOffset: -0.35,
    ),
    const LessonNode(
      id: 'node-3',
      title: 'Bài 3: Thừa số & Tích',
      subtitle: 'Kéo thả phép tính',
      status: NodeStatus.active,
      starsEarned: 0,
      xpReward: 30,
      horizontalOffset: 0.0,
    ),
    const LessonNode(
      id: 'node-4',
      title: 'Rương Kho Báu',
      subtitle: '+50 Ngọc quý',
      status: NodeStatus.locked,
      type: NodeType.treasure,
      xpReward: 50,
      horizontalOffset: 0.40,
    ),
    const LessonNode(
      id: 'node-5',
      title: 'Bài 4: Luyện tập phép nhân',
      subtitle: 'Thực hành nâng cao',
      status: NodeStatus.locked,
      horizontalOffset: -0.30,
    ),
    const LessonNode(
      id: 'node-6',
      title: 'Bài 5: Đố vui chia kẹo',
      subtitle: 'Toán có lời văn',
      status: NodeStatus.locked,
      horizontalOffset: 0.35,
    ),
    const LessonNode(
      id: 'node-7',
      title: 'Thử thách Trùm Chương 2',
      subtitle: 'Huy hiệu Vương miện',
      status: NodeStatus.locked,
      type: NodeType.boss,
      horizontalOffset: 0.0,
    ),
    const LessonNode(
      id: 'node-8',
      title: '1. Làm quen phép chia',
      subtitle: 'Chương 3 - Phép chia bí ẩn',
      status: NodeStatus.locked,
      type: NodeType.gate,
      horizontalOffset: -0.35,
    ),
  ];

  // Interactive Exercise Demo (Screen 2)
  static const Exercise sampleExercise = Exercise(
    id: 'ex-1',
    title: 'Bài Học Tương Tác',
    mascotMessage: 'Xếp các số vào ô trống để lập thành phép tính nhân đúng nhé!',
    socraticHint: 'Bạn nhỏ ơi, hãy đếm xem trên cỏ có bao nhiêu chiếc giỏ mây tất cả nào? Mỗi chiếc giỏ đựng mấy quả táo chín đỏ?',
    groupsCount: 4,
    itemsPerGroup: 3,
    groupName: 'giỏ',
    itemName: 'táo',
    correctAnswer: 12,
    options: [12, 7, 15, 6, 4, 3],
    explanation: 'Có 4 nhóm (chiếc giỏ), mỗi nhóm có 3 quả táo. Ta có phép nhân: 4 × 3 = 12 quả táo!',
  );

  // Recovery Quests (Screen 3)
  static final List<RecoveryQuest> recoveryQuests = [
    const RecoveryQuest(
      id: 'q-1',
      title: 'Tưới cây Bảng Nhân 2',
      desc: 'Đã phục hồi sinh lực mầm non',
      heartsReward: 1,
      isCompleted: true,
      iconName: 'water_drop',
    ),
    const RecoveryQuest(
      id: 'q-2',
      title: 'Bắt sâu Phép Trừ',
      desc: 'Trừ có nhớ vui nhộn với bọ rùa',
      heartsReward: 2,
      isCompleted: false,
      iconName: 'bug_report',
    ),
    const RecoveryQuest(
      id: 'q-3',
      title: 'Ghép hoa Phân Số',
      desc: 'Xếp cánh hoa 1/2 và 1/4 nhẹ nhàng',
      heartsReward: 2,
      isCompleted: false,
      iconName: 'local_florist',
    ),
  ];

  // Weekly Activity for Parent Chart (Screen 4)
  static final List<DailyActivity> weeklyActivities = [
    const DailyActivity(dayName: 'T2', minutes: 32, isMetGoal: true),
    const DailyActivity(dayName: 'T3', minutes: 40, isMetGoal: true),
    const DailyActivity(dayName: 'T4', minutes: 25, isMetGoal: false),
    const DailyActivity(dayName: 'T5', minutes: 35, isMetGoal: true),
    const DailyActivity(dayName: 'T6', minutes: 45, isMetGoal: true),
    const DailyActivity(dayName: 'T7', minutes: 30, isMetGoal: true),
    const DailyActivity(dayName: 'CN', minutes: 18, isMetGoal: false, isToday: true),
  ];

  // Math Skill Mastery Diagnostic (Screen 4)
  static final List<SkillMastery> skillMasteries = [
    const SkillMastery(
      title: 'Bảng nhân & Phép nhân 2 chữ số',
      percentage: 92,
      statusText: '92% • Tốt',
      level: 'Tốt',
    ),
    const SkillMastery(
      title: 'Hình học & Đo chu vi',
      percentage: 78,
      statusText: '78% • Đang tiến bộ',
      level: 'Đang tiến bộ',
    ),
    const SkillMastery(
      title: 'Toán có lời văn',
      percentage: 65,
      statusText: '65% • Cần hỗ trợ',
      level: 'Cần hỗ trợ',
    ),
  ];

  // Socratic advice for parents
  static const String socraticParentAdvice =
      'Bé Minh Khôi nắm rất chắc phép tính, nhưng hay đọc lướt câu hỏi dài. Bố mẹ nên khích lệ bé đọc to đề bài 2 lần trước khi đặt bút.';
}
