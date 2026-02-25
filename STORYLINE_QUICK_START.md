# 剧情系统 - 快速开始指南

## 🚀 5分钟快速集成

### 步骤1: 数据库迁移 (2分钟)

打开 `lib/core/database/database.dart`，添加新表并更新版本：

```dart
@DriftDatabase(
  tables: [
    Characters,
    InventoryItems,
    LearnedSkills,
    NpcRelations,
    QuestProgress,
    DungeonProgress,
    SectMembers,
    SectQuestProgress,
    CultivationSessions,
    FactionReputations,
    AchievementProgress,
    CharacterTitles,
    JianghuRecords,
    ArenaRecords,
    StorylineProgressTable,      // 新增
    StorylineChoicesTable,        // 新增
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4; // 从3升级到4

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 4) {
          // 创建剧情相关表
          await m.createTable(storylineProgressTable);
          await m.createTable(storylineChoicesTable);
        }
      },
    );
  }
}
```

### 步骤2: 合并数据文件 (1分钟)

#### 合并NPC数据
在 `lib/data/npc_data.dart` 文件末尾添加：

```dart
import 'extended_npc_data.dart';

// 在文件末尾添加
final allNpcs = <String, Npc>{
  ...npcs,
  ...extendedNpcs,
};
```

#### 合并任务数据
在 `lib/data/quest_data.dart` 文件末尾添加：

```dart
import 'storyline_quests.dart';
import 'additional_storylines.dart';

// 在文件末尾添加
final allQuests = <String, Quest>{
  ...quests,
  ...allStorylines,
};
```

#### 合并地图数据
在 `lib/data/map_data.dart` 文件末尾添加：

```dart
import 'extended_map_data.dart';

// 在文件末尾添加
final allMapLocations = <String, MapLocation>{
  ...mapLocations,
  ...extendedMapLocations,
};
```

### 步骤3: 添加主页入口 (1分钟)

在 `lib/features/home/home_page.dart` 中添加剧情入口按钮：

```dart
import '../storyline/storyline_page.dart';

// 在主页网格中添加（找到其他功能按钮的位置）
_buildActionCard(
  context,
  '江湖剧情',
  Icons.auto_stories,
  AppColors.accent,
  () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StorylinePage(),
      ),
    );
  },
),
```

### 步骤4: 运行代码生成 (1分钟)

在终端运行：

```bash
# 生成Freezed和数据库代码
dart run build_runner build --delete-conflicting-outputs
```

### 完成！🎉

现在你可以运行游戏，在主页点击"江湖剧情"按钮，开始体验丰富的剧情系统了！

---

## 📖 详细使用指南

### 1. 在代码中使用剧情系统

#### 开始剧情
```dart
// 获取Provider
final storylineNotifier = ref.read(storylineProvider.notifier);

// 开始剧情线
await storylineNotifier.startStoryline(
  characterId,
  StorylineType.corrupt, // 贪官系列
);
```

#### 完成章节
```dart
// 当玩家完成剧情任务时调用
await storylineNotifier.completeChapter(
  characterId,
  StorylineType.corrupt,
  'corrupt_01', // 任务ID
);
```

#### 记录玩家选择
```dart
// 当玩家在分支任务中做出选择时
await storylineNotifier.recordChoice(
  characterId,
  'corrupt_06',      // 任务ID
  'corrupt_06_a',    // 分支ID
  '直接揭发',         // 选择名称
);
```

#### 设置结局
```dart
// 当剧情线完成时设置结局
await storylineNotifier.setEnding(
  characterId,
  StorylineType.corrupt,
  'corruptDirect', // 结局类型
);
```

### 2. 显示剧情UI

#### 显示剧情列表
```dart
// 跳转到剧情页面
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const StorylinePage(),
  ),
);
```

