import 'dart:math';

import '../../data/item_data.dart';
import '../../data/npc_data.dart';
import '../../models/enums.dart';
import 'npc_relation_provider.dart';

/// NPC对话生成器
class NpcDialogueGenerator {
  static final _random = Random();

  /// 根据好感度等级生成对话
  static String generateGreeting(String npcId, AffectionLevel level) {
    final npc = npcs[npcId];
    if (npc == null) return '你好。';

    switch (level) {
      case AffectionLevel.stranger:
        return _getStrangerGreeting(npcId);
      case AffectionLevel.acquaintance:
        return _getAcquaintanceGreeting(npcId);
      case AffectionLevel.friend:
        return _getFriendGreeting(npcId);
      case AffectionLevel.close:
        return _getCloseGreeting(npcId);
      case AffectionLevel.confidant:
        return _getConfidantGreeting(npcId);
    }
  }

  static String _getStrangerGreeting(String npcId) {
    final greetings = {
      'zhang_dashu': '嗯？你是谁？',
      'li_yaopo': '有什么事吗？',
      'chen_laotou': '...(老头没有抬头)',
      'liu_ruyan': '客官，需要点什么？',
      'sun_yishou': '买东西还是看热闹？',
      'bai_wuchang': '这位少侠面生得很啊。',
      'su_wanyin': '...(她只是淡淡地看了你一眼)',
      'qin_zhu': '不要打扰我。',
      'lin_feng': '你是谁？',
    };
    return greetings[npcId] ?? '你好。';
  }

  static String _getAcquaintanceGreeting(String npcId) {
    final greetings = {
      'zhang_dashu': '哦，是你啊。',
      'li_yaopo': '又来了？身体还好吧？',
      'chen_laotou': '嗯，来了。',
      'liu_ruyan': '哎呀，是你啊！',
      'sun_yishou': '又来了？',
      'bai_wuchang': '少侠又来听书了？',
      'su_wanyin': '你来了。',
      'qin_zhu': '有事？',
      'lin_feng': '是你。',
    };
    return greetings[npcId] ?? '你好。';
  }

  static String _getFriendGreeting(String npcId) {
    final greetings = {
      'zhang_dashu': '小子，来了！最近怎么样？',
      'li_yaopo': '哎呀，来啦！快坐快坐。',
      'chen_laotou': '来下盘棋？',
      'liu_ruyan': '你来啦！正想找你呢。',
      'sun_yishou': '哈哈，来得正好！',
      'bai_wuchang': '老朋友来了！今天想听什么故事？',
      'su_wanyin': '你来了，正好，我有些话想和你说。',
      'qin_zhu': '来得正好，帮我个忙。',
      'lin_feng': '兄弟，来了！',
    };
    return greetings[npcId] ?? '你好，朋友。';
  }

  static String _getCloseGreeting(String npcId) {
    final greetings = {
      'zhang_dashu': '哈哈，我就知道你会来！来来来，大叔给你看个好东西。',
      'li_yaopo': '哎呀我的好孩子，快让婆婆看看，最近有没有受伤？',
      'chen_laotou': '来了？正好，我悟出了一招新棋路，你来看看。',
      'liu_ruyan': '你终于来了！我等你好久了呢。',
      'sun_yishou': '兄弟！来得正好，我刚打了把好刀！',
      'bai_wuchang': '哈哈，我的知音来了！今天我要讲个特别的故事给你听。',
      'su_wanyin': '你来了...我一直在等你。',
      'qin_zhu': '你来了。我有个想法，想和你商量商量。',
      'lin_feng': '兄弟！我正想找你！',
    };
    return greetings[npcId] ?? '你来了，我很高兴。';
  }

