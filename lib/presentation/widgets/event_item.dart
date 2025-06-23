import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:universal_assistant/domain/entities/event.dart';

import '../../i18n/strings.g.dart';
import '../calendar/cubit/calendar/calendar_cubit.dart';
import 'custom_check_box.dart';

class EventItem extends StatefulWidget {
  EventItem({super.key, required this.event});

  Event event;

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Row(
        children: [

          const SizedBox(
            width: 18,
          ),
          Expanded(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                  color: Colors.white, //isCompleted! ? Colors.white30 :
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.inactiveGray,
                      blurRadius: 6,
                      blurStyle: BlurStyle.outer,
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.event.name,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors
                                .black,
                          ),
                        ),
                        Theme(
                          data: Theme.of(context).copyWith(
                            popupMenuTheme: PopupMenuThemeData(
                              color: Colors.grey[100],
                              textStyle: const TextStyle(
                                  color: Colors.black),
                            ),
                          ),
                          child: PopupMenuButton(
                            icon: Image.asset(
                              'assets/icons/action_menu.png',
                              height: 25,
                            ),
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  child: Text(t.Delete),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: Text(t.Attention),
                                        content: Text(t.SureDeleteEvent),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              context.read<CalendarCubit>()
                                                ..deleteEvent(widget.event.id)
                                                ..fetchCalendar();
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              t.Yes,
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              t.No,
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                    print('action_menu_delete');
                                  },
                                ),
                              ];
                            },
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.event.info,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[
                              700]), //isCompleted! ? Colors.grey[700] : Colors.grey[800]
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${NumberFormat("00").format(widget.event.dateStart.hour)}:${NumberFormat("00").format(widget.event.dateStart.minute)}-${NumberFormat("00").format(widget.event.dateEnd.hour)}:${NumberFormat("00").format(widget.event.dateEnd.minute)}',
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors
                                        .black), //isCompleted! ? Colors.grey[700] :
                              ),
                              widget.event.repetition
                                  ? Image.asset(
                                      'assets/icons/refresh.png',
                                      height: 15,
                                    )
                                  : const SizedBox.shrink(),
                              Image.asset(
                                'assets/icons/flag2.png',
                                height: 15,
                              ),
                            ],
                          ),
                          widget.event.tags != null
                              ? Text(
                                  widget.event.tags!
                                      .map((item) => item.name)
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors
                                          .black), //isCompleted! ? Colors.grey[700] :
                                  overflow: TextOverflow.ellipsis,
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
