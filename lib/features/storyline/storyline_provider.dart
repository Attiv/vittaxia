import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../models/storyline_progress.dart';
import '../../core/database/database.dart';

/// 剧情线Provider
final storylineProvider = StateNotifierProvider<StorylineNotifier, AsyncValue<List<StorylineProgress>>>(
  (ref) => StorylineNotifier(ref),
);

/// 剧情线状态管理
class StorylineNotifier extends StateNotifier<AsyncValue<List<StorylineProgress>>> {
  final Ref ref;
  final _uuid = const Uuid();

  StorylineNotifier(this.ref) : super(const AsyncValue.loading()) {
    _loadStorylines();
  }

  /// 加载所有剧情线进度
  Future<void> _loadStorylines() async {
    try {
      // TODO: 从数据库加载
      // 暂时返回空列表
      state = const AsyncValue.data([]);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// 开始剧情线
  Future<void> startStoryline(String characterId, StorylineType type) async {
    final questIds = StorylineConfig.questSequence[type] ?? [];

    final progress = StorylineProgress(
      characterId: characterId,
      type: type,
      currentChapter: 1,
      totalChapters: questIds.length,
      completedQuestIds: [],
      choices: [],
      isCompleted: false,
      startedAt: DateTime.now(),
    );

    // TODO: 保存到数据库

    await _loadStorylines();
  }

  /// 完成章节
  Future<void> completeChapter(
    String characterId,
    StorylineType type,
    String questId,
  ) async {
    final currentState = state.valueOrNull ?? [];
    final progressIndex = currentState.indexWhere(
      (p) => p.characterId == characterId && p.type == type,
    );

    if (progressIndex == -1) return;

    final progress = currentState[progressIndex];
    final newCompletedQuests = [...progress.completedQuestIds, questId];
    final newChapter = progress.currentChapter + 1;
    final isCompleted = newChapter > progress.totalChapters;

    final updatedProgress = progress.copyWith(
      currentChapter: newChapter,
      completedQuestIds: newCompletedQuests,
      isCompleted: isCompleted,
      completedAt: isCompleted ? DateTime.now() : null,
    );

    // TODO: 更新数据库

    await _loadStorylines();
  }

  /// 记录选择
  Future<void> recordChoice(
    String characterId,
    String questId,
    String branchId,
    String choiceName,
  ) async {
    final choice = StorylineChoice(
      questId: questId,
      branchId: branchId,
      choiceName: choiceName,
      chosenAt: DateTime.now(),
    );

    // TODO: 保存到数据库

    await _loadStorylines();
  }

  /// 设置结局
  Future<void> setEnding(
    String characterId,
    StorylineType type,
    String endingType,
  ) async {
    // TODO: 更新数据库

    await _loadStorylines();
  }

  /// 获取角色的剧情进度
  StorylineProgress? getProgress(String characterId, StorylineType type) {
    final currentState = state.valueOrNull ?? [];
    try {
      return currentState.firstWhere(
        (p) => p.characterId == characterId && p.type == type,
      );
    } catch (e) {
      return null;
    }
  }

  /// 检查剧情线是否解锁
  bool isUnlocked(int characterLevel, StorylineType type) {
    final requiredLevel = StorylineConfig.unlockLevel[type] ?? 0;
    return characterLevel >= requiredLevel;
  }

  /// 获取剧情线状态
  StorylineStatus getStatus(
    String characterId,
    StorylineType type,
    int characterLevel,
  ) {
    if (!isUnlocked(characterLevel, type)) {
      return StorylineStatus.locked;
    }

    final progress = getProgress(characterId, type);
    if (progress == null) {
      return StorylineStatus.available;
    }

    if (progress.isCompleted) {
      return StorylineStatus.completed;
    }

    return StorylineStatus.inProgress;
  }

  /// 获取所有剧情线信息
  List<StorylineInfo> getAllStorylineInfo(
    String characterId,
    int characterLevel,
  ) {
    return StorylineType.values.map((type) {
      final questIds = StorylineConfig.questSequence[type] ?? [];
      final description = StorylineConfig.descriptions[type] ?? '';
      final status = getStatus(characterId, type, characterLevel);
      final progress = getProgress(characterId, type);
      final unlockLevel = StorylineConfig.unlockLevel[type] ?? 0;

      String? unlockCondition;
      if (status == StorylineStatus.locked) {
        unlockCondition = '需要等级 $unlockLevel';
      }

      return StorylineInfo(
        type: type,
        name: type.label,
        description: description,
        totalChapters: questIds.length,
        questIds: questIds,
        status: status,
        currentChapter: progress?.currentChapter,
        unlockCondition: unlockCondition,
        rewards: _getStorylineRewards(type),
      );
    }).toList();
  }

  /// 获取剧情线奖励列表
  List<String> _getStorylineRewards(StorylineType type) {
    switch (type) {
      case StorylineType.corrupt:
        return ['经验 +1200', '银两 +600', '正义勋章', '声望 +200'];
      case StorylineType.protection:
        return ['经验 +1000', '银两 +500', '小翠好感度提升'];
      case StorylineType.revenge:
        return ['经验 +1500', '银两 +800', '师傅遗物', '特殊技能'];
      case StorylineType.palace:
        return ['经验 +2000', '银两 +1000', '皇帝赏赐', '朝廷声望'];
      case StorylineType.sect:
        return ['经验 +1800', '银两 +900', '掌门令牌', '门派技能'];
      case StorylineType.martial:
        return ['经验 +1500', '银两 +800', '武林盟主令', '江湖声望'];
      case StorylineType.demon:
        return ['经验 +1600', '银两 +850', '魔功秘籍/正道勋章'];
      case StorylineType.romance:
        return ['经验 +1200', '银两 +600', '道侣玉佩', '特殊称号'];
      case StorylineType.master:
        return ['经验 +1400', '银两 +700', '传承信物', '弟子助战'];
      case StorylineType.ancient:
        return ['经验 +3000', '银两 +1500', '上古神功', '神器'];
    }
  }
}

/// 当前角色的剧情信息Provider
final currentCharacterStorylineInfoProvider = Provider<List<StorylineInfo>>((ref) {
  final character = ref.watch(currentCharacterProvider).valueOrNull;
  if (character == null) return [];

  final storylineNotifier = ref.watch(storylineProvider.notifier);

  // 计算角色等级
  final characterLevel = character.realmTierIndex * 10 + character.realmStageIndex * 2;

  return storylineNotifier.getAllStorylineInfo(character.id, characterLevel);
});

/// 特定剧情线进度Provider
final storylineProgressProvider = Provider.family<StorylineProgress?, StorylineType>(
  (ref, type) {
    final character = ref.watch(currentCharacterProvider).valueOrNull;
    if (character == null) return null;

    final storylineNotifier = ref.watch(storylineProvider.notifier);
    return storylineNotifier.getProgress(character.id, type);
  },
);