  static String _getConfidantGreeting(String npcId) {
    final greetings = {
      'zhang_dashu': '孩子，你来了。大叔有些话，一直想对你说...',
      'li_yaopo': '我的好孩子，你就像婆婆的亲孙子一样。来，婆婆给你准备了好东西。',
      'chen_laotou': '你来了。我这一生，能遇到你这样的知己，也算不虚此行了。',
      'liu_ruyan': '你来了...其实，我有件事一直没告诉你...',
      'sun_yishou': '兄弟！我这辈子没几个真朋友，你算一个！',
      'bai_wuchang': '老友，今天我要告诉你一个秘密，一个关于江湖的秘密...',
      'su_wanyin': '你终于来了...我等你很久了。有些事，我想只有你能帮我。',
      'qin_zhu': '你来了。我决定了，这把剑，我要为你而铸。',
      'lin_feng': '兄弟，我把你当生死之交。今天，我要告诉你我的秘密...',
    };
    return greetings[npcId] ?? '我的挚友，你来了。';
  }

  /// 生成闲聊对话
  static List<String> generateChatDialogue(String npcId, AffectionLevel level) {
    final topics = _getChatTopics(npcId, level);
    if (topics.isEmpty) return ['...'];
    return [topics[_random.nextInt(topics.length)]];
  }

  static List<String> _getChatTopics(String npcId, AffectionLevel level) {
    // 根据NPC和好感度等级返回不同的话题
    final allTopics = {
      'zhang_dashu': [
        '最近山里的野兽越来越多了，你出门要小心。',
        '我年轻的时候啊，也是个好猎手...',
        '村里的年轻人都出去闯荡了，只剩下我们这些老家伙。',
        if (level.level >= 2) '其实我年轻时也练过武，只是后来放弃了。',
        if (level.level >= 3) '你知道吗？这村子以前可不简单...',
        if (level.level >= 4) '孩子，我看你骨骼清奇，是个练武的好苗子。我有一套拳法，想传给你。',
      ],
      'li_yaopo': [
        '这些草药都是我亲手采的，保证新鲜。',
        '年轻人要注意身体，别总是熬夜。',
        '我这里有些治疗跌打损伤的药，你要不要？',
        if (level.level >= 2) '其实我年轻时也是个江湖人，只是后来隐退了。',
        if (level.level >= 3) '你知道碧心草的真正用法吗？我教你。',
        if (level.level >= 4) '孩子，婆婆有个秘方，一直没传给别人。今天就教给你吧。',
      ],
      'chen_laotou': [
        '...(老头在专心下棋)',
        '这盘棋，我已经想了三天了。',
        '棋如人生，一步错，步步错。',
        if (level.level >= 2) '你也懂棋？来，陪我下一盘。',
        if (level.level >= 3) '棋道与武道，其实是相通的。',
        if (level.level >= 4) '我这一生，只求一败。可惜，至今未遇敌手。',
      ],
      'liu_ruyan': [
        '最近生意还不错，多亏了你的帮忙。',
        '你要不要尝尝我们的招牌菜？',
        '镇上最近来了不少江湖人，不知道有什么大事要发生。',
        if (level.level >= 2) '其实我也会些拳脚功夫，以前跟父亲学的。',
        if (level.level >= 3) '你知道吗？我父亲以前是镖师...',
        if (level.level >= 4) '我一直有个心愿，想找到父亲当年的仇人...',
      ],
      'sun_yishou': [
        '打铁这活儿，没个十年八年的功夫，是学不会的。',
        '你这兵器该保养了，来，我帮你看看。',
        '好铁配好匠，好匠配好铁！',
        if (level.level >= 2) '你知道寒铁矿吗？那可是好东西！',
        if (level.level >= 3) '我这辈子的梦想，就是铸一把神兵利器。',
        if (level.level >= 4) '兄弟，我决定了，要为你打造一把绝世好剑！',
      ],
      'bai_wuchang': [
        '江湖之大，无奇不有。',
        '今天我要讲一个关于剑仙的故事...',
        '你听说过"天剑门"吗？',
        if (level.level >= 2) '其实我也是江湖中人，只是现在隐退了。',
        if (level.level >= 3) '你想知道古玉的秘密吗？',
        if (level.level >= 4) '我知道一个秘密，关于藏剑阁的秘密...',
      ],
      'su_wanyin': [
        '月色真美。',
        '你喜欢听琴吗？',
        '这首曲子，是我自己作的。',
        if (level.level >= 2) '你是第一个能听懂我琴声的人。',
        if (level.level >= 3) '其实我一直在寻找一个人...',
        if (level.level >= 4) '我要告诉你一个秘密，关于我的身世...',
      ],
      'qin_zhu': [
        '铸剑是一门艺术。',
        '好剑需要好材料。',
        '我这辈子，只想铸一把绝世好剑。',
        if (level.level >= 2) '你帮我找些寒铁矿吧。',
        if (level.level >= 3) '其实我年轻时也是个剑客...',
        if (level.level >= 4) '我决定了，要为你铸一把剑，一把只属于你的剑。',
      ],
      'lin_feng': [
        '这雾太浓了，我迷路了。',
        '你知道怎么走出这里吗？',
        '我在寻找一样东西...',
        if (level.level >= 2) '其实我是天剑门的弟子。',
        if (level.level >= 3) '我在寻找一把剑，一把失落的神剑。',
        if (level.level >= 4) '兄弟，我要告诉你一个秘密，关于天剑门的秘密...',
      ],
    };

    return allTopics[npcId] ?? ['...'];
  }

