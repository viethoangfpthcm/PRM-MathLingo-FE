import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../data/models/kid_profile.dart';
import '../data/models/lesson_node.dart';
import '../data/models/parent_models.dart';

class AppState extends ChangeNotifier {
  // Profiles
  late List<KidProfile> _profiles;
  int _currentProfileIndex = 0;

  // Map nodes
  late List<LessonNode> _nodes;

  // Recovery quests
  late List<RecoveryQuest> _quests;

  // Parent Portal lock state
  bool _isParentPortalUnlocked = false;
  int _screentimeLimitMinutes = 30;
  bool _isSocraticModeEnabled = true;

  AppState() {
    _profiles = List.from(MockData.profiles);
    _nodes = List.from(MockData.mapNodes);
    _quests = List.from(MockData.recoveryQuests);
  }

  // Getters
  List<KidProfile> get profiles => _profiles;
  KidProfile get currentKid => _profiles[_currentProfileIndex];
  int get currentProfileIndex => _currentProfileIndex;
  List<LessonNode> get nodes => _nodes;
  List<RecoveryQuest> get quests => _quests;
  bool get isParentPortalUnlocked => _isParentPortalUnlocked;
  int get screentimeLimitMinutes => _screentimeLimitMinutes;
  bool get isSocraticModeEnabled => _isSocraticModeEnabled;

  // Switch kid profile
  void switchProfile(int index) {
    if (index >= 0 && index < _profiles.length) {
      _currentProfileIndex = index;
      notifyListeners();
    }
  }

  // Deduct 1 heart on wrong answer
  void loseHeart() {
    if (currentKid.hearts > 0) {
      final updated = currentKid.copyWith(hearts: currentKid.hearts - 1);
      _profiles[_currentProfileIndex] = updated;
      notifyListeners();
    }
  }

  // Refill hearts
  void refillHearts() {
    final updated = currentKid.copyWith(hearts: currentKid.maxHearts);
    _profiles[_currentProfileIndex] = updated;
    notifyListeners();
  }

  // Add stars & XP
  void addStars(int count) {
    final updated = currentKid.copyWith(stars: currentKid.stars + count);
    _profiles[_currentProfileIndex] = updated;
    notifyListeners();
  }

  // Complete lesson node 3 (The active node)
  void completeCurrentLesson() {
    final index = _nodes.indexWhere((n) => n.id == 'node-3');
    if (index != -1) {
      _nodes[index] = _nodes[index].copyWith(
        status: NodeStatus.completed,
        starsEarned: 3,
      );
      // Unlock treasure node
      final treasureIndex = _nodes.indexWhere((n) => n.id == 'node-4');
      if (treasureIndex != -1) {
        _nodes[treasureIndex] = _nodes[treasureIndex].copyWith(
          status: NodeStatus.active,
        );
      }
      addStars(30);
      notifyListeners();
    }
  }

  // Complete recovery quest -> refills 1 or 2 hearts
  void completeQuest(String questId) {
    final index = _quests.indexWhere((q) => q.id == questId);
    if (index != -1 && !_quests[index].isCompleted) {
      final reward = _quests[index].heartsReward;
      _quests[index] = _quests[index].copyWith(isCompleted: true);
      final newHearts = (currentKid.hearts + reward).clamp(0, currentKid.maxHearts);
      _profiles[_currentProfileIndex] = currentKid.copyWith(hearts: newHearts);
      notifyListeners();
    }
  }

  // Unlock parent portal
  void unlockParentPortal() {
    _isParentPortalUnlocked = true;
    notifyListeners();
  }

  // Lock parent portal
  void lockParentPortal() {
    _isParentPortalUnlocked = false;
    notifyListeners();
  }

  // Update screen time limit
  void setScreentimeLimit(int minutes) {
    _screentimeLimitMinutes = minutes;
    notifyListeners();
  }

  // Toggle Socratic AI mode
  void toggleSocraticMode(bool value) {
    _isSocraticModeEnabled = value;
    notifyListeners();
  }
}
