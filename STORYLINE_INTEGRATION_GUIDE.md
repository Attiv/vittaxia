# 剧情系统完整实现指南

## 已完成的内容

### 1. 数据层
✅ **NPC数据** (`lib/data/extended_npc_data.dart`)
- 27个新NPC，覆盖各个地点和剧情线

✅ **剧情任务数据**
- `lib/data/storyline_quests.dart` - 前5条剧情线（贪官、保护、复仇、宫斗、门派）
- `lib/data/additional_storylines.dart` - 后5条剧情线（武林、正邪、爱情、师徒、上古）

✅ **地图数据** (`lib/data/extended_map_data.dart`)
- 7个新地图位置（京城、皇宫、丞相府、魏府、雪山、江南、边关）

### 2. 模型层
✅ **剧情进度模型** (`lib/models/storyline_progress.dart`)
- `StorylineType` - 10种剧情类型
- `StorylineProgress` - 剧情进度追踪
- `StorylineChoice` - 玩家选择记录
- `EndingType` - 20+种结局类型
- `StorylineConfig` - 剧情配置

### 3. 数据库层
✅ **数据库表** (`lib/core/database/tables.dart`)
- `StorylineProgressTable` - 存储剧情进度
- `StorylineChoicesTable` - 存储玩家选择

### 4. 业务逻辑层
✅ **Provider** (`lib/features/storyline/storyline_provider.dart`)
- `StorylineNotifier` - 剧情状态管理
- `storylineProvider` - 剧情进度Provider
- `currentCharacterStorylineInfoProvider` - 当前角色剧情信息
- `storylineProgressProvider` - 特定剧情进度

### 5. UI层
✅ **主页面** (`lib/features/storyline/storyline_page.dart`)
- 剧情列表展示（按类别分组）
- 剧情详情查看
- 章节列表
- 解锁状态显示
- 进度追踪

✅ **组件** (`lib/features/storyline/storyline_widgets.dart`)
- `StorylineChoiceDialog` - 分支选择对话框
- `StorylineCompletionDialog` - 剧情完成对话框
- `StorylineReviewPage` - 剧情回顾页面

### 6. 文档
✅ **设计文档** (`STORYLINE_SUMMARY.md`)
- 完整的剧情系统设计说明

✅ **实现文档** (`STORYLINE_IMPLEMENTATION.md`)
- 详细的实现指南和使用方法

## 如何集成到游戏中

### 步骤1: 数据库迁移
在 `lib/core/database/database.dart` 中添加新表：

```dart
@DriftDatabase(
  tables: [
    // ... 现有表
    StorylineProgressTable,
    StorylineChoicesTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  // 更新版本号
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

### 步骤2: 在主页添加入口
在 `lib/features/home/home_page.dart` 中添加剧情入口：

```dart
// 在主页网格中添加
_buildActionCard(
  context,
  '江湖剧情',
  Icons.auto_stories,
  AppColors.accent,
  () => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const StorylinePage(),
    ),
  ),
),
```

### 步骤3: 集成任务系统
修改 `lib/data/quest_data.dart`，合并剧情任务：

```dart
import 'storyline_quests.dart';
import 'additional_storylines.dart';

final allQuests = <String, Quest>{
  ...quests, // 原有任务
  ...allStorylines, // 剧情任务
};
```

### 步骤4: 集成NPC系统
修改 `lib/data/npc_data.dart`，合并新NPC：

```dart
import 'extended_npc_data.dart';

final allNpcs = <String, Npc>{
  ...npcs, // 原有NPC
  ...extendedNpcs, // 新NPC
};
```

### 步骤5: 集成地图系统
修改 `lib/data/map_data.dart`，合并新地图：

```dart
import 'extended_map_data.dart';

final allMapLocations = <String, MapLocation>{
  ...mapLocations, // 原有地图
  ...extendedMapLocations, // 新地图
};
```

### 步骤6: 运行代码生成
```bash
# 生成Freezed模型代码
dart run build_runner build --delete-conflicting-outputs