#### 显示分支选择对话框
```dart
showDialog(
  context: context,
  builder: (context) => StorylineChoiceDialog(
    questName: '公堂对质',
    options: [
      StorylineBranchOption(
        branchId: 'corrupt_06_a',
        name: '直接揭发',
        description: '当场揭发赵知县，但他可能狗急跳墙。',
        consequences: [
          BranchConsequence(
            type: ConsequenceType.reward,
            text: '获得正义勋章',
          ),
          BranchConsequence(
            type: ConsequenceType.risk,
            text: '可能遭到反击',
          ),
        ],
      ),
      StorylineBranchOption(
        branchId: 'corrupt_06_b',
        name: '上报朝廷',
        description: '将证据送往京城，请朝廷派人处理。',
        consequences: [
          BranchConsequence(
            type: ConsequenceType.reward,
            text: '获得官印',
          ),
          BranchConsequence(
            type: ConsequenceType.reputation,
            text: '朝廷声望提升',
          ),
        ],
      ),
    ],
    onChoiceSelected: (branchId) async {
      // 处理选择
      await ref.read(storylineProvider.notifier).recordChoice(
        characterId,
        'corrupt_06',
        branchId,
        branchId == 'corrupt_06_a' ? '直接揭发' : '上报朝廷',
      );

      // 继续任务流程
      // ...
    },
  ),
);
```

#### 显示剧情完成对话框
```dart
showDialog(
  context: context,
  builder: (context) => StorylineCompletionDialog(
    type: StorylineType.corrupt,
    endingName: '正义伸张',
    endingDescription: '你成功铲除了贪官赵知县，清风镇的百姓终于过上了安稳的日子。你的名声在江湖中传开，人们称你为"青天侠客"。',
    rewards: [
      '经验 +1200',
      '银两 +600',
      '正义勋章 x1',
      '声望 +200',
      '称号：青天侠客',
    ],
  ),
);
```

### 3. 使用辅助工具类

```dart
import 'package:vittaxia/features/storyline/storyline_helper.dart';

// 获取剧情线的所有任务ID
final questIds = StorylineHelper.getQuestIds(StorylineType.corrupt);

// 检查任务是否属于剧情线
final isStoryline = StorylineHelper.isStorylineQuest('corrupt_01');

// 获取任务所属的剧情线
final type = StorylineHelper.getStorylineTypeByQuest('corrupt_01');

// 获取章节号
final chapter = StorylineHelper.getChapterNumber(
  StorylineType.corrupt,
  'corrupt_01',
); // 返回 1

// 检查是否是最后一章
final isLast = StorylineHelper.isLastChapter(
  StorylineType.corrupt,
  'corrupt_06',
); // 返回 true

// 计算完成度
final progress = StorylineHelper.calculateProgress(storylineProgress);

// 获取剧情标签
final tags = StorylineHelper.getTags(StorylineType.corrupt);
// 返回 ['正义', '战斗', '选择']

// 获取主要NPC
final npcs = StorylineHelper.getMainNpcs(StorylineType.corrupt);
// 返回 ['赵知县', '李捕头', '张彩凤', '二当家']

// 获取奖励预览
final rewards = StorylineHelper.getRewardPreview(StorylineType.corrupt);

// 检查是否可以开始
final canStart = StorylineHelper.canStart(
  StorylineType.corrupt,
  characterLevel,
  characterData,
);

// 获取无法开始的原因
final reason = StorylineHelper.getCannotStartReason(
  StorylineType.corrupt,
  characterLevel,
  characterData,
);
```

---

## 🎮 游戏流程示例

### 完整的剧情流程

