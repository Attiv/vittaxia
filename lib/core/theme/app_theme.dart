import 'package:flutter/material.dart';

/// 默认配色（兼容大量页面直接引用 AppColors 的场景）。
/// 主题切换时，Material 组件和全局滤镜/背景会跟随变化。
class AppColors {
  static UiThemeSpec _spec = uiThemeSpecs[UiThemePreset.warmInk]!;

  static void apply(UiThemeSpec spec) {
    _spec = spec;
  }

  static UiThemeSpec get currentSpec => _spec;

  static Color get primary => _spec.primary;
  static Color get primaryLight => _spec.primaryLight;
  static Color get primaryDark => _spec.primaryDark;

  static Color get accent => _spec.accent;
  static Color get accentDark => _spec.accentDark;

  static Color get background => _spec.background;
  static Color get surface => _spec.surface;
  static Color get surfaceLight => _spec.surfaceLight;

  static Color get progressTrack => _spec.progressTrack;

  static Color get textPrimary => _spec.textPrimary;
  static Color get textSecondary => _spec.textSecondary;
  static Color get textAccent => _spec.textAccent;

  static Color get hp => _spec.hp;
  static Color get mp => _spec.mp;
  static Color get exp => _spec.exp;
  static Color get danger => _spec.danger;
  static Color get success => _spec.success;
  static Color get warning => _spec.warning;
}

enum UiThemePreset {
  warmInk,
  inkBlue,
  crimsonGold,
  parchmentInk,
  coolGray,
  jadeNight,
  desertDusk,
  plumNight,
}

class UiThemeSpec {
  final String id;
  final String label;
  final String subtitle;

  final Color primary;
  final Color primaryLight;
  final Color primaryDark;
  final Color accent;
  final Color accentDark;
  final Color background;
  final Color surface;
  final Color surfaceLight;
  final Color progressTrack;
  final Color textPrimary;
  final Color textSecondary;
  final Color textAccent;
  final Color hp;
  final Color mp;
  final Color exp;
  final Color danger;
  final Color success;
  final Color warning;

  final List<Color> backgroundGradient;
  final Color textureCloud;
  final Color textureRing;
  final Color textureDust;
  final Color textureStroke;
  final Color textureLine;
  final Color textureSwirl;

  final Color uiTintColor;
  final double uiTintOpacity;
  final BlendMode uiTintBlendMode;

  const UiThemeSpec({
    required this.id,
    required this.label,
    required this.subtitle,
    required this.primary,
    required this.primaryLight,
    required this.primaryDark,
    required this.accent,
    required this.accentDark,
    required this.background,
    required this.surface,
    required this.surfaceLight,
    required this.progressTrack,
    required this.textPrimary,
    required this.textSecondary,
    required this.textAccent,
    required this.hp,
    required this.mp,
    required this.exp,
    required this.danger,
    required this.success,
    required this.warning,
    required this.backgroundGradient,
    required this.textureCloud,
    required this.textureRing,
    required this.textureDust,
    required this.textureStroke,
    required this.textureLine,
    required this.textureSwirl,
    required this.uiTintColor,
    required this.uiTintOpacity,
    this.uiTintBlendMode = BlendMode.softLight,
  });
}

const uiThemePresetOrder = <UiThemePreset>[
  UiThemePreset.warmInk,
  UiThemePreset.inkBlue,
  UiThemePreset.crimsonGold,
  UiThemePreset.parchmentInk,
  UiThemePreset.coolGray,
  UiThemePreset.jadeNight,
  UiThemePreset.desertDusk,
  UiThemePreset.plumNight,
];

