import '../models/npc.dart';

/// 对话选项的剧情门控：nextId → 关联的任务 ID
/// 只有该任务的前置任务已完成（即任务本身可接取），对话选项才会显示
const dialogueQuestGates = <String, String>{
  // 白无常
  'bai_star_record': 'side_12',
  'bai_gate_report': 'side_14',
  'bai_clue_reconstruction': 'main_15',
  'bai_gate_probe_plan': 'side_19',
  'bai_gate_probe_report': 'side_19',
  // 苏晚吟
  'su_moonflower_offer': 'main_13',
  'su_strategy_meeting': 'main_12',
  'su_shadow_report': 'side_13',
  // 柳如烟
  'liu_night_patrol': 'side_07',
  'liu_patrol_report': 'side_07',
  // 林风
  'lin_route_briefing': 'side_10',
  'lin_route_review_report': 'side_15',
  'lin_ghost_sweep_report': 'side_18',
  // 秦铸
  'qin_security_and_forge': 'main_17',
  'qin_mine_patrol_report': 'side_17',
  // 李药婆
  'li_mist_antidote': 'main_07',
  'li_moonlight_formula': 'side_20',
  // 孙一手
  'sun_rush_order': 'side_16',
  'sun_order_report': 'side_16',
};

/// 对话数据
final dialogues = <String, DialogueNode>{
  // ===== 张大叔 =====
  'zhang_greet': const DialogueNode(
    id: 'zhang_greet',
    speaker: '张大叔',
    text: '孩子，你终于长大了。这江湖啊，可不是好混的。出门在外，多加小心。',
    choices: [
      DialogueChoice(text: '大叔，我准备好了', nextId: 'zhang_greet_2', affectionChange: 2),
      DialogueChoice(text: '大叔放心', nextId: 'zhang_greet_3'),
      DialogueChoice(text: '请教掌法', nextId: 'zhang_teach_palm'),
    ],
    affectionChange: 1,
  ),
  'zhang_greet_2': const DialogueNode(
    id: 'zhang_greet_2',
    speaker: '张大叔',
    text: '好小子，有志气！你先去清风镇打听打听消息吧，那边的白无常是个消息灵通的人。',
    expReward: 10,
  ),
  'zhang_greet_3': const DialogueNode(
    id: 'zhang_greet_3',
    speaker: '张大叔',
    text: '嗯，路上注意安全。有什么事随时回来找大叔。',
    expReward: 5,
  ),
  'zhang_teach': const DialogueNode(
    id: 'zhang_teach',
    speaker: '张大叔',
    text: '大叔我年轻的时候也闯荡过江湖。这几招拳脚虽然不起眼，但保命够用了。来，我教你。',
    teachSkillId: 'basic_fist',
    expReward: 15,
    affectionChange: 3,
  ),
  'zhang_teach_palm': const DialogueNode(
    id: 'zhang_teach_palm',
    speaker: '张大叔',
    text: '你拳脚练得不错，不过光靠拳头还不够。大叔再教你一招掌法——出手收势之间带一股掌风，能多伤对手一分。',
    teachSkillId: 'passive_palm_strike',
    expReward: 15,
    affectionChange: 3,
    requiredAffection: 10,
  ),

  // ===== 李药婆 =====
  'li_greet': const DialogueNode(
    id: 'li_greet',
    speaker: '李药婆',
    text: '哟，又是你啊。年轻人别整天打打杀杀的，身体要紧。来看看我这里的药，备着总没错。',
    choices: [
      DialogueChoice(text: '问她配药诀窍', nextId: 'li_potion_tip', affectionChange: 1),
      DialogueChoice(text: '询问迷雾谷毒雾', nextId: 'li_mist_antidote'),
      DialogueChoice(text: '商议月华药谱', nextId: 'li_moonlight_formula'),
    ],
    affectionChange: 1,
  ),
  'li_potion_tip': const DialogueNode(
    id: 'li_potion_tip',
    speaker: '李药婆',
    text: '火候稳、药性顺、心别急。你们练武讲心法，配药也是一样的道理。',
    expReward: 6,
  ),
  'li_mist_antidote': const DialogueNode(
    id: 'li_mist_antidote',
    speaker: '李药婆',
    text: '迷雾谷那地方邪得很。真要去，就带着碧心草，至少能缓一缓雾毒。',
    expReward: 8,
    affectionChange: 1,
  ),
  'li_moonlight_formula': const DialogueNode(
    id: 'li_moonlight_formula',
    speaker: '李药婆',
    text: '月见花性凉而不寒，拿来配碧心草正好能中和雾毒。你若带回两朵，我就把改好的药谱抄给你。',
    expReward: 10,
    affectionChange: 2,
  ),

  // ===== 陈老头 =====
  'chen_greet': const DialogueNode(
    id: 'chen_greet',
    speaker: '陈老头',
    text: '想下棋？坐下吧。世事如棋，落子无悔。',
    choices: [
      DialogueChoice(text: '和他下一局', nextId: 'chen_chess', affectionChange: 2),
      DialogueChoice(text: '请教指法', nextId: 'chen_finger'),
      DialogueChoice(text: '改天再来', nextId: 'chen_bye'),
    ],
  ),
  'chen_chess': const DialogueNode(
    id: 'chen_chess',
    speaker: '陈老头',
    text: '你的棋路有些意思……不过还差得远呐。棋道通武道，多悟悟吧。',
    expReward: 20,
    affectionChange: 5,
    teachSkillId: 'chess_insight',
  ),
  'chen_bye': const DialogueNode(
    id: 'chen_bye',
    speaker: '陈老头',
    text: '去吧去吧，年轻人总是坐不住。',
  ),
  'chen_finger': const DialogueNode(
    id: 'chen_finger',
    speaker: '陈老头',
    text: '落子时手指的劲道你注意到了吗？弹指之间也能伤人。这一招叫"弹指"，看着简单，关键在寸劲。',
    teachSkillId: 'passive_finger_flick',
    expReward: 20,
    affectionChange: 5,
    requiredAffection: 20,
  ),

  // ===== 柳如烟 =====
  'liu_greet': const DialogueNode(
    id: 'liu_greet',
    speaker: '柳如烟',
    text: '客官请坐，醉仙楼的酒可是清风镇一绝。你是新来的吧？面生得很。',
    choices: [
      DialogueChoice(text: '打听消息', nextId: 'liu_info', affectionChange: 1),
      DialogueChoice(text: '来碗酒', nextId: 'liu_wine'),
      DialogueChoice(text: '接清风夜巡差事', nextId: 'liu_night_patrol'),
      DialogueChoice(text: '汇报夜巡进展', nextId: 'liu_patrol_report'),
    ],
    affectionChange: 2,
  ),
  'liu_info': const DialogueNode(
    id: 'liu_info',
    speaker: '柳如烟',
    text: '最近镇上不太平，听说落霞山脉那边的山贼越来越猖狂了。你要是想打听更多，去找说书的白无常，他知道的最多。',
    expReward: 10,
    affectionChange: 2,
  ),
  'liu_wine': const DialogueNode(
    id: 'liu_wine',
    speaker: '柳如烟',
    text: '好嘞！这是本店招牌——醉仙酿。不过你可别喝多了，昨天就有人喝醉了在这闹事。',
    silverReward: -5,
    affectionChange: 3,
  ),
  'liu_night_patrol': const DialogueNode(
    id: 'liu_night_patrol',
    speaker: '柳如烟',
    text: '最近夜里总有醉汉闹事，镇民都不敢晚归。你若愿意帮我巡街，我记你这个人情。',
    expReward: 10,
    affectionChange: 2,
  ),
  'liu_patrol_report': const DialogueNode(
    id: 'liu_patrol_report',
    speaker: '柳如烟',
    text: '辛苦你了。昨夜街面确实安稳了不少。镇民提起你，都说你是个靠得住的人。',
    expReward: 12,
    affectionChange: 3,
  ),

  // ===== 白无常 =====
  'bai_greet': const DialogueNode(
    id: 'bai_greet',
    speaker: '白无常',
    text: '话说天下大势，分久必合，合久必分……咦，你这后生，是来听书的？还是有事找我？',
    choices: [
      DialogueChoice(text: '请教江湖事', nextId: 'bai_story', affectionChange: 2),
      DialogueChoice(text: '随便听听', nextId: 'bai_casual'),
      DialogueChoice(text: '请他补全古籍', nextId: 'bai_star_record'),
      DialogueChoice(text: '回报剑门动静', nextId: 'bai_gate_report'),
      DialogueChoice(text: '一起拼古玉线索', nextId: 'bai_clue_reconstruction'),
      DialogueChoice(text: '商议剑门试帖', nextId: 'bai_gate_probe_plan'),
      DialogueChoice(text: '汇报剑门试帖', nextId: 'bai_gate_probe_report'),
      DialogueChoice(text: '请教暗器手法', nextId: 'bai_teach_needle'),
    ],
  ),
  'bai_story': const DialogueNode(
    id: 'bai_story',
    speaker: '白无常',
    text: '你手里那块古玉……让我看看。嗯，这可不是凡物。你且去望月楼找苏姑娘，她或许知道些什么。对了，落霞山脉那边最近确实有异动，你小心着点。',
    expReward: 20,
    affectionChange: 5,
  ),
  'bai_casual': const DialogueNode(
    id: 'bai_casual',
    speaker: '白无常',
    text: '好好好，那就听老朽讲一段"天剑门"的故事吧……',
    expReward: 8,
  ),
  'bai_star_record': const DialogueNode(
    id: 'bai_star_record',
    speaker: '白无常',
    text: '你说古籍残缺？若有天星石作比照，老朽能把这一段星图旧闻补个七七八八。',
    expReward: 12,
    affectionChange: 2,
  ),
  'bai_gate_report': const DialogueNode(
    id: 'bai_gate_report',
    speaker: '白无常',
    text: '原来如此……天剑门外门近来戒备森严，和这块古玉牵出的旧案怕是脱不了干系。你这趟跑得值。',
    expReward: 15,
    affectionChange: 2,
  ),
  'bai_clue_reconstruction': const DialogueNode(
    id: 'bai_clue_reconstruction',
    speaker: '白无常',
    text: '你把月楼残页、剑门见闻和古玉纹路一一摊开。老朽越看越心惊——这并非单件信物，而是一套“引路钥”。你下一步当去找能识星铁的人。',
    expReward: 18,
    affectionChange: 3,
  ),
  'bai_gate_probe_plan': const DialogueNode(
    id: 'bai_gate_probe_plan',
    speaker: '白无常',
    text: '试帖不可莽撞。你先走外阶探风，再与一名外门弟子交手试招，重点看对方守门路数。打完别恋战，立即回镇复盘。',
    expReward: 14,
    affectionChange: 2,
  ),
  'bai_gate_probe_report': const DialogueNode(
    id: 'bai_gate_probe_report',
    speaker: '白无常',
    text: '你把试帖过程讲得细，连对方换手时机都记下了。好，这封回帖我来润色，下一步咱们就能更稳地探剑门底线。',
    expReward: 16,
    affectionChange: 2,
  ),
  'bai_teach_needle': const DialogueNode(
    id: 'bai_teach_needle',
    speaker: '白无常',
    text: '老朽年轻时也不全靠嘴皮子混饭吃。来，教你一手袖底飞针——出招时顺手丢几根针出去，花不了多少力气，效果却好得很。',
    teachSkillId: 'passive_hidden_needle',
    expReward: 20,
    affectionChange: 5,
    requiredAffection: 15,
  ),

  // ===== 苏晚吟 =====
  'su_greet': const DialogueNode(
    id: 'su_greet',
    speaker: '苏晚吟',
    text: '你就是……白先生说的那个人？让我看看你手中的古玉。',
    choices: [
      DialogueChoice(text: '给她看', nextId: 'su_music', affectionChange: 5),
      DialogueChoice(text: '为何要给你看？', nextId: 'su_refuse'),
      DialogueChoice(text: '交付月见花', nextId: 'su_moonflower_offer'),
      DialogueChoice(text: '商议月楼密议', nextId: 'su_strategy_meeting'),
      DialogueChoice(text: '回报月楼清影', nextId: 'su_shadow_report'),
    ],
    affectionChange: 3,
  ),
  'su_music': const DialogueNode(
    id: 'su_music',
    speaker: '苏晚吟',
    text: '这块古玉……和我的那块是一对。它们似乎指向了某个尘封已久的秘密。月圆之夜来望月楼吧，我有些事情想告诉你。',
    expReward: 30,
    affectionChange: 10,
  ),
  'su_refuse': const DialogueNode(
    id: 'su_refuse',
    speaker: '苏晚吟',
    text: '……也罢。等你想好了再来吧。',
    affectionChange: -2,
  ),
  'su_moonflower_offer': const DialogueNode(
    id: 'su_moonflower_offer',
    speaker: '苏晚吟',
    text: '月见花香能稳住心神。你愿意把花带来，说明你把我们的约定放在心上。',
    expReward: 14,
    affectionChange: 3,
  ),
  'su_strategy_meeting': const DialogueNode(
    id: 'su_strategy_meeting',
    speaker: '苏晚吟',
    text: '迷雾谷的路标会被雾潮改写。你先沿旧道做三次勘察，把“不会变”的石刻位置记下来，我们再据此定行动次序。',
    expReward: 16,
    affectionChange: 2,
  ),
  'su_shadow_report': const DialogueNode(
    id: 'su_shadow_report',
    speaker: '苏晚吟',
    text: '你能在月楼附近压住暗影，已说明你不是只会逞强的人。接下来若再遇到追踪者，先保线索，再图反击。',
    expReward: 18,
    affectionChange: 3,
  ),

  // ===== 孙一手 =====
  'sun_greet': const DialogueNode(
    id: 'sun_greet',
    speaker: '孙一手',
    text: '看什么看！要买兵器就说，不买别碍事！',
    choices: [
      DialogueChoice(text: '看看你的货', nextId: 'sun_shop'),
      DialogueChoice(text: '接铁匠急单', nextId: 'sun_rush_order'),
      DialogueChoice(text: '回报铁匠急单', nextId: 'sun_order_report'),
      DialogueChoice(text: '打扰了', nextId: 'sun_leave'),
    ],
  ),
  'sun_shop': const DialogueNode(
    id: 'sun_shop',
    speaker: '孙一手',
    text: '哼，还算有眼光。这些都是我亲手打的，质量绝对没话说。',
    affectionChange: 1,
  ),
  'sun_rush_order': const DialogueNode(
    id: 'sun_rush_order',
    speaker: '孙一手',
    text: '正好你来得巧。有人催我三日内交货，偏偏寒铁矿不够。你若能尽快带回两块矿，我这边给你留把上手的好剑。',
    expReward: 12,
    affectionChange: 2,
  ),
  'sun_order_report': const DialogueNode(
    id: 'sun_order_report',
    speaker: '孙一手',
    text: '矿石带回来了？好，炉火今晚就不熄。你这次帮我稳住了交期，回头我给你把剑再开一次锋。',
    expReward: 14,
    affectionChange: 2,
  ),
  'sun_leave': const DialogueNode(
    id: 'sun_leave',
    speaker: '孙一手',
    text: '走走走，别挡生意！',
  ),

  // ===== 秦铸 =====
  'qin_greet': const DialogueNode(
    id: 'qin_greet',
    speaker: '秦铸',
    text: '你是怎么找到这里来的？罢了。我是铸剑师秦铸，一辈子就想铸出一把绝世好剑。你若能帮我找到寒铁矿，我必有厚报。',
    choices: [
      DialogueChoice(text: '商议星铁试铸', nextId: 'qin_security_and_forge'),
      DialogueChoice(text: '回报矿路巡查', nextId: 'qin_mine_patrol_report'),
      DialogueChoice(text: '改日再来', nextId: 'qin_farewell'),
    ],
    affectionChange: 3,
    expReward: 15,
  ),
  'qin_security_and_forge': const DialogueNode(
    id: 'qin_security_and_forge',
    speaker: '秦铸',
    text: '你若真想破开剑门旧阵，光有蛮力不够。先备寒铁，再以天星石稳火候。我会把火路和淬法都写给你，别走捷径。',
    expReward: 18,
    affectionChange: 2,
  ),
  'qin_mine_patrol_report': const DialogueNode(
    id: 'qin_mine_patrol_report',
    speaker: '秦铸',
    text: '矿路能稳住，后续运料就不断。你这趟巡查很值，我也能安心把星铁炉继续开下去。',
    expReward: 16,
    affectionChange: 2,
  ),
  'qin_farewell': const DialogueNode(
    id: 'qin_farewell',
    speaker: '秦铸',
    text: '去吧。等你把材料备齐了，再来找我开炉。',
  ),

  // ===== 林风 =====
  'lin_greet': const DialogueNode(
    id: 'lin_greet',
    speaker: '林风',
    text: '你也在这迷雾中迷路了？我叫林风，是个剑客。在这谷中已经转了三天了。要不……我们结伴同行？',
    choices: [
      DialogueChoice(text: '好，一起走', nextId: 'lin_join', affectionChange: 5),
      DialogueChoice(text: '请他标注安全路', nextId: 'lin_route_briefing', affectionChange: 1),
      DialogueChoice(text: '回报路标复测', nextId: 'lin_route_review_report'),
      DialogueChoice(text: '回报雾谷清障', nextId: 'lin_ghost_sweep_report'),
      DialogueChoice(text: '请教剑气诀窍', nextId: 'lin_teach_sword_qi'),
      DialogueChoice(text: '我自己走', nextId: 'lin_solo'),
    ],
    affectionChange: 3,
  ),
  'lin_join': const DialogueNode(
    id: 'lin_join',
    speaker: '林风',
    text: '太好了！作为报答，我教你几招剑法和步法吧。在这鬼地方，多一份本事多一份保障。',
    expReward: 30,
    affectionChange: 8,
    teachSkillId: 'gale_sword',
  ),
  'lin_route_briefing': const DialogueNode(
    id: 'lin_route_briefing',
    speaker: '林风',
    text: '你看这几块石碑，雾再大也不会挪位。沿它们连成的弧线走，能避开大半陷坑。若要久探迷雾谷，先把这条线记牢。',
    expReward: 14,
    affectionChange: 2,
  ),
  'lin_route_review_report': const DialogueNode(
    id: 'lin_route_review_report',
    speaker: '林风',
    text: '你把复测过的路标都标清了？好，这样后来的人就不会在雾里白白折路。你做事比我想的还稳。',
    expReward: 15,
    affectionChange: 2,
  ),
  'lin_ghost_sweep_report': const DialogueNode(
    id: 'lin_ghost_sweep_report',
    speaker: '林风',
    text: '路标附近那几只怨灵被清了，雾道总算能喘口气。接下来我们就按新路线推进，不再被它们牵着走。',
    expReward: 17,
    affectionChange: 2,
  ),
  'lin_teach_sword_qi': const DialogueNode(
    id: 'lin_teach_sword_qi',
    speaker: '林风',
    text: '我看你剑招收得太干净了——出剑之后，留一丝真气在剑锋上。这叫剑气余韵，就算招式过了，那股劲还能追着对手跑。',
    teachSkillId: 'passive_sword_qi',
    expReward: 25,
    affectionChange: 5,
    requiredAffection: 20,
  ),
  'lin_solo': const DialogueNode(
    id: 'lin_solo',
    speaker: '林风',
    text: '也好。那就各走各的吧，江湖再见。',
  ),
};