```dart
class StorylineGameFlow {
  final WidgetRef ref;

  StorylineGameFlow(this.ref);

  /// 完整的剧情流程示例
  Future<void> playStoryline(
    BuildContext context,
    String characterId,
    StorylineType type,
  ) async {
    final notifier = ref.read(storylineProvider.notifier);

    // 1. 开始剧情
    await notifier.startStoryline(characterId, type);

    // 2. 获取任务列表
    final questIds = StorylineHelper.getQuestIds(type);

    // 3. 逐个完成任务
    for (final questId in questIds) {
      // 显示任务
      await _showQuest(context, questId);

      // 检查是否有分支
      final quest = allQuests[questId];
      if (quest?.branches != null && quest!.branches!.isNotEmpty) {
        // 显示分支选择
        final branchId = await _showBranchChoice(context, quest);

        // 记录选择
        await notifier.recordChoice(
          characterId,
          questId,
          branchId,
          quest.branches!.firstWhere((b) => b.id == branchId).name,
        );
      }

      // 完成章节
      await notifier.completeChapter(characterId, type, questId);

      // 检查是否是最后一章
      if (StorylineHelper.isLastChapter(type, questId)) {
        // 显示完成对话框
        await _showCompletion(context, type);
      }
    }
  }

  Future<void> _showQuest(BuildContext context, String questId) async {
    // 显示任务内容
    // ...
  }

  Future<String> _showBranchChoice(
    BuildContext context,
    Quest quest,
  ) async {
    // 显示分支选择对话框
    // 返回选择的分支ID
    return 'branch_a';
  }

  Future<void> _showCompletion(
    BuildContext context,
    StorylineType type,
  ) async {
    // 显示完成对话框
    // ...
  }
}
```

---

## 🔍 常见问题

### Q1: 如何检查玩家是否已经开始某个剧情？
```dart
final progress = ref.read(storylineProgressProvider(StorylineType.corrupt));
if (progress != null) {
  // 已经开始
  print('当前进度: ${progress.currentChapter}/${progress.totalChapters}');
} else {
  // 尚未开始
}
```

### Q2: 如何获取所有可用的剧情？
```dart
final character = ref.read(currentCharacterProvider).valueOrNull;
if (character != null) {
  final storylineInfos = ref.read(currentCharacterStorylineInfoProvider);

  // 筛选可用的剧情
  final available = storylineInfos.where(
    (info) => info.status == StorylineStatus.available,
  ).toList();
}
```

### Q3: 如何在任务完成时自动推进剧情？
```dart
// 在任务完成的回调中
void onQuestCompleted(String questId) {
  // 检查是否是剧情任务
  if (StorylineHelper.isStorylineQuest(questId)) {
    // 获取所属剧情线
    final type = StorylineHelper.getStorylineTypeByQuest(questId);
    if (type != null) {
      // 完成章节
      ref.read(storylineProvider.notifier).completeChapter(
        characterId,
        type,
        questId,
      );

      // 检查是否完成整个剧情线
      if (StorylineHelper.isLastChapter(type, questId)) {
        // 显示完成对话框
        _showStorylineCompletion(type);
      }
    }
  }
}
```

### Q4: 如何显示剧情进度提示？
```dart
Widget buildStorylineProgressHint() {
  return Consumer(
    builder: (context, ref, child) {
      final character = ref.watch(currentCharacterProvider).valueOrNull;
      if (character == null) return const SizedBox.shrink();

      final storylines = ref.watch(storylineProvider).valueOrNull ?? [];
      final inProgress = storylines.where(
        (s) => s.characterId == character.id && !s.isCompleted,
      ).toList();

      if (inProgress.isEmpty) return const SizedBox.shrink();

      return Container(
        padding: const EdgeInsets.all(12),
        color: AppColors.accent.withValues(alpha: 0.1),
        child: Row(
          children: [
            Icon(Icons.auto_stories, color: AppColors.accent, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '进行中的剧情: ${inProgress.length}',
                style: TextStyle(color: AppColors.accent),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StorylinePage(),
                  ),
                );
              },
              child: const Text('查看'),
            ),
          ],
        ),
      );
    },
  );
}
```

