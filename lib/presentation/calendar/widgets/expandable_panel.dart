import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/calendar/calendar_cubit.dart';

class ExpandablePanel extends StatefulWidget {
  const ExpandablePanel({
    super.key,
    required this.header,
    this.body,
    this.expanded,
    this.collapsed,
    this.headerPadding = const EdgeInsets.all(16),
    this.isInitialExpanded = false,
    this.expanderBuilder,
  });

  ExpandablePanel.expandCollapse({
    super.key,
    required this.header,
    this.body,
    this.collapsed,
    this.expanded,
    this.headerPadding = const EdgeInsets.all(16),
    this.isInitialExpanded = false,
  }) : expanderBuilder = ((_, expanded) => ExpandCollapseExpander(
              expanded: expanded,
            ));

  final Widget header;
  final Widget? body;
  final Widget? collapsed;
  final Widget? expanded;
  final EdgeInsets headerPadding;
  final bool isInitialExpanded;
  final Widget Function(BuildContext context, bool expanded)? expanderBuilder;

  @override
  State<ExpandablePanel> createState() => _ExpandablePanelState();
}

class _ExpandablePanelState extends State<ExpandablePanel> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.isInitialExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(),
        _buildBody(),
        _buildCollapsed(),
        _buildExpanded(),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: widget.headerPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Expanded(
          //   child: widget.header,
          // ),
          Row(
            children: [
              widget.header,
              const SizedBox(width: 10),
              _buildExpander(),
            ],
          ),
          IconButton(
            onPressed: () => context.read<CalendarCubit>()..currentDate(),
            icon: const Icon(
              Icons.calendar_today,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    return widget.body == null ? const SizedBox.shrink() : widget.body!;
  }

  Widget _buildCollapsed() {
    return widget.collapsed == null || _expanded
        ? const SizedBox.shrink()
        : widget.collapsed!;
  }

  Widget _buildExpanded() {
    return widget.expanded == null || !_expanded
        ? const SizedBox.shrink()
        : widget.expanded!;
  }

  Widget _buildExpander() {
    return widget.expanderBuilder == null
        ? const SizedBox.shrink()
        : CupertinoButton(
            padding: EdgeInsets.zero,
            minSize: 20,
            onPressed: _toggle,
            child: widget.expanderBuilder!.call(context, _expanded),
          );
  }

  void _toggle() {
    setState(() => _expanded = !_expanded);
  }
}

class ExpandCollapseExpander extends StatelessWidget {
  const ExpandCollapseExpander({
    super.key,
    required this.expanded,
  });

  final bool expanded;

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    if (expanded) {
      icon = CupertinoIcons.chevron_up;
      color = CupertinoColors.secondaryLabel.withOpacity(0.6);
    } else {
      icon = CupertinoIcons.chevron_down;
      color = CupertinoTheme.of(context).primaryColor;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Icon(
            icon,
            size: 19,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