const uiThemeSpecs = <UiThemePreset, UiThemeSpec>{
  UiThemePreset.warmInk: UiThemeSpec(
    id: 'warm_ink',
    label: '暖墨赭金',
    subtitle: '当前默认',
    primary: Color(0xFF3A2D22),
    primaryLight: Color(0xFF574536),
    primaryDark: Color(0xFF17110C),
    accent: Color(0xFFE0B45D),
    accentDark: Color(0xFFA36A2A),
    background: Color(0xFF110E0B),
    surface: Color(0xFF1D1712),
    surfaceLight: Color(0xFF2B221A),
    progressTrack: Color(0xFF3A3027),
    textPrimary: Color(0xFFF2E7D4),
    textSecondary: Color(0xFFB7A58D),
    textAccent: Color(0xFFE0B45D),
    hp: Color(0xFFCC5445),
    mp: Color(0xFF5F92C9),
    exp: Color(0xFF7AAD64),
    danger: Color(0xFFE5614E),
    success: Color(0xFF7DBA68),
    warning: Color(0xFFE0A35A),
    backgroundGradient: [
      Color(0xFF120E0B),
      Color(0xFF1A1410),
      Color(0xFF110C09),
    ],
    textureCloud: Color(0x22382C22),
    textureRing: Color(0x22E0B45D),
    textureDust: Color(0x12F3DEC0),
    textureStroke: Color(0x20E0B45D),
    textureLine: Color(0x102F241C),
    textureSwirl: Color(0x14E0B45D),
    uiTintColor: Color(0xFFF0BA64),
    uiTintOpacity: 0.05,
  ),
  UiThemePreset.inkBlue: UiThemeSpec(
    id: 'ink_blue',
    label: '墨夜青金',
    subtitle: '冷调夜色',
    primary: Color(0xFF223037),
    primaryLight: Color(0xFF2F434D),
    primaryDark: Color(0xFF121B20),
    accent: Color(0xFF77A9D9),
    accentDark: Color(0xFF4A759C),
    background: Color(0xFF0D1317),
    surface: Color(0xFF182229),
    surfaceLight: Color(0xFF22303A),
    progressTrack: Color(0xFF2A3943),
    textPrimary: Color(0xFFECE7D9),
    textSecondary: Color(0xFFA8B0A8),
    textAccent: Color(0xFF91C0E9),
    hp: Color(0xFFD65A4A),
    mp: Color(0xFF4DA8D9),
    exp: Color(0xFF5FB66A),
    danger: Color(0xFFE05B4A),
    success: Color(0xFF64B870),
    warning: Color(0xFFE1A85A),
    backgroundGradient: [
      Color(0xFF0A1116),
      Color(0xFF0F1920),
      Color(0xFF0D161C),
    ],
    textureCloud: Color(0x22384A56),
    textureRing: Color(0x2277A9D9),
    textureDust: Color(0x12E7D9BD),
    textureStroke: Color(0x1F77A9D9),
    textureLine: Color(0x102B3A43),
    textureSwirl: Color(0x1477A9D9),
    uiTintColor: Color(0xFF7DAFD7),
    uiTintOpacity: 0.06,
  ),
  UiThemePreset.crimsonGold: UiThemeSpec(
    id: 'crimson_gold',
    label: '暗红黑金',
    subtitle: '门派杀伐',
    primary: Color(0xFF2D1816),
    primaryLight: Color(0xFF492926),
    primaryDark: Color(0xFF120907),
    accent: Color(0xFFD66E63),
    accentDark: Color(0xFF8E3F37),
    background: Color(0xFF0D0707),
    surface: Color(0xFF1B1111),
    surfaceLight: Color(0xFF2A1A1A),
    progressTrack: Color(0xFF3A2525),
    textPrimary: Color(0xFFF0E1D3),
    textSecondary: Color(0xFFB89A8F),
    textAccent: Color(0xFFE08D83),
    hp: Color(0xFFD74E47),
    mp: Color(0xFF7B95C8),
    exp: Color(0xFF84B05F),
    danger: Color(0xFFE75C4E),
    success: Color(0xFF82BB64),
    warning: Color(0xFFE3A06A),
    backgroundGradient: [
      Color(0xFF100808),
      Color(0xFF1A0E0E),
      Color(0xFF120909),
    ],
    textureCloud: Color(0x223B1E1E),
    textureRing: Color(0x22D66E63),
    textureDust: Color(0x12F6D9AF),
    textureStroke: Color(0x20D66E63),
    textureLine: Color(0x101F1111),
    textureSwirl: Color(0x14D66E63),
    uiTintColor: Color(0xFFB84032),
    uiTintOpacity: 0.09,
  ),
  UiThemePreset.parchmentInk: UiThemeSpec(
    id: 'parchment_ink',
    label: '米白水墨',
    subtitle: '卷轴旧纸',
    primary: Color(0xFF4B3828),
    primaryLight: Color(0xFF65503D),
    primaryDark: Color(0xFF241A12),
    accent: Color(0xFFD5A85A),
    accentDark: Color(0xFF8E6331),
    background: Color(0xFF1E1712),
    surface: Color(0xFF2A2118),
    surfaceLight: Color(0xFF3A2F24),
    progressTrack: Color(0xFF4D4033),
    textPrimary: Color(0xFFF5EAD9),
    textSecondary: Color(0xFFC6B097),
    textAccent: Color(0xFFE0B97A),
    hp: Color(0xFFD86A55),
    mp: Color(0xFF7EA6CE),
    exp: Color(0xFF8BB977),
    danger: Color(0xFFE1725A),
    success: Color(0xFF8EC07A),
    warning: Color(0xFFE0B176),
    backgroundGradient: [
      Color(0xFF241C15),
      Color(0xFF2E241A),
      Color(0xFF211911),
    ],
    textureCloud: Color(0x223F3328),
    textureRing: Color(0x22D7AF6B),
    textureDust: Color(0x12FFF0D7),
    textureStroke: Color(0x20D7AF6B),
    textureLine: Color(0x102F261E),
    textureSwirl: Color(0x14D7AF6B),
    uiTintColor: Color(0xFFF0DEC2),
    uiTintOpacity: 0.09,
    uiTintBlendMode: BlendMode.screen,
  ),
  UiThemePreset.coolGray: UiThemeSpec(
    id: 'cool_gray',
    label: '冷白青灰',
    subtitle: '克制清峻',
    primary: Color(0xFF2C3239),
    primaryLight: Color(0xFF444C56),
    primaryDark: Color(0xFF12161B),
    accent: Color(0xFF8EACC8),
    accentDark: Color(0xFF5F768E),
    background: Color(0xFF0F1216),
    surface: Color(0xFF191D23),
    surfaceLight: Color(0xFF252B33),
    progressTrack: Color(0xFF333A45),
    textPrimary: Color(0xFFE9EBEE),
    textSecondary: Color(0xFFAAB1BA),
    textAccent: Color(0xFFA8C1D8),
    hp: Color(0xFFD66D66),
    mp: Color(0xFF7DA3CF),
    exp: Color(0xFF7FB38E),
    danger: Color(0xFFE16B62),
    success: Color(0xFF82B98F),
    warning: Color(0xFFC8A475),
    backgroundGradient: [
      Color(0xFF101418),
      Color(0xFF151A21),
      Color(0xFF10151B),
    ],
    textureCloud: Color(0x22353D48),
    textureRing: Color(0x228EACC8),
    textureDust: Color(0x12E9EEF2),
    textureStroke: Color(0x208EACC8),
    textureLine: Color(0x102D333E),
    textureSwirl: Color(0x148EACC8),
    uiTintColor: Color(0xFFC2CEDA),
    uiTintOpacity: 0.06,
  ),
  UiThemePreset.jadeNight: UiThemeSpec(
    id: 'jade_night',
    label: '竹影青松',
    subtitle: '清润墨绿',
    primary: Color(0xFF1E3028),
    primaryLight: Color(0xFF2E483D),
    primaryDark: Color(0xFF0D1B15),
    accent: Color(0xFF7DBB94),
    accentDark: Color(0xFF4C7F62),
    background: Color(0xFF0A1410),
    surface: Color(0xFF13221B),
    surfaceLight: Color(0xFF1F332A),
    progressTrack: Color(0xFF2C4036),
    textPrimary: Color(0xFFE8F0E7),
    textSecondary: Color(0xFFA3B9A9),
    textAccent: Color(0xFF98D0AE),
    hp: Color(0xFFCC6458),
    mp: Color(0xFF65A6CB),
    exp: Color(0xFF77C083),
    danger: Color(0xFFE06958),
    success: Color(0xFF7BC68E),
    warning: Color(0xFFC5A26E),
    backgroundGradient: [
      Color(0xFF0B1712),
      Color(0xFF10221B),
      Color(0xFF0B1914),
    ],
    textureCloud: Color(0x222E4A3D),
    textureRing: Color(0x227DBB94),
    textureDust: Color(0x12DAF3DD),
    textureStroke: Color(0x207DBB94),
    textureLine: Color(0x1024362F),
    textureSwirl: Color(0x147DBB94),
    uiTintColor: Color(0xFF4FA07B),
    uiTintOpacity: 0.08,
  ),
  UiThemePreset.desertDusk: UiThemeSpec(
    id: 'desert_dusk',
    label: '荒漠暮金',
    subtitle: '风沙余晖',
    primary: Color(0xFF3B271A),
    primaryLight: Color(0xFF5B3E2A),
    primaryDark: Color(0xFF180E08),
    accent: Color(0xFFE3A85C),
    accentDark: Color(0xFF9D5F2D),
    background: Color(0xFF130C08),
    surface: Color(0xFF21160F),
    surfaceLight: Color(0xFF312015),
    progressTrack: Color(0xFF473024),
    textPrimary: Color(0xFFF4E2CC),
    textSecondary: Color(0xFFC4A58A),
    textAccent: Color(0xFFE7B974),
    hp: Color(0xFFCC5A49),
    mp: Color(0xFF6DA3C8),
    exp: Color(0xFF8BB26E),
    danger: Color(0xFFE3624D),
    success: Color(0xFF92BD74),
    warning: Color(0xFFE3AC60),
    backgroundGradient: [
      Color(0xFF150D08),
      Color(0xFF20140D),
      Color(0xFF150C07),
    ],
    textureCloud: Color(0x223E2D1F),
    textureRing: Color(0x22E3A85C),
    textureDust: Color(0x12F8D9AE),
    textureStroke: Color(0x20E3A85C),
    textureLine: Color(0x102E2117),
    textureSwirl: Color(0x14E3A85C),
    uiTintColor: Color(0xFFC7772A),
    uiTintOpacity: 0.08,
  ),
  UiThemePreset.plumNight: UiThemeSpec(
    id: 'plum_night',
    label: '霁夜黛紫',
    subtitle: '冷月深巷',
    primary: Color(0xFF2A2234),
    primaryLight: Color(0xFF40344E),
    primaryDark: Color(0xFF100D16),
    accent: Color(0xFFA98BD4),
    accentDark: Color(0xFF70569A),
    background: Color(0xFF0C0A12),
    surface: Color(0xFF171422),
    surfaceLight: Color(0xFF241F35),
    progressTrack: Color(0xFF322C43),
    textPrimary: Color(0xFFEDE7F2),
    textSecondary: Color(0xFFB2A9BF),
    textAccent: Color(0xFFC2AAE7),
    hp: Color(0xFFD86A66),
    mp: Color(0xFF80A7D4),
    exp: Color(0xFF88BE94),
    danger: Color(0xFFE06F68),
    success: Color(0xFF8BC79D),
    warning: Color(0xFFC4A0D6),
    backgroundGradient: [
      Color(0xFF0E0B16),
      Color(0xFF151126),
      Color(0xFF0F0C1A),
    ],
    textureCloud: Color(0x22373046),
    textureRing: Color(0x22A98BD4),
    textureDust: Color(0x12E9DDF7),
    textureStroke: Color(0x20A98BD4),
    textureLine: Color(0x102A2438),
    textureSwirl: Color(0x14A98BD4),
    uiTintColor: Color(0xFF7E69A8),
    uiTintOpacity: 0.08,
  ),
};

