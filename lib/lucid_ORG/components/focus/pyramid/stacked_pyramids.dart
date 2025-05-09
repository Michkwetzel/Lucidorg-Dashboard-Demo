import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';

// Whole Pyramid widget
class StackedPyramids extends ConsumerStatefulWidget {
  final List<PyramidInfo> pyramids;
  final bool debugShowHitAreas;
  final FocusSection section;

  const StackedPyramids({
    super.key,
    required this.pyramids,
    this.debugShowHitAreas = false,
    required this.section,
  });

  @override
  ConsumerState<StackedPyramids> createState() => _StackedPyramidsState();
}

class _StackedPyramidsState extends ConsumerState<StackedPyramids> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    SurveyMetric displayData = ref.watch(metricsDataProvider).surveyMetric;

    return Stack(
      children: [
        // Add all pyramid images to the stack
        ...widget.pyramids.asMap().entries.map(
          (entry) {
            final index = entry.key;
            final pyramid = entry.value;
            final isHovered = index == hoveredIndex;

            double score = displayData.companyBenchmarks[pyramid.indicator]!;
            double diff = displayData.diffScores[pyramid.indicator]!;

            late Decoration decoration;
            late PyramidStatus status;

            if (widget.section == FocusSection.diffPyramid) {
              if (diff < 10) {
                status = PyramidStatus.hide;
              } else if (diff < 15) {
                status = PyramidStatus.opacity;
                decoration = kYellowBox;
              } else {
                status = PyramidStatus.show;
                decoration = kRedBox;
              }
            } else {
              if (score < 50) {
                status = PyramidStatus.show;
                decoration = kRedBox;
              } else if (score < 60) {
                status = PyramidStatus.opacity;
                decoration = kYellowBox;
              } else {
                status = PyramidStatus.hide;
              }
            }

            return Positioned(
              left: pyramid.left,
              top: pyramid.top,
              child: Stack(
                children: [
                  // for hover effect
                  // AnimatedOpacity(
                  //   duration: const Duration(milliseconds: 150),
                  //   opacity: isHovered ? 1.0 : 0.9,
                  //   child: Image.asset(
                  //     pyramid.imagePath,
                  //     width: pyramid.size.width,
                  //     height: pyramid.size.height,
                  //   ),
                  // ),
                  Opacity(
                    opacity: status == PyramidStatus.hide ? 0.3 : 1.0,
                    child: Image.asset(
                      pyramid.imagePath,
                      width: pyramid.size.width,
                      height: pyramid.size.height,
                    ),
                  ),
                  if (status == PyramidStatus.show || status == PyramidStatus.opacity)
                    Positioned(
                      top: 25,
                      left: pyramid.size.width / 3.5,
                      child: Container(
                        decoration: decoration,
                        width: 85,
                        height: 25,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (widget.section == FocusSection.diffPyramid)
                                SvgPicture.asset(
                                  'assets/icons/trianlge.svg',
                                  width: 16,
                                  height: 16,
                                  colorFilter: ColorFilter.mode(Color.fromARGB(255, 86, 86, 86), BlendMode.srcIn),
                                ),
                              Text(
                                widget.section == FocusSection.diffPyramid ? '~${diff.toStringAsFixed(0)}%' : '${score.toStringAsFixed(0)}%',
                                style: TextStyle(fontSize: 15, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              ),
            );
          },
        ),

        // This invisible layer handles all interactions
        MouseRegion(
          onHover: (event) {
            setState(() {
              hoveredIndex = _getTopPyramidAtPosition(event.localPosition);
            });
          },
          onExit: (_) {
            setState(() {
              hoveredIndex = null;
            });
          },
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapUp: (details) {
              final index = _getTopPyramidAtPosition(details.localPosition);
              if (index != null) {
                print(widget.pyramids[index].title);
                if (widget.pyramids[index].onTap != null) {
                  widget.pyramids[index].onTap!();
                }
              }
            },
            child: CustomPaint(
              painter: PyramidsPainter(
                pyramids: widget.pyramids,
                hoveredIndex: hoveredIndex,
                debugShowHitAreas: widget.debugShowHitAreas,
              ),
              size: Size(800, 800), // Adjust this to cover your entire area
              child: const SizedBox.expand(),
            ),
          ),
        ),
      ],
    );
  }

  // This is the key method that determines which pyramid is on top at a given position
  int? _getTopPyramidAtPosition(Offset position) {
    // Check pyramids in reverse order (top to bottom in z-order)
    for (int i = widget.pyramids.length - 1; i >= 0; i--) {
      final pyramid = widget.pyramids[i];
      final path = createPyramidPath(pyramid.size, Offset(pyramid.left, pyramid.top));

      if (path.contains(position)) {
        return i;
      }
    }
    return null;
  }

  Path createPyramidPath(Size size, Offset offset) {
    Path cubePath = Path();

    // These points define the cube's shape, but adjusted for the offset
    cubePath.moveTo(offset.dx + size.width / 2, offset.dy + 0);
    cubePath.lineTo(offset.dx + size.width, offset.dy + size.height / 4);
    cubePath.lineTo(offset.dx + size.width, offset.dy + size.height * 0.75);
    cubePath.lineTo(offset.dx + size.width / 2, offset.dy + size.height);
    cubePath.lineTo(offset.dx + 0, offset.dy + size.height * 0.75);
    cubePath.lineTo(offset.dx + 0, offset.dy + size.height / 4);
    cubePath.close();

    return cubePath;
  }
}

// Model class for pyramid information
class PyramidInfo {
  final String title;
  final double left;
  final double top;
  final Size size;
  final Color color;
  final String imagePath;
  final VoidCallback? onTap;
  final Indicator indicator;

  PyramidInfo({
    required this.indicator,
    required this.title,
    required this.left,
    required this.top,
    this.size = const Size(180, 144),
    this.color = Colors.blue,
    this.imagePath = 'assets/leadership.png',
    this.onTap,
  });
}

// Custom painter that draws all pyramids
// This class only handles debugging visualization of hit areas
// The actual pyramid images are drawn using widgets
class PyramidsPainter extends CustomPainter {
  final List<PyramidInfo> pyramids;
  final int? hoveredIndex;
  final bool debugShowHitAreas;

  PyramidsPainter({
    required this.pyramids,
    this.hoveredIndex,
    this.debugShowHitAreas = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Only draw debug hit areas if requested
    if (!debugShowHitAreas) return;

    for (int i = 0; i < pyramids.length; i++) {
      final pyramid = pyramids[i];
      final isHovered = i == hoveredIndex;

      final Paint paint = Paint()
        ..color = pyramid.color.withOpacity(isHovered ? 0.3 : 0.15)
        ..style = PaintingStyle.fill;

      Path pyramidPath = createPyramidPath(pyramid.size, Offset(pyramid.left, pyramid.top));

      canvas.drawPath(pyramidPath, paint);
    }
  }

  Path createPyramidPath(Size size, Offset offset) {
    Path cubePath = Path();

    // These points define the cube's shape, but adjusted for the offset
    cubePath.moveTo(offset.dx + size.width / 2, offset.dy + 0);
    cubePath.lineTo(offset.dx + size.width, offset.dy + size.height / 4);
    cubePath.lineTo(offset.dx + size.width, offset.dy + size.height * 0.75);
    cubePath.lineTo(offset.dx + size.width / 2, offset.dy + size.height);
    cubePath.lineTo(offset.dx + 0, offset.dy + size.height * 0.75);
    cubePath.lineTo(offset.dx + 0, offset.dy + size.height / 4);
    cubePath.close();

    return cubePath;
  }

  @override
  bool shouldRepaint(PyramidsPainter oldDelegate) {
    return oldDelegate.hoveredIndex != hoveredIndex;
  }
}