### Q5: 如何实现剧情解锁提示？
```dart
void checkStorylineUnlock(int oldLevel, int newLevel) {
  // 检查是否有新剧情解锁
  for (final type in StorylineType.values) {
    final unlockLevel = StorylineHelper.getUnlockLevel(type);
    if (oldLevel < unlockLevel && newLevel >= unlockLevel) {
      // 显示解锁提示
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.lock_open, color: AppColors.success),
              const SizedBox(width: 8),
              const Text('剧情解锁'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '恭喜！解锁新剧情：',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 12),
              Text(
                type.label,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                StorylineHelper.getDescription(type),
                style: const TextStyle(fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('稍后查看'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StorylinePage(),
                  ),
                );
              },
              child: const Text('立即查看'),
            ),
          ],
        ),
      );
    }
  }
}
```

---

## 📝 最佳实践

### 1. 剧情任务与主线任务的区分
```dart
// 在任务列表中区分显示
Widget buildQuestList(List<Quest> quests) {
  final storylineQuests = quests.where(
    (q) => StorylineHelper.isStorylineQuest(q.id),
  ).toList();

  final normalQuests = quests.where(
    (q) => !StorylineHelper.isStorylineQuest(q.id),
  ).toList();

  return Column(
    children: [
      if (storylineQuests.isNotEmpty) ...[
        const Text('剧情任务', style: TextStyle(fontWeight: FontWeight.bold)),
        ...storylineQuests.map((q) => buildQuestCard(q, isStoryline: true)),
      ],
      if (normalQuests.isNotEmpty) ...[
        const Text('普通任务', style: TextStyle(fontWeight: FontWeight.bold)),
        ...normalQuests.map((q) => buildQuestCard(q, isStoryline: false)),
      ],
    ],
  );
}
```

### 2. 剧情进度持久化
```dart
// 确保在关键节点保存进度
class StorylineManager {
  Future<void> saveProgress(StorylineProgress progress) async {
    // 保存到数据库
    final db = await database;
    await db.into(db.storylineProgressTable).insertOnConflictUpdate(
      StorylineProgressTableCompanion(
        id: Value(progress.characterId + '_' + progress.type.name),
        characterId: Value(progress.characterId),
        typeIndex: Value(progress.type.index),
        currentChapter: Value(progress.currentChapter),
        totalChapters: Value(progress.totalChapters),
        completedQuestIdsJson: Value(jsonEncode(progress.completedQuestIds)),
        isCompleted: Value(progress.isCompleted),
        endingType: Value(progress.endingType),
        startedAt: Value(progress.startedAt),
        completedAt: Value(progress.completedAt),
      ),
    );
  }
}
```

### 3. 剧情事件触发
```dart
// 在特定事件发生时触发剧情
void onEventTriggered(String eventId) {
  // 检查是否触发剧情
  switch (eventId) {
    case 'meet_zhao_zhixian':
      // 触发贪官线
      _triggerStoryline(StorylineType.corrupt);
      break;
    case 'xiaocui_help':
      // 触发保护线
      _triggerStoryline(StorylineType.protection);
      break;
    // ... 更多事件
  }
}

void _triggerStoryline(StorylineType type) {
  // 显示剧情开始提示
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('触发剧情'),
      content: Text('是否开始剧情：${type.label}？'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('暂不开始'),
        ),
        ElevatedButton(
          onPressed: () async {
            Navigator.of(context).pop();
            await ref.read(storylineProvider.notifier).startStoryline(
              characterId,
              type,
            );
          },
          child: const Text('开始剧情'),
        ),
      ],
    ),
  );
}
```

---

## 🎯 下一步

完成基础集成后，你可以：

1. ✅ 为新NPC添加对话内容
2. ✅ 为新地图添加随机事件
3. ✅ 实现剧情相关的成就
4. ✅ 添加剧情CG或插图
5. ✅ 为不同剧情添加专属BGM
6. ✅ 优化剧情UI动画效果

---

**祝你的游戏开发顺利！** 🎉