UiThemePreset? uiThemePresetFromId(String id) {
  for (final entry in uiThemeSpecs.entries) {
    if (entry.value.id == id) return entry.key;
  }
  return null;
}

class AppTheme {
  static ThemeData get darkTheme =>
      buildTheme(uiThemeSpecs[UiThemePreset.warmInk]!);

  static ThemeData buildTheme(UiThemeSpec spec) {
    final borderColor = spec.accent.withValues(alpha: 0.32);
    final panelColor = spec.surface.withValues(alpha: 0.86);

    final base = ThemeData.dark(useMaterial3: false);
    return base.copyWith(
      brightness: Brightness.dark,
      primaryColor: spec.primary,
      scaffoldBackgroundColor: Colors.transparent,
      canvasColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      colorScheme: ColorScheme.dark(
        primary: spec.primary,
        secondary: spec.accent,
        surface: spec.surface,
        error: spec.danger,
        onPrimary: spec.textPrimary,
        onSecondary: spec.primaryDark,
        onSurface: spec.textPrimary,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.fuchsia: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: panelColor,
        foregroundColor: spec.textPrimary,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 58,
        titleTextStyle: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w700,
          color: spec.textAccent,
          letterSpacing: 1.8,
        ),
        iconTheme: IconThemeData(color: spec.textAccent, size: 20),
        actionsIconTheme: IconThemeData(color: spec.textAccent, size: 20),
        shape: Border(bottom: BorderSide(color: borderColor, width: 1)),
      ),
      cardTheme: CardThemeData(
        color: panelColor,
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: borderColor, width: 1),
        ),
      ),
      listTileTheme: ListTileThemeData(
        textColor: spec.textPrimary,
        iconColor: spec.textAccent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: spec.primaryLight.withValues(alpha: 0.55),
          foregroundColor: spec.textPrimary,
          shadowColor: Colors.transparent,
          disabledBackgroundColor: spec.surfaceLight.withValues(alpha: 0.4),
          disabledForegroundColor: spec.textSecondary.withValues(alpha: 0.7),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: borderColor, width: 1),
          ),
          textStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: spec.textAccent,
          side: BorderSide(color: borderColor, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: spec.textAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
          ),
        ),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: spec.textPrimary,
        unselectedLabelColor: spec.textSecondary,
        labelStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.6,
        ),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: spec.accent.withValues(alpha: 0.45)),
          color: spec.primaryLight.withValues(alpha: 0.45),
        ),
        dividerColor: Colors.transparent,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: panelColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: borderColor, width: 1),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: spec.surface.withValues(alpha: 0.93),
        modalBackgroundColor: spec.surface.withValues(alpha: 0.93),
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          side: BorderSide(color: borderColor, width: 1),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: spec.primaryDark.withValues(alpha: 0.92),
        contentTextStyle: TextStyle(color: spec.textPrimary, fontSize: 13),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: spec.primaryDark.withValues(alpha: 0.96),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: spec.accent.withValues(alpha: 0.35)),
        ),
        textStyle: TextStyle(color: spec.textPrimary, fontSize: 12),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: panelColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: borderColor, width: 1),
        ),
        textStyle: TextStyle(color: spec.textPrimary, fontSize: 13),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: spec.primaryDark.withValues(alpha: 0.65),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: spec.primaryLight.withValues(alpha: 0.4),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: spec.primaryLight.withValues(alpha: 0.45),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: spec.accent.withValues(alpha: 0.65)),
        ),
        hintStyle: TextStyle(color: spec.textSecondary, fontSize: 13),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: spec.accent,
        linearTrackColor: spec.progressTrack,
      ),
      dividerTheme: DividerThemeData(
        color: spec.primaryLight.withValues(alpha: 0.5),
        thickness: 1,
      ),
      textTheme: base.textTheme.copyWith(
        headlineLarge: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: spec.textAccent,
          letterSpacing: 3.2,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: spec.textPrimary,
          letterSpacing: 1.2,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: spec.textPrimary,
          letterSpacing: 0.9,
        ),
        titleMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: spec.textPrimary,
          letterSpacing: 0.8,
        ),
        bodyLarge: TextStyle(
          fontSize: 15,
          color: spec.textPrimary,
          height: 1.55,
          letterSpacing: 0.2,
        ),
        bodyMedium: TextStyle(
          fontSize: 13,
          color: spec.textSecondary,
          height: 1.5,
          letterSpacing: 0.2,
        ),
        labelLarge: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: spec.textAccent,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
