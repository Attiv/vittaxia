import 'package:flutter/material.dart';

/// 战斗动画动作类型
enum BattleActionType { fist, kick, palm, sword, blade, hidden, heal, buff }

/// 根据技能 ID 推断动画类型
BattleActionType skillToActionType(String skillId) {
  const map = <String, BattleActionType>{
    'basic_fist': BattleActionType.fist,
    'basic_kick': BattleActionType.kick,
    'iron_palm': BattleActionType.palm,
    'mountain_palm': BattleActionType.palm,
    'gale_sword': BattleActionType.sword,
    'jade_bamboo_sword': BattleActionType.sword,
    'shadow_strike': BattleActionType.hidden,
    'swallow_dart': BattleActionType.hidden,
    'tuna_breathing': BattleActionType.heal,
    'golden_bell': BattleActionType.buff,
    'qi_surge': BattleActionType.buff,
    'spring_return': BattleActionType.heal,
    'mist_step': BattleActionType.buff,
    'moongazing_art': BattleActionType.heal,
    'passive_follow_fist': BattleActionType.fist,
    'passive_sweep_kick': BattleActionType.kick,
    'passive_elbow_strike': BattleActionType.fist,
    'passive_iron_body': BattleActionType.fist,
    'passive_palm_strike': BattleActionType.palm,
    'passive_finger_flick': BattleActionType.hidden,
    'passive_hidden_needle': BattleActionType.hidden,
    'passive_sword_qi': BattleActionType.sword,
    'passive_blade_wind': BattleActionType.blade,
    'passive_counter_punch': BattleActionType.fist,
    'passive_shadow_step': BattleActionType.kick,
    'passive_qi_burst': BattleActionType.fist,
  };
  return map[skillId] ?? BattleActionType.fist;
}

Color actionColor(BattleActionType type) {
  switch (type) {
    case BattleActionType.fist:
      return const Color(0xFFFFA53E);
    case BattleActionType.kick:
      return const Color(0xFF8ED2FF);
    case BattleActionType.palm:
      return const Color(0xFFFF7D7D);
    case BattleActionType.sword:
      return const Color(0xFF7AB7FF);
    case BattleActionType.blade:
      return const Color(0xFF7FD7C7);
    case BattleActionType.hidden:
      return const Color(0xFFB7A1FF);
    case BattleActionType.heal:
      return const Color(0xFF79E2A7);
    case BattleActionType.buff:
      return const Color(0xFF65D5FF);
  }
}