  /// 生成送礼反应
  static String generateGiftResponse(String npcId, String itemId, AffectionLevel level) {
    final item = items[itemId];
    if (item == null) return '谢谢。';

    final npc = npcs[npcId];
    if (npc == null) return '谢谢。';

    // 根据物品类型和NPC喜好生成不同反应
    if (_isNpcFavoriteItem(npcId, itemId)) {
      return _getFavoriteItemResponse(npcId, level);
    } else if (item.rarity.rank >= ItemRarity.rare.rank) {
      return _getRareItemResponse(npcId, level);
    } else {
      return _getCommonItemResponse(npcId, level);
    }
  }

  static bool _isNpcFavoriteItem(String npcId, String itemId) {
    final favorites = {
      'zhang_dashu': ['healing_pill', 'stamina_pill'],
      'li_yaopo': ['bixin_herb', 'moonflower', 'tianxing_stone'],
      'chen_laotou': ['tianxing_stone', 'jade_pendant'],
      'liu_ruyan': ['moonflower', 'jade_pendant'],
      'sun_yishou': ['cold_iron', 'star_iron', 'fine_iron'],
      'bai_wuchang': ['jade_pendant', 'ancient_jade'],
      'su_wanyin': ['moonflower', 'jade_pendant'],
      'qin_zhu': ['cold_iron', 'star_iron'],
      'lin_feng': ['spirit_pill', 'tianxing_stone'],
    };

    return favorites[npcId]?.contains(itemId) ?? false;
  }

  static String _getFavoriteItemResponse(String npcId, AffectionLevel level) {
    final responses = {
      'zhang_dashu': '哈哈！这正是我需要的！你真是有心了！',
      'li_yaopo': '哎呀！这可是好东西！你怎么知道我正需要这个？',
      'chen_laotou': '嗯...不错，正合我意。',
      'liu_ruyan': '天啊！这是我最喜欢的！你太了解我了！',
      'sun_yishou': '好东西！好东西！兄弟，你真是我的知音！',
      'bai_wuchang': '妙啊！这正是我想要的！',
      'su_wanyin': '这是...你怎么知道我喜欢这个？',
      'qin_zhu': '好材料！有了这个，我就能铸出更好的剑了！',
      'lin_feng': '兄弟，你真是太够意思了！',
    };
    return responses[npcId] ?? '太好了！这正是我想要的！';
  }

  static String _getRareItemResponse(String npcId, AffectionLevel level) {
    if (level.level >= 3) {
      return '这么贵重的东西...我不能白要。这样吧，我也送你点东西。';
    } else {
      return '这...太贵重了，我不能收。';
    }
  }

  static String _getCommonItemResponse(String npcId, AffectionLevel level) {
    return '谢谢，我收下了。';
  }
}
