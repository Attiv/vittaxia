import '../../models/storyline_progress.dart';
import '../../data/storyline_quests.dart';
import '../../data/additional_storylines.dart';

/// 剧情系统辅助工具类
class StorylineHelper {
  /// 获取剧情线的所有任务ID
  static List<String> getQuestIds(StorylineType type) {
    return StorylineConfig.questSequence[type] ?? [];
  }

  /// 获取剧情线的描述
  static String getDescription(StorylineType type) {
    return StorylineConfig.descriptions[type] ?? '';
  }

  /// 获取剧情线的解锁等级
  static int getUnlockLevel(StorylineType type) {
    return StorylineConfig.unlockLevel[type] ?? 0;
  }

  /// 检查任务是否属于某个剧情线
  static bool isStorylineQuest(String questId) {
    for (final questIds in StorylineConfig.questSequence.values) {
      if (questIds.contains(questId)) {
        return true;
      }
    }
    return false;
  }

  /// 根据任务ID获取所属的剧情线类型
  static StorylineType? getStorylineTypeByQuest(String questId) {
    for (final entry in StorylineConfig.questSequence.entries) {
      if (entry.value.contains(questId)) {
        return entry.key;
      }
    }
    return null;
  }

  /// 获取任务在剧情线中的章节号（从1开始）
  static int? getChapterNumber(StorylineType type, String questId) {
    final questIds = getQuestIds(type);
    final index = questIds.indexOf(questId);
    return index >= 0 ? index + 1 : null;
  }

  /// 获取下一个章节的任务ID
  static String? getNextQuestId(StorylineType type, String currentQuestId) {
    final questIds = getQuestIds(type);
    final index = questIds.indexOf(currentQuestId);
    if (index >= 0 && index < questIds.length - 1) {
      return questIds[index + 1];
    }
    return null;
  }

  /// 检查是否是剧情线的最后一章
  static bool isLastChapter(StorylineType type, String questId) {
    final questIds = getQuestIds(type);
    return questIds.isNotEmpty && questIds.last == questId;
  }

  /// 获取剧情线的总章节数
  static int getTotalChapters(StorylineType type) {
    return getQuestIds(type).length;
  }

  /// 计算剧情线完成度（0.0 - 1.0）
  static double calculateProgress(StorylineProgress progress) {
    if (progress.totalChapters == 0) return 0.0;
    return progress.completedQuestIds.length / progress.totalChapters;
  }

  /// 获取剧情线的推荐等级范围
  static String getRecommendedLevelRange(StorylineType type) {
    final unlockLevel = getUnlockLevel(type);
    final endLevel = unlockLevel + 10;
    return 'Lv.$unlockLevel - Lv.$endLevel';
  }

  /// 获取剧情线的难度描述
  static String getDifficultyDescription(StorylineType type) {
    final unlockLevel = getUnlockLevel(type);
    if (unlockLevel <= 10) return '简单';
    if (unlockLevel <= 20) return '普通';
    if (unlockLevel <= 30) return '困难';
    return '极难';
  }

  /// 获取剧情线的标签
  static List<String> getTags(StorylineType type) {
    switch (type) {
      case StorylineType.corrupt:
        return ['正义', '战斗', '选择'];
      case StorylineType.protection:
        return ['温情', '保护', '选择'];
      case StorylineType.revenge:
        return ['热血', '复仇', '战斗'];
      case StorylineType.palace:
        return ['权谋', '宫斗', '选择'];
      case StorylineType.sect:
        return ['门派', '武侠', '传承'];
      case StorylineType.martial:
        return ['竞技', '江湖', '选择'];
      case StorylineType.demon:
        return ['正邪', '选择', '战斗'];
      case StorylineType.romance:
        return ['爱情', '温情', '选择'];
      case StorylineType.master:
        return ['传承', '师徒', '养成'];
      case StorylineType.ancient:
        return ['探险', '神秘', '战斗'];
    }
  }

