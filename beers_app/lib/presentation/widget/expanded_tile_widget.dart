import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandedWidget extends StatefulWidget {
  final Stream<int>? stream;
  final Function dispatchOnExpanded;
  final Function dispatchOn;
  final int? objectId;
  final String? title;
  final Widget? childExpanded;

  const ExpandedWidget({
    @required this.stream,
    required this.dispatchOnExpanded,
    required this.dispatchOn,
    @required this.objectId,
    @required this.title,
    @required this.childExpanded,
  })  : assert(stream != null),
        assert(dispatchOnExpanded != null),
        assert(dispatchOn != null),
        assert(objectId != null),
        assert(title != null),
        assert(childExpanded != null);
  @override
  _ExpandedWidgetState createState() => _ExpandedWidgetState();
}

class _ExpandedWidgetState extends State<ExpandedWidget>
    with TickerProviderStateMixin {
  Stream<int>? get stream => widget.stream;
  Function get dispatchOnExpanded => widget.dispatchOnExpanded;
  Function get dispatchOn => widget.dispatchOn;
  int? get objectId => widget.objectId;
  String? get title => widget.title;
  Widget? get childExpanded => widget.childExpanded;

  @override
  Widget build(BuildContext context) {
    final AnimationController _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    final Animation arrowAnimation =
        Tween(begin: 0.0, end: pi).animate(_controller);

    return _buildContent(_controller, arrowAnimation);
  }

  Widget _buildContent(
      AnimationController _controller, Animation _arrowAnimation) {
    return StreamBuilder<int>(
      stream: stream,
      builder: (context, snapshot) {
        int opened = snapshot.data ?? 0;

        bool? isExpanded = opened == objectId;

        return GestureDetector(
          onTap: () {
            if (isExpanded) {
              _controller.reverse();
              dispatchOn.call();
            } else {
              _controller.forward();
              dispatchOnExpanded.call();
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(color: Colors.black45),
              _buildRowTitle(_controller, _arrowAnimation),
              const SizedBox(height: 5),
              _buildExpandedChild(isExpanded),
              const Divider(color: Colors.black45),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRowTitle(
      AnimationController _controller, Animation _arrowAnimation) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title!,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Transform.rotate(
                  angle: _arrowAnimation.value as double,
                  child: const Icon(Icons.expand_more),
                ),
              ],
            ),
          );
        });
  }

  Widget _buildExpandedChild(bool isExpanded) {
    return Visibility(
      visible: isExpanded,
      child: childExpanded!,
      replacement: const SizedBox(),
    );
  }
}
