import '../models/enums.dart';
import '../models/game_event_data.dart';

/// 所有随机事件数据
final gameEvents = <String, GameEventData>{
  // ===== 青云村 =====
  'qy_herb_picking': const GameEventData(
    id: 'qy_herb_picking',
    name: '采药',
    description: '你在村后的山坡上发现了一丛草药，看起来品相不错。',
    type: GameEventType.treasure,
    weight: 15,
    rewardExp: 5,
    choices: [
      EventChoice(
        text: '小心采集',
        resultText: '你仔细辨认后采下几株，是常见的金银花。',
        rewardExp: 5,
      ),
      EventChoice(
        text: '大把薅走',
        resultText: '你连根拔起，结果惊动了旁边的马蜂窝！',
        hpChange: -10,
        rewardExp: 2,
      ),
    ],
  ),
  'qy_old_man_story': const GameEventData(
    id: 'qy_old_man_story',
    name: '老人的故事',
    description: '老槐树下，一位白发老者正在给孩童们讲江湖故事。你驻足倾听。',
    type: GameEventType.scenery,
    weight: 10,
    rewardExp: 8,
    choices: [
      EventChoice(
        text: '认真听讲',
        resultText: '老者讲述了一段关于"天剑门"的传奇，你若有所悟。',
        rewardExp: 10,
      ),
      EventChoice(
        text: '随意听听',
        resultText: '你心不在焉，只记住了些零碎片段。',
        rewardExp: 3,
      ),
    ],
  ),
  'qy_chicken_chase': const GameEventData(
    id: 'qy_chicken_chase',
    name: '追鸡',
    description: '张大婶家的鸡跑了出来，她急得团团转。',
    type: GameEventType.npcEncounter,
    weight: 8,
    choices: [
      EventChoice(
        text: '帮忙抓鸡',
        resultText: '你费了一番功夫终于抓住了那只鸡，张大婶感激地给了你几文钱。',
        rewardSilver: 5,
        rewardExp: 3,
      ),
      EventChoice(
        text: '视而不见',
        resultText: '你从旁边走过，装作没看见。',
      ),
    ],
  ),
  'qy_mysterious_traveler': const GameEventData(
    id: 'qy_mysterious_traveler',
    name: '神秘旅人',
    description: '一个蒙面旅人在村口歇脚，身上气息非同一般。',
    type: GameEventType.adventure,
    weight: 5,
    choices: [
      EventChoice(
        text: '上前搭话',
        resultText: '旅人打量了你一眼，指点了你几招基本拳法，你受益良多。',
        rewardExp: 20,
      ),
      EventChoice(
        text: '远远观察',
        resultText: '旅人喝完水后便离去了，你隐约看见他衣襟上绣着一把剑。',
        rewardExp: 5,
      ),
    ],
  ),
  'qy_wild_dog': const GameEventData(
    id: 'qy_wild_dog',
    name: '野狗袭击',
    description: '一条凶猛的野狗从草丛中窜出，龇牙咧嘴朝你扑来！',
    type: GameEventType.battle,
    weight: 6,
    choices: [
      EventChoice(
        text: '挥拳驱赶',
        resultText: '野狗不退反进，看来非打不可了。',
        triggerBattle: true,
        enemyId: 'wild_dog',
      ),
      EventChoice(
        text: '捡石头吓走',
        resultText: '你抄起一块石头扔过去，野狗嗷了一声跑开了。',
        rewardExp: 3,
      ),
    ],
  ),

  // ===== 清风镇 =====
  'qf_street_fight': const GameEventData(
    id: 'qf_street_fight',
    name: '街头斗殴',
    description: '两个醉汉在酒楼门口争吵，眼看就要动手。',
    type: GameEventType.battle,
    weight: 10,
    choices: [
      EventChoice(
        text: '上前劝架',
        resultText: '你好言相劝，其中一人却朝你挥拳！',
        triggerBattle: true,
        enemyId: 'drunkard',
      ),
      EventChoice(
        text: '绕道走开',
        resultText: '你摇摇头，不想惹麻烦。',
        rewardExp: 2,
      ),
    ],
  ),
  'qf_merchant_deal': const GameEventData(
    id: 'qf_merchant_deal',
    name: '行商交易',
    description: '一个外地商人正在街边摆摊，有些稀奇玩意。',
    type: GameEventType.merchant,
    weight: 10,
    choices: [
      EventChoice(
        text: '看看货物',
        resultText: '你翻看了一番，发现了一瓶还不错的金创药。',
        rewardItemId: 'healing_pill',
      ),
      EventChoice(
        text: '不感兴趣',
        resultText: '你瞥了一眼便走开了。',
      ),
    ],
  ),
  'qf_rumor': const GameEventData(
    id: 'qf_rumor',
    name: '小道消息',
    description: '茶馆里几个茶客在窃窃私语，似乎在讨论什么大事。',
    type: GameEventType.npcEncounter,
    weight: 15,
    choices: [
      EventChoice(
        text: '凑近偷听',
        resultText: '你听到他们在谈论落霞山脉的山贼最近活动频繁，据说抢了一批很值钱的货物。',
        rewardExp: 8,
      ),
      EventChoice(
        text: '自顾喝茶',
        resultText: '你淡然品茶，不理闲事。',
        rewardExp: 2,
      ),
    ],
  ),
  'qf_pickpocket': const GameEventData(
    id: 'qf_pickpocket',
    name: '小偷',
    description: '你感觉有人在碰你的钱袋！',
    type: GameEventType.trap,
    weight: 6,
    choices: [
      EventChoice(
        text: '反手擒住',
        resultText: '你一把抓住那只手，是个小毛贼。他吓得连忙求饶，还掉出了几两碎银。',
        rewardSilver: 10,
        rewardExp: 5,
      ),
      EventChoice(
        text: '大喊抓贼',
        resultText: '小偷撒腿就跑，你追了几步没追上。好在钱袋还在。',
        rewardExp: 2,
      ),
    ],
  ),
  'qf_wine_contest': const GameEventData(
    id: 'qf_wine_contest',
    name: '醉仙楼斗酒',
    description: '醉仙楼今日有斗酒大会，胜者可获丰厚奖赏。',
    type: GameEventType.adventure,
    weight: 5,
    choices: [
      EventChoice(
        text: '参加比赛',
        resultText: '你连喝三碗，虽然没拿第一，但也获得了掌柜的赏识。',
        rewardSilver: 15,
        rewardExp: 10,
        hpChange: -5,
      ),
      EventChoice(
        text: '在旁观看',
        resultText: '你看着几个彪形大汉你来我往，好不热闹。',
        rewardExp: 3,
      ),
    ],
  ),
  'qf_night_patrol': const GameEventData(
    id: 'qf_night_patrol',
    name: '夜巡缉闹',
    description: '夜色渐深，街口又有醉汉拍桌吵闹，几名镇民正愁没人压场。',
    type: GameEventType.battle,
    weight: 7,
    choices: [
      EventChoice(
        text: '上前制止',
        resultText: '你才开口劝阻，对方就抄起酒坛扑了上来！',
        triggerBattle: true,
        enemyId: 'drunkard',
      ),
      EventChoice(
        text: '护送镇民离开',
        resultText: '你先把镇民送到巷口，再折回时闹事者已经散去。',
        rewardExp: 6,
      ),
    ],
  ),
  'qf_story_fragment': const GameEventData(
    id: 'qf_story_fragment',
    name: '茶馆残页',
    description: '茶馆角落里压着一页旧抄本，字迹提到了"引路钥"和星铁。',
    type: GameEventType.npcEncounter,
    weight: 10,
    choices: [
      EventChoice(
        text: '拿去请白无常辨认',
        resultText: '白无常看后点头，说这正是旧闻缺页。你顺手记下了几个关键地名。',
        rewardExp: 12,
      ),
      EventChoice(
        text: '自己揣摩',
        resultText: '你连猜带蒙读懂了半段话，虽不通透，却也补上了些线索。',
        rewardExp: 6,
      ),
    ],
  ),
  'qf_blacksmith_invoice': const GameEventData(
    id: 'qf_blacksmith_invoice',
    name: '铁铺催单',
    description: '铁铺伙计抱着账册一路小跑，嘴里念叨着"寒铁再不到就要误期了"。',
    type: GameEventType.npcEncounter,
    weight: 10,
    choices: [
      EventChoice(
        text: '帮他跑一趟',
        resultText: '你替他把催单送到库房，顺道听明白了缺料原委。',
        rewardExp: 9,
        rewardSilver: 6,
      ),
      EventChoice(
        text: '记下需求',
        resultText: '你默记下"寒铁矿两块"的需求，准备回头去山里碰碰运气。',
        rewardExp: 7,
      ),
    ],
  ),
  'qf_gate_rumor_update': const GameEventData(
    id: 'qf_gate_rumor_update',
    name: '剑门传闻续篇',
    description: '两名过路镖师正在谈论天剑门外的新规，言辞间颇多戒备之意。',
    type: GameEventType.npcEncounter,
    weight: 8,
    choices: [
      EventChoice(
        text: '细问外门动静',
        resultText: '你问出几条外门换岗时段，正好能作为试帖前的参考。',
        rewardExp: 11,
      ),
      EventChoice(
        text: '只听不问',
        resultText: '你不动声色地听完，记住了"外阶巡守加密"这条关键信息。',
        rewardExp: 6,
      ),
    ],
  ),

  // ===== 青竹林 =====
  'qz_wild_boar': const GameEventData(
    id: 'qz_wild_boar',
    name: '野猪拦路',
    description: '一头野猪从竹林中冲了出来，气势汹汹地朝你冲来！',
    type: GameEventType.battle,
    weight: 12,
    choices: [
      EventChoice(
        text: '迎战',
        resultText: '你摆好架势，准备和野猪一较高下。',
        triggerBattle: true,
        enemyId: 'wild_boar',
      ),
      EventChoice(
        text: '爬上竹子',
        resultText: '你灵巧地攀上旁边的竹子，野猪在下面转了几圈后愤愤离去。',
        rewardExp: 5,
      ),
    ],
  ),
  'qz_herb_find': const GameEventData(
    id: 'qz_herb_find',
    name: '珍稀药材',
    description: '在一棵古竹根部，你发现了一株碧绿的草药，散发着淡淡清香。',
    type: GameEventType.treasure,
    weight: 8,
    rewardItemId: 'bixin_herb',
    rewardExp: 10,
    choices: [
      EventChoice(
        text: '采集药材',
        resultText: '你小心翼翼地将这株碧心草收入囊中。',
        rewardItemId: 'bixin_herb',
        rewardExp: 10,
      ),
      EventChoice(
        text: '做个标记以后再来',
        resultText: '你在附近的竹子上刻了个记号。',
        rewardExp: 3,
      ),
    ],
  ),
  'qz_bamboo_training': const GameEventData(
    id: 'qz_bamboo_training',
    name: '竹林悟剑',
    description: '风吹竹林沙沙作响，你突然对剑意有了些许感悟。',
    type: GameEventType.scenery,
    weight: 10,
    rewardExp: 15,
    choices: [
      EventChoice(
        text: '静心感悟',
        resultText: '你闭目凝神，感受竹叶随风起舞的韵律，似有所悟。',
        rewardExp: 15,
      ),
      EventChoice(
        text: '随手比划几下',
        resultText: '你挥了挥手中的棍子，感觉好像有点什么，又好像没有。',
        rewardExp: 5,
      ),
    ],
  ),
  'qz_hidden_cave': const GameEventData(
    id: 'qz_hidden_cave',
    name: '隐蔽洞穴',
    description: '你推开茂密的竹子，发现了一个被藤蔓遮盖的洞穴入口。',
    type: GameEventType.adventure,
    weight: 4,
    choices: [
      EventChoice(
        text: '进去看看',
        resultText: '洞中有人居住过的痕迹，角落里有个落灰的木箱。你打开一看，里面有些银两和一本泛黄的册子。',
        rewardSilver: 30,
        rewardExp: 20,
      ),
      EventChoice(
        text: '太黑了不敢进',
        resultText: '你犹豫再三，还是退了出来。',
        rewardExp: 2,
      ),
    ],
  ),
  'qz_snake_encounter': const GameEventData(
    id: 'qz_snake_encounter',
    name: '毒蛇',
    description: '脚下传来嘶嘶声，一条青蛇正盯着你！',
    type: GameEventType.trap,
    weight: 7,
    choices: [
      EventChoice(
        text: '一棍打飞',
        resultText: '你眼疾手快一棍子将蛇扫开，虚惊一场。',
        rewardExp: 8,
      ),
      EventChoice(
        text: '缓缓后退',
        resultText: '你慢慢退开，青蛇也没追来，但你出了一身冷汗。',
        rewardExp: 3,
      ),
    ],
  ),
  'qz_starfall_fragment': const GameEventData(
    id: 'qz_starfall_fragment',
    name: '坠星碎片',
    description: '竹林深处有一块发着微光的石头半埋在土里，表面像夜空般斑驳。',
    type: GameEventType.treasure,
    weight: 4,
    choices: [
      EventChoice(
        text: '小心挖出',
        resultText: '你顺着裂隙一点点掘开，取到了一块天星石。',
        rewardItemId: 'tianxing_stone',
        rewardExp: 12,
      ),
      EventChoice(
        text: '暂且放过',
        resultText: '你担心这是诱饵，没有贸然下手。',
        rewardExp: 3,
      ),
    ],
  ),

  // ===== 望月楼 =====
  'wy_moonlight_practice': const GameEventData(
    id: 'wy_moonlight_practice',
    name: '月下修炼',
    description: '望月楼上月光皎洁，是个修炼内功的好时机。',
    type: GameEventType.scenery,
    weight: 10,
    rewardExp: 20,
    choices: [
      EventChoice(
        text: '盘膝打坐',
        resultText: '你在月光下吐纳真气，感觉经脉通畅了许多。',
        rewardExp: 25,
      ),
      EventChoice(
        text: '欣赏月色',
        resultText: '月色如水，你心旷神怡。',
        rewardExp: 5,
      ),
    ],
  ),
  'wy_ancient_scroll': const GameEventData(
    id: 'wy_ancient_scroll',
    name: '古卷残页',
    description: '你在楼梯角落发现了一张泛黄的纸片，上面写着些看不太懂的文字。',
    type: GameEventType.treasure,
    weight: 5,
    choices: [
      EventChoice(
        text: '仔细辨认',
        resultText: '你费了好大功夫才认出几个字，似乎是某种心法的残篇。虽然不完整，但你也有所收获。',
        rewardExp: 30,
      ),
      EventChoice(
        text: '收起来以后再看',
        resultText: '你将纸片小心折好放入怀中。',
        rewardExp: 5,
      ),
    ],
  ),
  'wy_spirit_test': const GameEventData(
    id: 'wy_spirit_test',
    name: '心魔考验',
    description: '你突然感到一阵眩晕，眼前出现了各种幻象——金银财宝、绝世武功、倾国倾城……',
    type: GameEventType.adventure,
    weight: 3,
    choices: [
      EventChoice(
        text: '坚守本心',
        resultText: '你咬紧牙关闭上双眼，心中默念"万法皆空"。幻象渐渐消散，你感到心境提升了一层。',
        rewardExp: 40,
      ),
      EventChoice(
        text: '沉浸其中',
        resultText: '你被幻象迷惑，等回过神来已经过了许久，而且头痛欲裂。',
        hpChange: -20,
        rewardExp: 10,
      ),
    ],
  ),
  'wy_shadow_duel': const GameEventData(
    id: 'wy_shadow_duel',
    name: '暗影来袭',
    description: '月色中一道黑影从楼顶掠下，手持短刃直奔你而来！',
    type: GameEventType.battle,
    weight: 5,
    choices: [
      EventChoice(
        text: '拔刀迎敌',
        resultText: '你侧身闪过第一击，拉开架势准备迎战。',
        triggerBattle: true,
        enemyId: 'shadow_assassin',
      ),
      EventChoice(
        text: '翻窗逃离',
        resultText: '你跃出窗外，黑影追了几步便放弃了，但你摔伤了腿。',
        hpChange: -15,
        rewardExp: 8,
      ),
    ],
  ),
  'wy_moonflower_bloom': const GameEventData(
    id: 'wy_moonflower_bloom',
    name: '月见花开',
    description: '楼外石阶边有几朵银白花在月光下绽放，花香清冽。',
    type: GameEventType.treasure,
    weight: 8,
    choices: [
      EventChoice(
        text: '采下一朵',
        resultText: '你趁花未谢时摘下一朵月见花，花瓣还带着露水。',
        rewardItemId: 'moonflower',
        rewardExp: 10,
      ),
      EventChoice(
        text: '只观不取',
        resultText: '你只是静静看着花开花落，心神渐宁。',
        rewardExp: 6,
      ),
    ],
  ),

  // ===== 落霞山脉 =====
  'lx_bandit_ambush': const GameEventData(
    id: 'lx_bandit_ambush',
    name: '山贼伏击',
    description: '前方山路突然跳出几个蒙面人，为首的嚷道："此路是我开，留下买路财！"',
    type: GameEventType.battle,
    weight: 15,
    choices: [
      EventChoice(
        text: '拔刀相迎',
        resultText: '你握紧兵器，准备和山贼决一死战。',
        triggerBattle: true,
        enemyId: 'bandit',
      ),
      EventChoice(
        text: '给点银子打发',
        resultText: '你掏出一些碎银递过去，山贼们嘿嘿笑着收下，放你过去了。',
        rewardExp: 5,
      ),
    ],
  ),
  'lx_cliff_treasure': const GameEventData(
    id: 'lx_cliff_treasure',
    name: '悬崖宝箱',
    description: '你在一处悬崖边发现了一个半露的箱子，似乎是被人藏在这里的。',
    type: GameEventType.treasure,
    weight: 8,
    choices: [
      EventChoice(
        text: '冒险取箱',
        resultText: '你小心翼翼地攀到悬崖边，打开箱子发现了一些银两和一颗回春丹。',
        rewardSilver: 50,
        rewardItemId: 'healing_pill',
        rewardExp: 15,
      ),
      EventChoice(
        text: '太危险了',
        resultText: '你看了看脚下万丈深渊，理智战胜了贪念。',
        rewardExp: 3,
      ),
    ],
  ),
  'lx_eagle_encounter': const GameEventData(
    id: 'lx_eagle_encounter',
    name: '雄鹰翱翔',
    description: '一只苍鹰在山巅盘旋，它的飞行姿态竟让你联想到了某种轻功身法。',
    type: GameEventType.scenery,
    weight: 12,
    rewardExp: 12,
    choices: [
      EventChoice(
        text: '模仿鹰姿',
        resultText: '你张开双臂模仿苍鹰的姿态，竟对身法有了新的理解。',
        rewardExp: 18,
      ),
      EventChoice(
        text: '驻足观赏',
        resultText: '苍鹰振翅高飞，消失在云端。壮哉！',
        rewardExp: 5,
      ),
    ],
  ),
  'lx_hermit_hut': const GameEventData(
    id: 'lx_hermit_hut',
    name: '山中小屋',
    description: '在一处偏僻的山坳里，你发现了一间破旧的茅屋。',
    type: GameEventType.adventure,
    weight: 8,
    choices: [
      EventChoice(
        text: '敲门拜访',
        resultText: '无人应答。你推门进去，发现墙上刻着几招剑法的图示。你仔细研究，受益匪浅。',
        rewardExp: 25,
      ),
      EventChoice(
        text: '不打扰',
        resultText: '你在门外行了一礼便离开了。',
        rewardExp: 3,
      ),
    ],
  ),
  'lx_bandit_camp': const GameEventData(
    id: 'lx_bandit_camp',
    name: '山贼营地',
    description: '你远远望见几顶帐篷和升起的炊烟，那是山贼的营地。',
    type: GameEventType.battle,
    weight: 8,
    choices: [
      EventChoice(
        text: '夜袭营地',
        resultText: '你趁夜色摸进营地，却被放哨的发现了！',
        triggerBattle: true,
        enemyId: 'bandit_leader',
      ),
      EventChoice(
        text: '绕路走',
        resultText: '你谨慎地选择了另一条路，多花了些时间但平安无事。',
        rewardExp: 5,
      ),
    ],
  ),
  'lx_cold_iron_vein': const GameEventData(
    id: 'lx_cold_iron_vein',
    name: '寒铁矿脉',
    description: '山壁裂缝中透出丝丝寒气，像是埋着极罕见的矿石。',
    type: GameEventType.treasure,
    weight: 5,
    choices: [
      EventChoice(
        text: '凿开矿壁',
        resultText: '你顶着寒气凿开矿层，取到一块寒铁矿。',
        rewardItemId: 'cold_iron',
        rewardExp: 14,
      ),
      EventChoice(
        text: '先记位置',
        resultText: '你担心动静太大引来山贼，只做了标记。',
        rewardExp: 4,
      ),
    ],
  ),
  'lx_mine_trail_cleanup': const GameEventData(
    id: 'lx_mine_trail_cleanup',
    name: '矿路清障',
    description: '矿路边散落着断木与旧陷索，显然是残党留下的阻路手段。',
    type: GameEventType.adventure,
    weight: 7,
    choices: [
      EventChoice(
        text: '动手清理',
        resultText: '你把路障一一拆掉，还顺手补了几处落石警示，后续运矿顺畅不少。',
        rewardExp: 14,
        rewardSilver: 8,
      ),
      EventChoice(
        text: '先做标记',
        resultText: '你在图纸上记下危险点，准备下次带齐工具再处理。',
        rewardExp: 7,
      ),
    ],
  ),
  'lx_forge_supply_cache': const GameEventData(
    id: 'lx_forge_supply_cache',
    name: '炉料旧藏',
    description: '峭壁凹槽里藏着几包封蜡炉料，标签上写着“秦氏旧库”。',
    type: GameEventType.treasure,
    weight: 5,
    choices: [
      EventChoice(
        text: '带回矿营',
        resultText: '你把旧藏打包带走，里面夹着一块打磨过的星陨铁胚。',
        rewardItemId: 'star_iron',
        rewardExp: 15,
      ),
      EventChoice(
        text: '封存待取',
        resultText: '你确认位置后重新封好，避免被山贼余党发现。',
        rewardExp: 6,
      ),
    ],
  ),

  // ===== 迷雾谷 =====
  'mw_fog_illusion': const GameEventData(
    id: 'mw_fog_illusion',
    name: '迷雾幻象',
    description: '浓雾中你看到了一个熟悉的身影，但你知道那不可能是真的。',
    type: GameEventType.trap,
    weight: 10,
    choices: [
      EventChoice(
        text: '闭目前行',
        resultText: '你闭上眼睛凭借感知前进，幻象消散了。',
        rewardExp: 20,
      ),
      EventChoice(
        text: '追上去看看',
        resultText: '你追了上去，却一脚踩空摔了一跤。',
        hpChange: -15,
        rewardExp: 5,
      ),
    ],
  ),
  'mw_ghost_encounter': const GameEventData(
    id: 'mw_ghost_encounter',
    name: '幽魂',
    description: '雾中传来低沉的哭声，你感到一股寒意袭来。',
    type: GameEventType.battle,
    weight: 8,
    choices: [
      EventChoice(
        text: '运功驱邪',
        resultText: '你催动体内真气，形成一道气墙。哭声渐渐远去。',
        rewardExp: 25,
      ),
      EventChoice(
        text: '拔刀迎战',
        resultText: '一团幽绿的雾气凝聚成人形，向你扑来！',
        triggerBattle: true,
        enemyId: 'ghost',
      ),
      EventChoice(
        text: '快步逃离',
        resultText: '你撒腿就跑，也不知跑了多远才停下来，气喘吁吁。',
        hpChange: -10,
        rewardExp: 8,
      ),
    ],
  ),
  'mw_ancient_tomb': const GameEventData(
    id: 'mw_ancient_tomb',
    name: '古墓入口',
    description: '雾气散开的一瞬间，你看到了一座布满青苔的石门。',
    type: GameEventType.adventure,
    weight: 8,
    choices: [
      EventChoice(
        text: '推门进入',
        resultText: '墓中机关重重，你好不容易才找到一间石室。石壁上刻着一套上乘内功心法！',
        rewardExp: 50,
        hpChange: -20,
      ),
      EventChoice(
        text: '记下位置',
        resultText: '你在地上做了标记，打算日后准备充分再来。',
        rewardExp: 5,
      ),
    ],
  ),
  'mw_poison_trap': const GameEventData(
    id: 'mw_poison_trap',
    name: '毒雾陷阱',
    description: '你踩到了一处暗板，四周突然涌出一股紫色的烟雾！',
    type: GameEventType.trap,
    weight: 10,
    choices: [
      EventChoice(
        text: '屏息突围',
        resultText: '你深吸一口气闭住呼吸冲了出去，好在中毒不深。',
        hpChange: -10,
        rewardExp: 15,
      ),
      EventChoice(
        text: '用衣袖捂住口鼻',
        resultText: '紫雾渗透力极强，你还是吸入了不少。头晕目眩了好一阵才恢复。',
        hpChange: -25,
        rewardExp: 10,
      ),
    ],
  ),
  'mw_waymarker_trace': const GameEventData(
    id: 'mw_waymarker_trace',
    name: '旧道路标',
    description: '雾墙后露出半截刻碑，纹路与林风提到的安全路线高度吻合。',
    type: GameEventType.adventure,
    weight: 6,
    choices: [
      EventChoice(
        text: '拓下碑纹',
        resultText: '你用炭笔把刻纹拓在布片上，回去可用于校准路线。',
        rewardExp: 16,
      ),
      EventChoice(
        text: '原地记忆',
        resultText: '你反复默记路标方位，走出雾区后仍记得大半。',
        rewardExp: 9,
      ),
    ],
  ),

  // ===== 天剑门外 =====
  'tj_disciple_challenge': const GameEventData(
    id: 'tj_disciple_challenge',
    name: '弟子挑战',
    description: '一名天剑门外门弟子拦住你的去路："来者何人？先过我这一关再说！"',
    type: GameEventType.battle,
    weight: 10,
    choices: [
      EventChoice(
        text: '应战',
        resultText: '你拔出兵器，准备和天剑门弟子过招。',
        triggerBattle: true,
        enemyId: 'tianjian_disciple',
      ),
      EventChoice(
        text: '说明来意',
        resultText: '"我是来求见掌门的。"弟子打量了你一番，半信半疑地让你先等着。',
        rewardExp: 10,
      ),
    ],
  ),
  'tj_sword_intent': const GameEventData(
    id: 'tj_sword_intent',
    name: '剑意洗礼',
    description: '走在通往天剑门的石阶上，一股凌厉的剑意扑面而来。这是前辈们留下的剑意残留。',
    type: GameEventType.scenery,
    weight: 12,
    rewardExp: 30,
    choices: [
      EventChoice(
        text: '感悟剑意',
        resultText: '你在剑意中沉浸了许久，虽然只领悟了一丝皮毛，但也收获颇丰。',
        rewardExp: 35,
      ),
      EventChoice(
        text: '快步通过',
        resultText: '剑意如刀割般拂过你的面颊，你咬牙快步走过。',
        hpChange: -10,
        rewardExp: 10,
      ),
    ],
  ),
  'tj_gate_resonance': const GameEventData(
    id: 'tj_gate_resonance',
    name: '古玉共鸣',
    description: '你靠近山门石阶时，怀中古玉微微发烫，似与门前阵纹产生了共鸣。',
    type: GameEventType.adventure,
    weight: 8,
    choices: [
      EventChoice(
        text: '顺着纹路探查',
        resultText: '你沿着阵纹缓缓前行，竟绕开了两处暗哨，确认了一段可用路径。',
        rewardExp: 20,
      ),
      EventChoice(
        text: '立刻后撤',
        resultText: '你担心惊动守门弟子，先退回山道，记下了玉纹闪烁的节律。',
        rewardExp: 8,
      ),
    ],
  ),

  // ===== 荒野营地 =====
  'wc_mercenary_talk': const GameEventData(
    id: 'wc_mercenary_talk',
    name: '佣兵闲谈',
    description: '几个佣兵围坐在篝火旁，正在讨论最近的任务。',
    type: GameEventType.npcEncounter,
    weight: 12,
    choices: [
      EventChoice(
        text: '加入交谈',
        resultText: '你和佣兵们聊了起来，从他们口中得知了不少江湖秘闻。',
        rewardExp: 15,
      ),
      EventChoice(
        text: '静静旁听',
        resultText: '你在一旁默默听着，记下了几个有用的情报。',
        rewardExp: 8,
      ),
    ],
  ),
  'wc_hunter_trade': const GameEventData(
    id: 'wc_hunter_trade',
    name: '猎人交易',
    description: '一个猎人正在整理猎物，看到你走来，主动打起了招呼。',
    type: GameEventType.merchant,
    weight: 10,
    choices: [
      EventChoice(
        text: '询问货物',
        resultText: '猎人拿出一些兽皮和草药，你挑选了一些有用的材料。',
        rewardItemId: 'rough_iron',
      ),
      EventChoice(
        text: '礼貌拒绝',
        resultText: '你婉言谢绝，继续前行。',
      ),
    ],
  ),
  'wc_rogue_encounter': const GameEventData(
    id: 'wc_rogue_encounter',
    name: '浪人剑客',
    description: '一个衣衫褴褛的剑客坐在营地边缘，眼神锐利如刀。',
    type: GameEventType.battle,
    weight: 10,
    choices: [
      EventChoice(
        text: '上前切磋',
        resultText: '剑客站起身来，拔剑相向："既然你有此意，那就来吧！"',
        triggerBattle: true,
        enemyId: 'rogue_swordsman',
      ),
      EventChoice(
        text: '点头致意',
        resultText: '你向剑客点头示意，对方也微微颔首，没有多言。',
        rewardExp: 5,
      ),
    ],
  ),
  'wc_campfire_story': const GameEventData(
    id: 'wc_campfire_story',
    name: '篝火故事',
    description: '夜幕降临，营地里的人们围坐在篝火旁，有人开始讲述江湖往事。',
    type: GameEventType.scenery,
    weight: 12,
    choices: [
      EventChoice(
        text: '认真倾听',
        resultText: '你听到了一个关于古代高手的传说，心中若有所悟。',
        rewardExp: 18,
      ),
      EventChoice(
        text: '早早休息',
        resultText: '你觉得疲惫，找了个角落休息去了。',
        hpChange: 15,
      ),
    ],
  ),
  'wc_night_ambush': const GameEventData(
    id: 'wc_night_ambush',
    name: '夜袭',
    description: '深夜，你听到营地外传来异响，似乎有什么东西在靠近。',
    type: GameEventType.battle,
    weight: 7,
    choices: [
      EventChoice(
        text: '提剑警戒',
        resultText: '一个山中猎户突然冲出，原来是被山贼追杀至此！',
        triggerBattle: true,
        enemyId: 'mountain_hunter',
      ),
      EventChoice(
        text: '假装熟睡',
        resultText: '你闭目装睡，那声音渐渐远去了。',
        rewardExp: 3,
      ),
    ],
  ),

  // ===== 迷雾谷新增事件 =====
  'mw_blood_wolf': const GameEventData(
    id: 'mw_blood_wolf',
    name: '血狼袭击',
    description: '浓雾中传来低沉的嚎叫，一头双眼赤红的血狼从雾中扑出！',
    type: GameEventType.battle,
    weight: 8,
    choices: [
      EventChoice(
        text: '迎战血狼',
        resultText: '血狼凶猛异常，你必须全力应对！',
        triggerBattle: true,
        enemyId: 'blood_wolf',
      ),
      EventChoice(
        text: '燃火驱赶',
        resultText: '你点燃火把挥舞，血狼畏惧火光，退入了雾中。',
        rewardExp: 10,
        hpChange: -8,
      ),
    ],
  ),
  'mw_iron_golem': const GameEventData(
    id: 'mw_iron_golem',
    name: '古代傀儡',
    description: '雾气深处，一具铁甲傀儡缓缓转动，发出刺耳的金属摩擦声。',
    type: GameEventType.battle,
    weight: 6,
    choices: [
      EventChoice(
        text: '挑战傀儡',
        resultText: '傀儡的双眼亮起红光，朝你走来！',
        triggerBattle: true,
        enemyId: 'iron_golem',
      ),
      EventChoice(
        text: '绕道而行',
        resultText: '你小心翼翼地绕开傀儡，它似乎没有发现你。',
        rewardExp: 5,
      ),
    ],
  ),
};