  /// 获取剧情线的主要NPC
  static List<String> getMainNpcs(StorylineType type) {
    switch (type) {
      case StorylineType.corrupt:
        return ['赵知县', '李捕头', '张彩凤', '二当家'];
      case StorylineType.protection:
        return ['小翠', '赵知县', '李捕头'];
      case StorylineType.revenge:
        return ['王秀才', '血手', '魏公公'];
      case StorylineType.palace:
        return ['明珠公主', '魏公公', '李丞相', '皇帝'];
      case StorylineType.sect:
        return ['天剑门掌门', '叛徒弟子'];
      case StorylineType.martial:
        return ['天剑门掌门', '魔教教主'];
      case StorylineType.demon:
        return ['魔教教主'];
      case StorylineType.romance:
        return ['苏晚吟', '柳如烟', '明珠公主'];
      case StorylineType.master:
        return ['潜在弟子'];
      case StorylineType.ancient:
        return ['上古守护者'];
    }
  }

  /// 获取剧情线的主要地点
  static List<String> getMainLocations(StorylineType type) {
    switch (type) {
      case StorylineType.corrupt:
        return ['清风镇', '落霞山脉'];
      case StorylineType.protection:
        return ['青云村', '清风镇', '望月楼'];
      case StorylineType.revenge:
        return ['青云村', '清风镇', '京城', '魏府'];
      case StorylineType.palace:
        return ['京城', '皇宫', '丞相府', '魏府'];
      case StorylineType.sect:
        return ['天剑门', '雪山'];
      case StorylineType.martial:
        return ['武林大会'];
      case StorylineType.demon:
        return ['魔教遗迹'];
      case StorylineType.romance:
        return ['望月楼', '清风镇', '京城'];
      case StorylineType.master:
        return ['青云村'];
      case StorylineType.ancient:
        return ['上古秘境'];
    }
  }

  /// 获取剧情线的预估完成时间（分钟）
  static int getEstimatedTime(StorylineType type) {
    final chapters = getTotalChapters(type);
    return chapters * 15; // 每章约15分钟
  }

