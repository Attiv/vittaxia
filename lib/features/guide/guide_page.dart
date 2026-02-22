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
            '• 熟练度满100自动升级，每级提升5%伤害和回复效果',
            '• 例：Lv.5 的铁砂掌伤害提升20%，Lv.10 提升45%',
            '• 战斗中使用装备的技能也会获得5点熟练度',
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
          _section(theme, '好感度', [
            '• 每位NPC都有独立的好感度（0~100）',
            '• 与NPC对话、选择友善的选项可以增加好感',
            '• 不同的对话选项给的好感不同，有些选项会降低好感',
            '• 好感等级：陌生(0~19) → 相识(20~39) → 友善(40~59) → 亲近(60~79) → 信赖(80~94) → 知己(95~100)',
            '• 好感达到一定值后，NPC会传授特殊技能（尤其是被动武技）',
            '• 多和NPC聊天就行，选择善意的回答，好感自然就上来了',
          ]),
          _section(theme, '挂机修炼', [
            '• 关闭游戏即为挂机，下次打开自动结算离线收益',
            '• 离线经验 = 悟性 × 0.3 × 离线分钟数',
            '• 离线还会带回少量银两与基础补给（粗铁矿/金创药）',
            '• 最多累计12小时离线收益',
          ]),
          _section(theme, '境界提升', [
            '• 经验积累到一定程度可提升境界',
            '• 所需经验 = 境界等级 × 阶段等级 × 100',
            '• 例：初学初期→中期需100经验，小成后期→巅峰需900经验',
            '• 每次突破属性永久增长：气血+15、内力+8、攻击+2、防御+1、速度+1',
            '• 突破后气血内力全满',
            '• 境界路线：初学 → 入门 → 小成 → 大成 → 通脉 → 归元 → 宗师 → 武圣 → 化境',
            '• 每个境界分为初期、中期、后期、巅峰四个阶段',
            '• 高境界解锁更高级的地点（如迷雾谷需要大成境界）',
          ]),
          _section(theme, '被动技能', [
            '• 被动技能在战斗中自动触发，无法手动释放，也无法主动修炼',
            '• 攻击命中后有25%概率触发已学的被动武技，最多触发一个',
            '',
            '【自动习得】',
            '• 后手追拳 —— 初始自带',
            '• 观棋悟道 —— 与陈老头下棋即可领悟',
            '',
            '【NPC传授（需好感度）】',
            '• 掌风余力 —— 张大叔（青云村），好感≥10',
            '• 弹指 —— 陈老头（青云村），好感≥20',
            '• 下盘横扫 —— 柳如烟（清风镇），好感≥10',
            '• 寸肘 —— 孙一手（清风镇），好感≥15',
            '• 袖底飞针 —— 白无常（清风镇），好感≥15',
            '• 剑气余韵 —— 林风（迷雾谷），好感≥20',
            '• 铁布衫 —— 秦铸（落霞山脉），好感≥20',
            '',
            '【支线任务奖励】',
            '• 刀风斩 —— 完成"秦铸的刀谱"（落霞山脉）',
            '• 借力打力 —— 完成"酒馆的教训"（清风镇）',
            '• 踏影追击 —— 完成"月影残卷"（望月楼）',
            '• 真气爆发 —— 完成"雾谷真气试炼"（迷雾谷）',
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
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ...items.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    item,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
