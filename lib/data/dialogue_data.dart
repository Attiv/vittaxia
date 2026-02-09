import '../models/npc.dart';

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

  // ===== 李药婆 =====
  'li_greet': const DialogueNode(
    id: 'li_greet',
    speaker: '李药婆',
    text: '哟，又是你啊。年轻人别整天打打杀杀的，身体要紧。来看看我这里的药，备着总没错。',
    affectionChange: 1,
  ),

  // ===== 陈老头 =====
  'chen_greet': const DialogueNode(
    id: 'chen_greet',
    speaker: '陈老头',
    text: '想下棋？坐下吧。世事如棋，落子无悔。',
    choices: [
      DialogueChoice(text: '和他下一局', nextId: 'chen_chess', affectionChange: 2),
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

  // ===== 柳如烟 =====
  'liu_greet': const DialogueNode(
    id: 'liu_greet',
    speaker: '柳如烟',
    text: '客官请坐，醉仙楼的酒可是清风镇一绝。你是新来的吧？面生得很。',
    choices: [
      DialogueChoice(text: '打听消息', nextId: 'liu_info', affectionChange: 1),
      DialogueChoice(text: '来碗酒', nextId: 'liu_wine'),
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

  // ===== 白无常 =====
  'bai_greet': const DialogueNode(
    id: 'bai_greet',
    speaker: '白无常',
    text: '话说天下大势，分久必合，合久必分……咦，你这后生，是来听书的？还是有事找我？',
    choices: [
      DialogueChoice(text: '请教江湖事', nextId: 'bai_story', affectionChange: 2),
      DialogueChoice(text: '随便听听', nextId: 'bai_casual'),
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

  // ===== 苏晚吟 =====
  'su_greet': const DialogueNode(
    id: 'su_greet',
    speaker: '苏晚吟',
    text: '你就是……白先生说的那个人？让我看看你手中的古玉。',
    choices: [
      DialogueChoice(text: '给她看', nextId: 'su_music', affectionChange: 5),
      DialogueChoice(text: '为何要给你看？', nextId: 'su_refuse'),
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

  // ===== 孙一手 =====
  'sun_greet': const DialogueNode(
    id: 'sun_greet',
    speaker: '孙一手',
    text: '看什么看！要买兵器就说，不买别碍事！',
    choices: [
      DialogueChoice(text: '看看你的货', nextId: 'sun_shop'),
      DialogueChoice(text: '打扰了', nextId: 'sun_leave'),
    ],
  ),
  'sun_shop': const DialogueNode(
    id: 'sun_shop',
    speaker: '孙一手',
    text: '哼，还算有眼光。这些都是我亲手打的，质量绝对没话说。',
    affectionChange: 1,
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
    affectionChange: 3,
    expReward: 15,
  ),

  // ===== 林风 =====
  'lin_greet': const DialogueNode(
    id: 'lin_greet',
    speaker: '林风',
    text: '你也在这迷雾中迷路了？我叫林风，是个剑客。在这谷中已经转了三天了。要不……我们结伴同行？',
    choices: [
      DialogueChoice(text: '好，一起走', nextId: 'lin_join', affectionChange: 5),
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
  'lin_solo': const DialogueNode(
    id: 'lin_solo',
    speaker: '林风',
    text: '也好。那就各走各的吧，江湖再见。',
  ),
};