  /// 检查剧情线是否有分支选择
  static bool hasBranches(StorylineType type) {
    final questIds = getQuestIds(type);
    // 检查是否有任务包含分支
    for (final questId in questIds) {
      final quest = {...allStorylines}[questId];
      if (quest?.branches != null && quest!.branches!.isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  /// 获取剧情线的分支数量
  static int getBranchCount(StorylineType type) {
    final questIds = getQuestIds(type);
    int count = 0;
    for (final questId in questIds) {
      final quest = {...allStorylines}[questId];
      if (quest?.branches != null && quest!.branches!.isNotEmpty) {
        count += quest.branches!.length;
      }
    }
    return count;
  }

  /// 获取剧情线的可能结局数量
  static int getEndingCount(StorylineType type) {
    switch (type) {
      case StorylineType.corrupt:
        return 2; // 直接揭发 / 上报朝廷
      case StorylineType.protection:
        return 2; // 送望月楼 / 送京城
      case StorylineType.revenge:
        return 2; // 正面决斗 / 智取
      case StorylineType.palace:
        return 2; // 正面迎战 / 智取
      case StorylineType.sect:
        return 1; // 继任掌门
      case StorylineType.martial:
        return 3; // 支持正道 / 支持邪道 / 自立为王
      case StorylineType.demon:
        return 2; // 加入魔教 / 坚守正道
      case StorylineType.romance:
        return 4; // 苏晚吟 / 柳如烟 / 公主私奔 / 公主立功
      case StorylineType.master:
        return 1; // 传承衣钵
      case StorylineType.ancient:
        return 1; // 获得神功
    }
  }

  /// 获取剧情线的奖励预览
  static List<String> getRewardPreview(StorylineType type) {
    switch (type) {
      case StorylineType.corrupt:
        return ['经验 +1200', '银两 +600', '正义勋章', '声望 +200'];
      case StorylineType.protection:
        return ['经验 +1000', '银两 +500', '小翠好感度 +100'];
      case StorylineType.revenge:
        return ['经验 +1500', '银两 +800', '师傅遗物', '特殊技能'];
      case StorylineType.palace:
        return ['经验 +2000', '银两 +1000', '皇帝赏赐', '朝廷声望 +300'];
      case StorylineType.sect:
        return ['经验 +1800', '银两 +900', '掌门令牌', '门派技能'];
      case StorylineType.martial:
        return ['经验 +1500', '银两 +800', '武林盟主令', '江湖声望 +250'];
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

  /// 获取剧情线的前置条件描述
  static List<String> getPrerequisites(StorylineType type) {
    final level = getUnlockLevel(type);
    final prerequisites = <String>['等级达到 Lv.$level'];

    switch (type) {
      case StorylineType.palace:
        prerequisites.add('完成主线任务：初入江湖');
        break;
      case StorylineType.sect:
        prerequisites.add('加入天剑门');
        break;
      case StorylineType.martial:
        prerequisites.add('声望达到 1000');
        break;
      case StorylineType.ancient:
        prerequisites.add('收集古玉碎片 x7');
        break;
      default:
        break;
    }

    return prerequisites;
  }

  /// 格式化剧情进度文本
  static String formatProgress(StorylineProgress progress) {
    final percentage = (calculateProgress(progress) * 100).toInt();
    return '${progress.completedQuestIds.length}/${progress.totalChapters} ($percentage%)';
  }

  /// 获取剧情状态的颜色
  static String getStatusColorHex(StorylineStatus status) {
    switch (status) {
      case StorylineStatus.locked:
        return '#9E9E9E'; // 灰色
      case StorylineStatus.available:
        return '#4CAF50'; // 绿色
      case StorylineStatus.inProgress:
        return '#2196F3'; // 蓝色
      case StorylineStatus.completed:
        return '#FF9800'; // 橙色
    }
  }

  /// 获取剧情类型的图标名称
  static String getIconName(StorylineType type) {
    switch (type) {
      case StorylineType.corrupt:
        return 'gavel';
      case StorylineType.protection:
        return 'shield';
      case StorylineType.revenge:
        return 'flash_on';
      case StorylineType.palace:
        return 'account_balance';
      case StorylineType.sect:
        return 'temple_buddhist';
      case StorylineType.martial:
        return 'emoji_events';
      case StorylineType.demon:
        return 'whatshot';
      case StorylineType.romance:
        return 'favorite';
      case StorylineType.master:
        return 'school';
      case StorylineType.ancient:
        return 'auto_awesome';
    }
  }

  /// 生成剧情摘要
  static String generateSummary(StorylineProgress progress) {
    final type = progress.type;
    final chapter = progress.currentChapter;
    final total = progress.totalChapters;

    if (progress.isCompleted) {
      return '已完成《${type.label}》，达成结局：${progress.endingType ?? "未知"}';
    }

    if (chapter == 0) {
      return '尚未开始《${type.label}》';
    }

    return '正在进行《${type.label}》第 $chapter/$total 章';
  }

  /// 检查是否可以开始剧情
  static bool canStart(
    StorylineType type,
    int characterLevel,
    Map<String, dynamic> characterData,
  ) {
    // 检查等级
    if (characterLevel < getUnlockLevel(type)) {
      return false;
    }

    // 检查特殊前置条件
    switch (type) {
      case StorylineType.sect:
        // 需要加入天剑门
        return characterData['sectId'] == 'tianjian_sect';
      case StorylineType.martial:
        // 需要声望达到1000
        return (characterData['reputation'] ?? 0) >= 1000;
      case StorylineType.ancient:
        // 需要收集古玉碎片
        return (characterData['jadeFragments'] ?? 0) >= 7;
      default:
        return true;
    }
  }

  /// 获取无法开始的原因
  static String? getCannotStartReason(
    StorylineType type,
    int characterLevel,
    Map<String, dynamic> characterData,
  ) {
    if (characterLevel < getUnlockLevel(type)) {
      return '等级不足，需要 Lv.${getUnlockLevel(type)}';
    }

    switch (type) {
      case StorylineType.sect:
        if (characterData['sectId'] != 'tianjian_sect') {
          return '需要先加入天剑门';
        }
        break;
      case StorylineType.martial:
        if ((characterData['reputation'] ?? 0) < 1000) {
          return '声望不足，需要 1000 声望';
        }
        break;
      case StorylineType.ancient:
        if ((characterData['jadeFragments'] ?? 0) < 7) {
          final current = characterData['jadeFragments'] ?? 0;
          return '古玉碎片不足，需要 7 个（当前 $current 个）';
        }
        break;
      default:
        break;
    }

    return null;
  }
}
