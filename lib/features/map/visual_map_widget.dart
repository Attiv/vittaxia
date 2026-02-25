import 'package:flutter/material.dart';
import '../../models/map_location.dart';
import '../../core/theme/app_theme.dart';
import '../../models/enums.dart';

/// 地图节点位置配置
class MapNodePosition {
  final String locationId;
  final Offset position;

  const MapNodePosition(this.locationId, this.position);
}

/// 可视化地图画布
class VisualMapWidget extends StatefulWidget {
  final Map<String, MapLocation> locations;
  final String currentLocationId;
  final Set<String> unlockedLocationIds;
  final Function(String locationId) onLocationTap;

  const VisualMapWidget({
    super.key,
    required this.locations,
    required this.currentLocationId,
    required this.unlockedLocationIds,
    required this.onLocationTap,
  });

  @override
  State<VisualMapWidget> createState() => _VisualMapWidgetState();
}

class _VisualMapWidgetState extends State<VisualMapWidget> {
  String? hoveredLocationId;
  final TransformationController _transformController =
      TransformationController();

  // 地图节点布局（相对坐标，0-1范围）
  static const Map<String, Offset> _nodePositions = {
    'qingyun_village': Offset(0.2, 0.5),
    'qingfeng_town': Offset(0.5, 0.3),
    'qingzhu_forest': Offset(0.2, 0.7),
    'wangyue_tower': Offset(0.65, 0.45),
    'luoxia_mountains': Offset(0.5, 0.15),
    'wilderness_camp': Offset(0.7, 0.6),
    'miwu_valley': Offset(0.8, 0.75),
    'tianjian_gate': Offset(0.85, 0.9),
  };

