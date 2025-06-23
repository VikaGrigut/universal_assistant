import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enums/languages.dart';
import '../../../i18n/strings.g.dart';
import '../../home/cubit/home_cubit.dart';
import '../../widgets/custom_check_box.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  @override
  Widget build(BuildContext context) {

    Languages lang = context.select((HomeCubit cubit) => cubit.state.language);
    return AlertDialog(
                      title: Text(
                        t.Settings,
                        style: const TextStyle(fontSize: 20),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            t.SelectLanguage,
                            style: const TextStyle(fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              children: List.generate(
                                Languages.values.length,
                                (int index) {
                                  return Row(
                                    children: [
                                      CustomCheckbox(
                                        value: Languages.values[index] == lang
                                            ? true
                                            : false,
                                        onChanged: (value) {
                                          if (value == true) {
                                            context
                                                .read<HomeCubit>()
                                                .changeLanguage(
                                                    Languages.values[index]);

                                            setState(() {
                                              lang = Languages.values[index];
                                            });
                                          }
                                        },
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        Languages.values[index].name,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    );
  }
}
