import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../models/enemy.dart';
import '../../models/skill.dart';
import '../character/character_provider.dart';

/// 战斗状态
enum BattlePhase {
  preparation, // 准备阶段
  playerTurn, // 玩家回合
  enemyTurn, // 敌人回合
  victory, // 胜利
  defeat, // 失败
}

/// 战斗动作类型
enum BattleActionType {
  attack, // 普通攻击
  skill, // 使用技能
  item, // 使用物品
  defend, // 防御
  escape, // 逃跑
}

/// 交互式战斗页面
class InteractiveBattlePage extends ConsumerStatefulWidget {
  final Enemy enemy;

  const InteractiveBattlePage({
    super.key,
    required this.enemy,
  });

  @override
  ConsumerState<InteractiveBattlePage> createState() =>
      _InteractiveBattlePageState();
}

class _InteractiveBattlePageState extends ConsumerState<InteractiveBattlePage>
    with TickerProviderStateMixin {
  late int playerHp;
  late int playerMp;
  late int playerMaxHp;
  late int playerMaxMp;
  late int enemyHp;
  late int enemyMaxHp;

  BattlePhase phase = BattlePhase.preparation;
  List<String> battleLog = [];
  bool isDefending = false;
  int turnCount = 0;

  late AnimationController _shakeController;
  late AnimationController _damageController;
  late Animation<double> _shakeAnimation;

  String? selectedSkillId;
  bool showSkillMenu = false;
  bool showItemMenu = false;

  @override
  void initState() {
    super.initState();

    final character = ref.read(currentCharacterProvider).valueOrNull;
    if (character != null) {
      playerMaxHp = character.currentHp;
      playerMaxMp = character.currentMp;
      playerHp = playerMaxHp;
      playerMp = playerMaxMp;
    } else {
      playerMaxHp = 100;
      playerMaxMp = 50;
      playerHp = playerMaxHp;
      playerMp = playerMaxMp;
    }

    enemyMaxHp = widget.enemy.hp;
    enemyHp = enemyMaxHp;

    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _damageController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _shakeAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );

    // 开始战斗
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        phase = BattlePhase.playerTurn;
        _addLog('战斗开始！');
        _addLog('遭遇 ${widget.enemy.name}！');
      });
    });
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _damageController.dispose();
    super.dispose();
  }

  void _addLog(String message) {
    setState(() {
      battleLog.insert(0, message);
      if (battleLog.length > 10) {
        battleLog.removeLast();
      }
    });
  }

  void _performAction(BattleActionType actionType, {String? skillId}) {
    if (phase != BattlePhase.playerTurn) return;

    setState(() {
      phase = BattlePhase.enemyTurn;
      turnCount++;
    });

    switch (actionType) {
      case BattleActionType.attack:
        _performAttack();
        break;
      case BattleActionType.skill:
        if (skillId != null) {
          _performSkill(skillId);
        }
        break;
      case BattleActionType.defend:
        _performDefend();
        break;
      case BattleActionType.item:
        _performItemUse();
        break;
      case BattleActionType.escape:
        _attemptEscape();
        break;
    }
  }

  void _performAttack() {
    final character = ref.read(currentCharacterProvider).valueOrNull;
    final damage = (character?.baseAtk ?? 10) + (5 - 5 * 0.5).toInt();

    _shakeController.forward().then((_) {
      _shakeController.reverse();
    });

    setState(() {
      enemyHp = (enemyHp - damage).clamp(0, enemyMaxHp);
      _addLog('你对 ${widget.enemy.name} 造成了 $damage 点伤害！');
    });

    _checkBattleEnd();
  }

  void _performSkill(String skillId) {
    // 简化的技能使用逻辑
    final mpCost = 10;
    if (playerMp < mpCost) {
      _addLog('内力不足！');
      setState(() {
        phase = BattlePhase.playerTurn;
      });
      return;
    }

    final damage = 30;
    _shakeController.forward().then((_) {
      _shakeController.reverse();
    });

    setState(() {
      playerMp = (playerMp - mpCost).clamp(0, playerMaxMp);
      enemyHp = (enemyHp - damage).clamp(0, enemyMaxHp);
      _addLog('你使用技能对 ${widget.enemy.name} 造成了 $damage 点伤害！');
    });

    _checkBattleEnd();
  }

  void _performDefend() {
    setState(() {
      isDefending = true;
      _addLog('你摆出防御姿态！');
    });
    _enemyTurn();
  }

  void _performItemUse() {
    // 简化的物品使用逻辑
    final healAmount = 30;
    setState(() {
      playerHp = (playerHp + healAmount).clamp(0, playerMaxHp);
      _addLog('你使用了疗伤药，恢复了 $healAmount 点生命！');
    });
    _enemyTurn();
  }

  void _attemptEscape() {
    final escapeChance = 0.5;
    if (escapeChance > 0.5) {
      _addLog('成功逃脱！');
      Navigator.of(context).pop();
    } else {
      _addLog('逃跑失败！');
      _enemyTurn();
    }
  }

  void _checkBattleEnd() {
    if (enemyHp <= 0) {
      setState(() {
        phase = BattlePhase.victory;
        _addLog('战斗胜利！');
      });
      _showVictoryDialog();
    } else {
      _enemyTurn();
    }
  }

  void _enemyTurn() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (phase == BattlePhase.defeat || phase == BattlePhase.victory) return;

      final damage = (widget.enemy.atk * (isDefending ? 0.5 : 1.0)).toInt();

      setState(() {
        playerHp = (playerHp - damage).clamp(0, playerMaxHp);
        _addLog('${widget.enemy.name} 对你造成了 $damage 点伤害！');
        isDefending = false;
      });

      if (playerHp <= 0) {
        setState(() {
          phase = BattlePhase.defeat;
          _addLog('战斗失败...');
        });
        _showDefeatDialog();
      } else {
        setState(() {
          phase = BattlePhase.playerTurn;
        });
      }
    });
  }

  void _showVictoryDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.emoji_events, color: AppColors.warning, size: 32),
            const SizedBox(width: 12),
            const Text('胜利！'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('成功击败了 ${widget.enemy.name}！'),
            const SizedBox(height: 16),
            Text('回合数: $turnCount'),
            Text('获得经验: +${widget.enemy.expReward}'),
            Text('获得银两: +${widget.enemy.silverReward}'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  void _showDefeatDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.close, color: AppColors.danger, size: 32),
            const SizedBox(width: 12),
            const Text('失败'),
          ],
        ),
        content: const Text('你被击败了...'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('战斗 - ${widget.enemy.name}'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // 战斗场景
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.background,
                    AppColors.surface,
                  ],
                ),
              ),
              child: Column(
                children: [
                  // 敌人区域
                  Expanded(
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _shakeAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(_shakeAnimation.value, 0),
                            child: child,
                          );
                        },
                        child: _buildEnemyDisplay(),
                      ),
                    ),
                  ),
                  // 玩家区域
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: _buildPlayerDisplay(),
                  ),
                ],
              ),
            ),
          ),
          // 战斗日志
          Container(
            height: 120,
            color: AppColors.surface,
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '战斗记录',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.accent,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: battleLog.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          battleLog[index],
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                            height: 1.3,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // 操作按钮
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.background,
            child: phase == BattlePhase.playerTurn
                ? _buildActionButtons()
                : _buildWaitingIndicator(),
          ),
        ],
      ),
    );
  }

  Widget _buildEnemyDisplay() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.danger.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.danger, width: 3),
          ),
          child: Center(
            child: Icon(
              Icons.person,
              size: 80,
              color: AppColors.danger,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          widget.enemy.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 8),
        _buildHealthBar(enemyHp, enemyMaxHp, AppColors.danger),
      ],
    );
  }

  Widget _buildPlayerDisplay() {
    final character = ref.watch(currentCharacterProvider).valueOrNull;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          character?.name ?? '玩家',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 8),
        _buildHealthBar(playerHp, playerMaxHp, AppColors.hp),
        const SizedBox(height: 4),
        _buildManaBar(playerMp, playerMaxMp),
      ],
    );
  }

  Widget _buildHealthBar(int current, int max, Color color) {
    final percentage = current / max;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite, size: 16, color: color),
            const SizedBox(width: 6),
            Text(
              '$current / $max',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          width: 200,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withValues(alpha: 0.5)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildManaBar(int current, int max) {
    final percentage = current / max;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.water_drop, size: 16, color: AppColors.mp),
            const SizedBox(width: 6),
            Text(
              '$current / $max',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.mp,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          width: 200,
          height: 16,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.mp.withValues(alpha: 0.5)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.mp),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _performAction(BattleActionType.attack),
                icon: const Icon(Icons.flash_on),
                label: const Text('攻击'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.danger,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    showSkillMenu = !showSkillMenu;
                    showItemMenu = false;
                  });
                },
                icon: const Icon(Icons.auto_awesome),
                label: const Text('技能'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mp,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _performAction(BattleActionType.defend),
                icon: const Icon(Icons.shield),
                label: const Text('防御'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    showItemMenu = !showItemMenu;
                    showSkillMenu = false;
                  });
                },
                icon: const Icon(Icons.inventory),
                label: const Text('物品'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _performAction(BattleActionType.escape),
                icon: const Icon(Icons.directions_run),
                label: const Text('逃跑'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
        if (showSkillMenu) ...[
          const SizedBox(height: 12),
          _buildSkillMenu(),
        ],
        if (showItemMenu) ...[
          const SizedBox(height: 12),
          _buildItemMenu(),
        ],
      ],
    );
  }

  Widget _buildSkillMenu() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primaryLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '选择技能',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildSkillButton('基础剑法', 10, 25),
              _buildSkillButton('疾风斩', 15, 35),
              _buildSkillButton('破甲击', 20, 45),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillButton(String name, int mpCost, int damage) {
    final canUse = playerMp >= mpCost;
    return OutlinedButton(
      onPressed: canUse
          ? () {
              setState(() {
                showSkillMenu = false;
              });
              _performAction(BattleActionType.skill, skillId: name);
            }
          : null,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 12,
              color: canUse ? AppColors.accent : AppColors.textSecondary,
            ),
          ),
          Text(
            'MP $mpCost',
            style: TextStyle(
              fontSize: 10,
              color: canUse ? AppColors.mp : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemMenu() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primaryLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '选择物品',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildItemButton('疗伤药', Icons.healing, () {
                setState(() {
                  showItemMenu = false;
                });
                _performAction(BattleActionType.item);
              }),
              _buildItemButton('回气丹', Icons.water_drop, () {
                setState(() {
                  showItemMenu = false;
                  playerMp = (playerMp + 30).clamp(0, playerMaxMp);
                  _addLog('你使用了回气丹，恢复了 30 点内力！');
                });
                _enemyTurn();
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemButton(String name, IconData icon, VoidCallback onPressed) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(name, style: const TextStyle(fontSize: 12)),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  Widget _buildWaitingIndicator() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: AppColors.accent),
          const SizedBox(height: 12),
          Text(
            phase == BattlePhase.enemyTurn ? '敌人回合...' : '准备中...',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