  @override
  void dispose() {
    _transformController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        return InteractiveViewer(
          transformationController: _transformController,
          minScale: 0.8,
          maxScale: 2.5,
          boundaryMargin: const EdgeInsets.all(100),
          child: GestureDetector(
            child: CustomPaint(
              size: Size(width, height),
              painter: _MapPainter(
                locations: widget.locations,
                nodePositions: _nodePositions,
                currentLocationId: widget.currentLocationId,
                unlockedLocationIds: widget.unlockedLocationIds,
                hoveredLocationId: hoveredLocationId,
              ),
              child: Stack(
                children: _buildLocationNodes(width, height),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildLocationNodes(double width, double height) {
    final nodes = <Widget>[];

    for (final entry in _nodePositions.entries) {
      final locationId = entry.key;
      final relativePos = entry.value;
      final location = widget.locations[locationId];
      if (location == null) continue;

      final isUnlocked = widget.unlockedLocationIds.contains(locationId);
      final isCurrent = locationId == widget.currentLocationId;
      final isHovered = locationId == hoveredLocationId;

      final absolutePos = Offset(
        relativePos.dx * width,
        relativePos.dy * height,
      );

      nodes.add(
        Positioned(
          left: absolutePos.dx - 40,
          top: absolutePos.dy - 40,
          child: MouseRegion(
            onEnter: (_) => setState(() => hoveredLocationId = locationId),
            onExit: (_) => setState(() => hoveredLocationId = null),
            child: GestureDetector(
              onTap: isUnlocked ? () => widget.onLocationTap(locationId) : null,
              child: _buildLocationNode(
                location,
                isCurrent,
                isUnlocked,
                isHovered,
              ),
            ),
          ),
        ),
      );
    }

    return nodes;
  }

  Widget _buildLocationNode(
    MapLocation location,
    bool isCurrent,
    bool isUnlocked,
    bool isHovered,
  ) {
    final nodeSize = isCurrent ? 90.0 : 80.0;
    final iconSize = isCurrent ? 32.0 : 28.0;

    Color bgColor;
    Color borderColor;
    if (!isUnlocked) {
      bgColor = AppColors.surface;
      borderColor = AppColors.textSecondary.withValues(alpha: 0.3);
    } else if (isCurrent) {
      bgColor = AppColors.accent.withValues(alpha: 0.2);
      borderColor = AppColors.accent;
    } else if (isHovered) {
      bgColor = AppColors.primaryLight.withValues(alpha: 0.3);
      borderColor = AppColors.accent.withValues(alpha: 0.7);
    } else {
      bgColor = AppColors.surface;
      borderColor = AppColors.primaryLight;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: nodeSize,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: borderColor,
                width: isCurrent ? 3 : 2,
              ),
              boxShadow: isCurrent || isHovered
                  ? [
                      BoxShadow(
                        color: borderColor.withValues(alpha: 0.4),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Icon(
                _getLocationIcon(location.type),
                size: iconSize,
                color: isUnlocked
                    ? (isCurrent ? AppColors.accent : AppColors.textPrimary)
                    : AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            constraints: BoxConstraints(maxWidth: nodeSize),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isCurrent
                  ? AppColors.accent.withValues(alpha: 0.15)
                  : AppColors.surface.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isCurrent
                    ? AppColors.accent.withValues(alpha: 0.5)
                    : AppColors.primaryLight.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              location.name,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                color: isUnlocked
                    ? (isCurrent ? AppColors.accent : AppColors.textPrimary)
                    : AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (!isUnlocked)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Icon(
                Icons.lock,
                size: 14,
                color: AppColors.textSecondary,
              ),
            ),
        ],
      ),
    );
  }

  IconData _getLocationIcon(LocationType type) {
    return switch (type) {
      LocationType.village => Icons.home,
      LocationType.city => Icons.location_city,
      LocationType.wilderness => Icons.forest,
      LocationType.dungeon => Icons.cloud,
      LocationType.sect => Icons.temple_buddhist,
      LocationType.special => Icons.star,
    };
  }
}

/// 地图画布绘制器
class _MapPainter extends CustomPainter {
  final Map<String, MapLocation> locations;
  final Map<String, Offset> nodePositions;
  final String currentLocationId;
  final Set<String> unlockedLocationIds;
  final String? hoveredLocationId;

  _MapPainter({
    required this.locations,
    required this.nodePositions,
    required this.currentLocationId,
    required this.unlockedLocationIds,
    this.hoveredLocationId,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制连接线
    _drawConnections(canvas, size);
  }

  void _drawConnections(Canvas canvas, Size size) {
    final drawnConnections = <String>{};

    for (final entry in locations.entries) {
      final locationId = entry.key;
      final location = entry.value;
      final fromPos = nodePositions[locationId];
      if (fromPos == null) continue;

      final fromAbsolute = Offset(
        fromPos.dx * size.width,
        fromPos.dy * size.height,
      );

      for (final adjacentId in location.adjacentIds) {
        final toPos = nodePositions[adjacentId];
        if (toPos == null) continue;

        // 避免重复绘制（A-B 和 B-A 只画一次）
        final connectionKey = locationId.compareTo(adjacentId) < 0
            ? '$locationId-$adjacentId'
            : '$adjacentId-$locationId';
        if (drawnConnections.contains(connectionKey)) continue;
        drawnConnections.add(connectionKey);

        final toAbsolute = Offset(
          toPos.dx * size.width,
          toPos.dy * size.height,
        );

        final isFromUnlocked = unlockedLocationIds.contains(locationId);
        final isToUnlocked = unlockedLocationIds.contains(adjacentId);
        final isConnected = isFromUnlocked && isToUnlocked;

        final isHighlighted = locationId == currentLocationId ||
            adjacentId == currentLocationId ||
            locationId == hoveredLocationId ||
            adjacentId == hoveredLocationId;

        final paint = Paint()
          ..color = isConnected
              ? (isHighlighted
                  ? AppColors.accent.withValues(alpha: 0.6)
                  : AppColors.primaryLight.withValues(alpha: 0.4))
              : AppColors.textSecondary.withValues(alpha: 0.15)
          ..strokeWidth = isHighlighted ? 3 : 2
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

        if (!isConnected) {
          _drawDashedLine(canvas, fromAbsolute, toAbsolute, paint);
        } else {
          canvas.drawLine(fromAbsolute, toAbsolute, paint);
        }
      }
    }
  }

  // 绘制虚线
  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashWidth = 5.0;
    const dashSpace = 3.0;

    final distance = (end - start).distance;
    final unitVector = (end - start) / distance;

    double currentDistance = 0;
    while (currentDistance < distance) {
      final dashEnd = currentDistance + dashWidth;
      if (dashEnd > distance) {
        canvas.drawLine(
          start + unitVector * currentDistance,
          end,
          paint,
        );
        break;
      }

      canvas.drawLine(
        start + unitVector * currentDistance,
        start + unitVector * dashEnd,
        paint,
      );

      currentDistance = dashEnd + dashSpace;
    }
  }

  @override
  bool shouldRepaint(_MapPainter oldDelegate) {
    return oldDelegate.currentLocationId != currentLocationId ||
        oldDelegate.hoveredLocationId != hoveredLocationId ||
        oldDelegate.unlockedLocationIds != unlockedLocationIds;
  }
}
