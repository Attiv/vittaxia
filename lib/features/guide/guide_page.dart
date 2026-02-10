import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('新手攻略')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(theme, '基本操作', [
            '• 点击底部【探索】触发随机事件，可能遭遇战斗、获得物品或经验',
            '• 点击【地图】可以移动到相邻地点，不同地点有不同的事件和危险等级',
            '• 点击顶部状态栏可查看角色详情',
          ]),
          _section(theme, '战斗', [
            '• 探索时有概率触发战斗事件，选择战斗选项进入回合制对战',
            '• 战斗中点击下方技能按钮释放招式，注意内力消耗',
            '• 速度高的一方先手行动，运气影响暴击率',
            '• 胜利后获得经验、银两，有概率掉落物品',
            '• 战败保底1血，不会死亡',
          ]),
          _section(theme, '技能修炼', [
            '• 进入【技能】页面，点击任意已学技能可以打开修炼面板',
            '• 每次修炼消耗10点内力，增加15点熟练度',
            '• 熟练度满100自动升级，提升技能威力',
            '• 战斗中使用技能也会获得5点熟练度',
            '• 被动技能无法主动修炼',
          ]),
          _section(theme, '任务系统', [
            '• 点击【任务】查看可接取和进行中的任务',
            '• 主线任务推动剧情发展，解锁新地点',
            '• 支线任务提供额外奖励（银两、物品、技能）',
            '• 任务目标包括：击败敌人、收集物品、与NPC对话、到达指定地点',
            '• 目标完成后回到任务页面点击【交付】领取奖励',
          ]),
          _section(theme, '装备与背包', [
            '• 点击【背包】管理物品，可装备武器、防具、鞋子、饰品',
            '• 装备提供攻击、防御、速度等属性加成',
            '• 消耗品（如金创药）可以在背包中直接使用',
          ]),
          _section(theme, 'NPC交谈', [
            '• 点击【交谈】查看当前地点的NPC列表',
            '• 与NPC对话可获得经验、银两、物品甚至新技能',
            '• 部分主线任务需要与特定NPC对话才能推进',
          ]),
          _section(theme, '挂机修炼', [
            '• 关闭游戏即为挂机，下次打开自动结算离线收益',
            '• 离线经验 = 悟性 × 0.5 × 离线分钟数',
            '• 最多累计12小时离线收益',
          ]),
          _section(theme, '境界提升', [
            '• 经验积累到一定程度可提升境界',
            '• 境界路线：练气 → 炼体 → 后天 → 先天 → 筑基',
            '• 每个境界分为初期、中期、后期、巅峰四个阶段',
            '• 高境界解锁更高级的地点（如迷雾谷需要先天境界）',
          ]),
          _section(theme, '新手建议', [
            '1. 先在青云村接取主线任务【黑衣人遗物】',
            '2. 在青云村和青竹林多探索，积累经验和物品',
            '3. 记得装备初始的木棍和粗布衣',
            '4. 战斗前确保气血充足，背包里的金创药可以回血',
            '5. 去技能页面修炼你的武功，提升熟练度',
            '6. 跟着主线走：青云村 → 清风镇 → 望月楼 → 落霞山脉',
          ]),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _section(ThemeData theme, String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.accent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ...items.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