# 生成数据库代码
flutter pub run build_runner build --delete-conflicting-outputs
```

## 使用示例

### 1. 显示剧情列表
```dart
// 在任何页面跳转到剧情页面
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const StorylinePage(),
  ),
);
```

### 2. 开始剧情
```dart
// 在剧情详情页点击"开始剧情"
final storylineNotifier = ref.read(storylineProvider.notifier);
await storylineNotifier.startStoryline(characterId, StorylineType.corrupt);
```

### 3. 完成章节
```dart
// 当玩家完成剧情任务时
final storylineNotifier = ref.read(storylineProvider.notifier);
await storylineNotifier.completeChapter(
  characterId,
  StorylineType.corrupt,
  'corrupt_01',
);
```

### 4. 显示分支选择
```dart
// 当任务有分支时
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
        ],
      ),
      // ... 更多选项
    ],
    onChoiceSelected: (branchId) async {
      // 记录选择
      await ref.read(storylineProvider.notifier).recordChoice(
        characterId,
        'corrupt_06',
        branchId,
        '直接揭发',
      );
      // 继续任务
    },
  ),
);
```

### 5. 显示剧情完成
```dart
// 当剧情线完成时
showDialog(
  context: context,
  builder: (context) => StorylineCompletionDialog(
    type: StorylineType.corrupt,
    endingName: '正义伸张',
    endingDescription: '你成功铲除了贪官赵知县...',
    rewards: ['经验 +1200', '银两 +600', '正义勋章'],
  ),
);
```

## 剧情系统特性总结

### 📊 数据规模
- **27个新NPC** - 丰富的角色网络
- **10条剧情线** - 多样的故事体验
- **50+个章节** - 长时间的游戏内容
- **15+个分支** - 多样的选择
- **20+种结局** - 高重玩价值
- **7个新地图** - 扩展的游戏世界

### 🎭 剧情类型
1. **贪官系列** - 正义主题，铲除贪官
2. **保护系列** - 温情主题，保护弱小
3. **复仇系列** - 热血主题，为师报仇
4. **宫斗系列** - 权谋主题，宫廷斗争
5. **门派系列** - 武侠主题，门派争斗
6. **武林盟主** - 竞争主题，争夺盟主
7. **正邪之战** - 选择主题，正邪对立
8. **爱情线** - 浪漫主题，儿女情长
9. **师徒情深** - 传承主题，收徒育人
10. **上古秘境** - 探险主题，寻宝冒险

### 🎯 核心机制
- ✅ **等级解锁** - 不同剧情需要不同等级
- ✅ **进度追踪** - 记录完成的章节
- ✅ **分支选择** - 玩家选择影响剧情
- ✅ **多种结局** - 不同选择不同结局
- ✅ **剧情交织** - 多条剧情线相互关联
- ✅ **奖励系统** - 完成获得丰厚奖励
- ✅ **回顾功能** - 查看已完成的剧情

### 💡 设计亮点
1. **连续性** - 每条剧情线都是连续的故事
2. **选择性** - 关键节点有分支选择
3. **关联性** - 多条剧情线相互关联
4. **多样性** - 10种不同主题的剧情
5. **深度** - 每条线4-7个章节
6. **重玩性** - 不同选择不同体验

## 下一步优化建议

### 1. 数据库实现
- 完善 `StorylineProvider` 的数据库操作
- 实现剧情进度的持久化存储
- 实现玩家选择的记录

### 2. 任务系统集成
- 将剧情任务与现有任务系统深度集成
- 实现分支任务的逻辑
- 实现任务完成后自动推进剧情

### 3. NPC对话系统
- 为新NPC编写对话内容
- 实现剧情相关对话触发
- 根据剧情进度显示不同对话

### 4. 事件系统
- 为新地图添加随机事件
- 实现剧情相关事件触发
- 根据剧情进度触发特殊事件

### 5. UI优化
- 添加剧情动画效果
- 优化剧情选择界面
- 添加剧情CG或插图
- 实现剧情回顾的时间线展示

### 6. 音效和配乐
- 为不同剧情线添加专属BGM
- 添加剧情关键节点的音效
- 实现剧情氛围的音乐切换

### 7. 成就系统集成
- 为完成剧情线添加成就
- 为特定结局添加成就
- 为收集所有结局添加成就

## 总结

通过这套完整的剧情系统，游戏将从一个简单的武侠放置游戏，升级为一个**有深度剧情、多样选择、丰富内容**的武侠RPG游戏！

玩家可以：
- 🎭 体验10种不同主题的长线剧情
- 🎯 在关键节点做出影响剧情的选择
- 🏆 通过不同选择达成20+种结局
- 🗺️ 探索7个新的地图位置
- 👥 与27个新NPC互动
- 💕 体验爱情、友情、师徒情等多种情感
- ⚔️ 参与正邪对立、宫廷斗争等大事件

这将是一个**真正有故事、有温度、有深度**的武侠世界！
