import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../animation/arena_controller.dart';
import '../animation/battle_types.dart';
import 'hp_bar_widget.dart';

class WuxiaBattleStage extends StatelessWidget {
  final BattleArenaController controller;
  final BattleActionType? idlePlayerWeaponType;
  final String playerName;
  final String enemyName;
  final int playerMaxHp;
  final int playerMaxMp;
  final int playerCurrentHp;
  final int playerCurrentMp;
  final int enemyMaxHp;
  final int enemyMaxMp;
  final int enemyCurrentHp;
  final int enemyCurrentMp;

  const WuxiaBattleStage({
    super.key,
    required this.controller,
    this.idlePlayerWeaponType,
    required this.playerName,
    required this.enemyName,
    required this.playerMaxHp,
    required this.playerMaxMp,
    required this.playerCurrentHp,
    required this.playerCurrentMp,
    required this.enemyMaxHp,
    required this.enemyMaxMp,
    required this.enemyCurrentHp,
    required this.enemyCurrentMp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.2,
          colors: [
            Color(0xFF2C2520), // Center slightly lighter
            Color(0xFF151312), // Darker edges
          ],
        ),
        border: Border(
          bottom: BorderSide(color: Color(0xFF65503F), width: 2), // Wuxia gold/brown border
        ),
      ),
      child: Stack(
        children: [
          // 1. The Stickman Arena Widget (Transparent background now)
          Positioned.fill(
            child: BattleArenaWidget(
              controller: controller,
              idlePlayerWeaponType: idlePlayerWeaponType,
              height: 260,
            ),
          ),
          
          // 2. HUD: Player HP/MP
          Positioned(
            left: 16,
            top: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  playerName,
                  style: TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    shadows: const [Shadow(color: Colors.black, blurRadius: 4)],
                  ),
                ),
                const SizedBox(height: 8),
                HpBarWidget(
                  currentHp: playerCurrentHp,
                  maxHp: playerMaxHp,
                  currentMp: playerCurrentMp,
                  maxMp: playerMaxMp,
                  isPlayer: true,
                ),
              ],
            ),
          ),

          // 3. HUD: Enemy HP/MP
          Positioned(
            right: 16,
            top: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  enemyName,
                  style: TextStyle(
                    color: AppColors.danger,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    shadows: const [Shadow(color: Colors.black, blurRadius: 4)],
                  ),
                ),
                const SizedBox(height: 8),
                HpBarWidget(
                  currentHp: enemyCurrentHp,
                  maxHp: enemyMaxHp,
                  currentMp: enemyCurrentMp,
                  maxMp: enemyMaxMp,
                  isPlayer: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
