# 维塔侠 (Vittaxia)

一个以武侠世界为背景的 Flutter 单机文字挂机游戏。  
你可以创建角色、探索地图、触发随机事件、回合制战斗、修炼武学、经营装备与背包，并在离线期间持续获得收益。

## 项目状态

- 当前版本：`0.1.0`
- 平台：Flutter（Android / iOS / macOS / Windows）
- 数据存储：本地 SQLite（Drift）
- 语言：简体中文

## 核心玩法

- 角色成长：境界与阶段推进，属性随成长提升
- 探索事件：不同地点触发不同遭遇与奖励
- 回合战斗：技能释放、被动触发、暴击/闪避、掉落与战后结算
- 武功系统：学习、装备、熟练度与升级
- 装备系统：武器/防具/鞋子/饰品与强化
- 背包与商店：分类管理、批量购买、消耗品使用
- NPC 与任务：对话、好感、主支线推进
- **师门系统**：加入师门、学习专属技能、完成师门任务 🆕
- 挂机收益：离线经验与在线体力恢复

## 技术栈

- Flutter + Dart
- Riverpod（状态管理）
- GoRouter（路由）
- Drift + sqlite3_flutter_libs（本地数据库）
- Freezed + json_serializable（数据模型）

## 本地运行

### 1. 环境要求

- Flutter SDK（与 `pubspec.yaml` 对应，Dart `^3.8.1`）
- 可用的 Flutter 平台工具链（Android Studio / Xcode 等）

### 2. 安装依赖

```bash
flutter pub get
```

### 3. 启动项目

```bash
flutter run
```

### 4. 常用开发命令

```bash
# 静态检查
flutter analyze

# 测试
flutter test

# 代码生成（模型/数据库变更后）
dart run build_runner build --delete-conflicting-outputs
```

## 目录结构

```text
lib/
  core/        # 路由、主题、数据库、通用工具
  data/        # 静态配置数据（技能、敌人、物品、地图等）
  features/    # 业务模块（战斗、技能、背包、任务、探索等）
  models/      # 数据模型
  shared/      # 共享组件
test/          # 测试
```

## 数据说明

- 角色、背包、技能、任务进度等存储在本地 SQLite
- 默认数据库文件名：`vittaxia.db`
- 数据库版本：v3（支持师门系统）
- 当前不依赖服务器，适合本地离线开发与游玩

## 最近更新

### 2026-02-21 - 师门系统与任务优化

**新增功能**:
- ✨ 师门系统：4个师门可供选择，9个专属技能
- ✨ 任务弹窗：接取和完成任务时显示详细弹窗
- 🐛 修复天星石任务无法完成的 Bug

**详细说明**: 查看 `CHANGELOG.md` 和 `docs/` 目录

## 许可证

本项目采用 **CC BY-NC 4.0（署名-非商业性使用）**。  
你可以在非商业场景下使用、修改和分发源码；禁止任何未经授权的商业用途。  
详见根目录 `LICENSE` 文件。
