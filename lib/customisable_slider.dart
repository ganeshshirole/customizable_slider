library customizable_slider;

import 'dart:async';

import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget(
      {Key key,
        this.initialPage: 0,
        this.viewportFraction: 1,
        this.viewportPadding: const EdgeInsets.all(0),
        this.viewportRadius: 0,
        this.constraints: const BoxConstraints.expand(height: 145),
        @required this.widgets,
        this.backgroundColor: Colors.transparent,
        this.animationDuration: const Duration(milliseconds: 300),
        this.animationCurve: Curves.ease,
        this.autoPlayDuration: const Duration(seconds: 3),
        this.autoPlay: true,
        this.indicatorMainAxisSize: MainAxisSize.min,
        this.indicatorBackgroundRadius: 5,
        this.indicatorBackgroundColor: Colors.white54,
        this.indicatorMargin: const EdgeInsets.only(bottom: 12),
        this.indicatorPadding: const EdgeInsets.all(0),
        this.indicatorAlignment: Alignment.bottomCenter,
        this.dotSize: 6,
        this.dotMargin: const EdgeInsets.all(2.5),
        this.dotSelectedColor: Colors.white,
        this.dotColor: Colors.grey})
      : assert(initialPage != null),
        assert(viewportFraction != null),
        assert(viewportPadding != null),
        assert(viewportRadius != null),
        assert(constraints != null),
        assert(widgets != null),
        assert(backgroundColor != null),
        assert(animationDuration != null),
        assert(animationCurve != null),
        assert(autoPlayDuration != null),
        assert(autoPlay != null),
        assert(indicatorMainAxisSize != null),
        assert(indicatorBackgroundRadius != null),
        assert(indicatorBackgroundColor != null),
        assert(indicatorMargin != null),
        assert(indicatorPadding != null),
        assert(indicatorAlignment != null),
        assert(dotSize != null),
        assert(dotMargin != null),
        assert(dotSelectedColor != null),
        assert(dotColor != null),
        super(key: key);

  final int initialPage;
  final double viewportFraction;
  final double viewportRadius;
  final EdgeInsets viewportPadding;
  final BoxConstraints constraints;
  final List<Widget> widgets;
  final Color backgroundColor;
  final bool autoPlay;
  final Cubic animationCurve;
  final Duration autoPlayDuration;

  final MainAxisSize indicatorMainAxisSize;
  final double indicatorBackgroundRadius;
  final Color indicatorBackgroundColor;
  final EdgeInsets indicatorMargin;
  final EdgeInsets indicatorPadding;
  final AlignmentGeometry indicatorAlignment;

  final EdgeInsets dotMargin;
  final double dotSize;
  final Color dotSelectedColor;
  final Color dotColor;

  //The transition animation duration. Default is 300ms.
  final Duration animationDuration;

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  PageController _controller;
  Timer timer;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
        initialPage: widget.initialPage,
        viewportFraction: widget.viewportFraction);

    if (widget.autoPlay) {
      timer = Timer.periodic(widget.autoPlayDuration, (_) {
        if (_controller.page.round() == widget.widgets.length - 1) {
          _controller.animateToPage(
            0,
            duration: widget.animationDuration,
            curve: widget.animationCurve,
          );
        } else {
          _controller.nextPage(
              duration: widget.animationDuration, curve: widget.animationCurve);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller = null;
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> listWidgets = widget.widgets
        .map((netWidget) => Padding(
      padding: widget.viewportPadding,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.viewportRadius),
          child: netWidget),
    ))
        .toList();

    return Stack(
      alignment: widget.indicatorAlignment,
      children: <Widget>[
        Container(
          constraints: widget.constraints,
          color: widget.backgroundColor,
          child: PageView(
            physics: AlwaysScrollableScrollPhysics(),
            children: listWidgets,
            controller: _controller,
          ),
        ),
        Container(
          margin: widget.indicatorMargin,
          child: ClipRRect(
            borderRadius:
            BorderRadius.circular(widget.indicatorBackgroundRadius),
            child: Container(
              padding: widget.indicatorPadding,
              color: widget.indicatorBackgroundColor,
              child: Indicator(
                controller: _controller,
                itemCount: widget.widgets.length,
                dotSize: widget.dotSize,
                dotMargin: widget.dotMargin,
                dotColor: widget.dotColor,
                dotSelectedColor: widget.dotSelectedColor,
                indicatorMainAxisSize: widget.indicatorMainAxisSize,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Indicator extends AnimatedWidget {
  final PageController controller;
  final int itemCount;
  final double dotSize;
  final EdgeInsets dotMargin;
  final Color dotSelectedColor;
  final Color dotColor;
  final MainAxisSize indicatorMainAxisSize;

  Indicator(
      {this.controller,
        this.itemCount,
        this.dotSize,
        this.dotMargin,
        this.dotColor,
        this.dotSelectedColor,
        this.indicatorMainAxisSize})
      : super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: indicatorMainAxisSize,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(itemCount, _buildDot),
    );
  }

  Widget _buildDot(int index) {
    return Padding(
      padding: dotMargin,
      child: ClipOval(
        child: Container(
          height: dotSize,
          width: dotSize,
          color:
          index == (controller.page != null ? controller.page.round() : 0)
              ? dotSelectedColor
              : dotColor,
        ),
      ),
    );
  }
}

