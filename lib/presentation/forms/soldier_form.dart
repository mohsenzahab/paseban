import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl_date_picker/intl_date_picker.dart';
import 'package:paseban/core/utils/date_helper.dart';
import 'package:paseban/presentation/cubit/monthly_post_table_cubit.dart';
import 'package:paseban/presentation/forms/base_form.dart';

import '../../domain/enums.dart';
import '../../domain/models/post_policies.dart';
import '../../domain/models/soldier.dart';
import '../tiles/policy_tile.dart';
import 'policy_form.dart';

class SoldierForm extends StatefulWidget {
  const SoldierForm({super.key, this.soldier});

  final Soldier? soldier;

  @override
  State<SoldierForm> createState() => _SoldierFormState();

  static Future<T?> show<T>(BuildContext context, {Soldier? soldier}) {
    return showDialog<T>(
      context: context,
      builder: (context) => Dialog(child: SoldierForm(soldier: soldier)),
    );
  }
}

class _SoldierFormState extends State<SoldierForm> {
  PostPolicy? editingPolicy;

  @override
  void initState() {
    super.initState();
  }

  Soldier? get soldier => widget.soldier;

  bool get isEdit => soldier != null;

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      title: 'افزودن سرباز',
      initialValue: soldier?.toFormValues(),
      onSubmit: (value) {
        final bloc = context.read<MonthlyPostTableCubit>();
        if (isEdit) {
          bloc.editSoldier(value, soldier!.id!);
        } else {
          bloc.addSoldier(value);
        }
        Navigator.pop(context);
      },
      builder: (context, formKey) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 12.0,
          children: [
            Flexible(
              child: Column(
                spacing: 12.0,
                children: [
                  FormBuilderTextField(
                    name: 'firstName',
                    decoration: const InputDecoration(labelText: 'نام'),
                    keyboardType: TextInputType.name,

                    validator: FormBuilderValidators.required(),
                  ),
                  FormBuilderTextField(
                    name: 'lastName',
                    decoration: const InputDecoration(
                      labelText: 'نام خانوادگی',
                    ),
                    keyboardType: TextInputType.name,
                    validator: FormBuilderValidators.required(),
                  ),

                  FormBuilderDropdown(
                    name: 'rank',
                    decoration: const InputDecoration(labelText: 'درجه'),
                    items: MilitaryRank.values.map((e) {
                      return DropdownMenuItem(
                        value: e.index,
                        child: Text(e.faName),
                      );
                    }).toList(),
                    validator: FormBuilderValidators.required(),
                  ),

                  FormBuilderJalaliDatePicker(
                    name: 'dateOfEnlistment',
                    label: 'تاریخ اعزام',
                  ),
                  FormBuilderTextField(
                    name: 'nickName',
                    decoration: const InputDecoration(labelText: 'نام مستعار'),
                    keyboardType: TextInputType.name,
                  ),
                  FormBuilderTextField(
                    name: 'militaryId',
                    decoration: const InputDecoration(labelText: 'شناسه'),
                  ),
                  FormBuilderTextField(
                    name: 'phoneNumber',
                    decoration: const InputDecoration(labelText: 'شماره تماس'),
                  ),
                  FormBuilderDateTimePicker(
                    name: 'dateOfBirth',
                    decoration: const InputDecoration(labelText: 'تاریخ تولد'),
                  ),
                ],
              ),
            ),
            Flexible(
              child: BlocBuilder<MonthlyPostTableCubit, MonthlyPostTableState>(
                builder: (context, state) {
                  final policies = soldier == null
                      ? []
                      : state.soldierPolicies[soldier!.id];
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: (policies?.length ?? 0) + 1,
                    itemBuilder: (context, index) {
                      if (index == (policies?.length ?? 0)) {
                        return PolicyForm(
                          policy: editingPolicy,
                          soldier: soldier,
                          onCleared: () => setState(() {
                            editingPolicy = null;
                          }),
                          onSubmit: (value) {
                            setState(() {
                              if (editingPolicy == null) {
                                context.read<MonthlyPostTableCubit>().addPolicy(
                                  value,
                                );
                              } else {
                                context
                                    .read<MonthlyPostTableCubit>()
                                    .editPolicy(value, editingPolicy!.id!);
                              }
                              editingPolicy = null;
                            });
                          },
                        );
                      }
                      final policy = policies![index];
                      return PolicyTile(
                        policy: policy,
                        onEdit: (value) {
                          setState(() {
                            editingPolicy = policy;
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class FormBuilderJalaliDatePicker extends StatelessWidget {
  const FormBuilderJalaliDatePicker({
    super.key,
    required this.name,
    required this.label,
    this.onChanged,
    this.initialDate,
    this.firstDate,
    this.lastDate,
  });

  final void Function(DateTime? value)? onChanged;
  final String label;
  final String name;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<DateTime>(
      name: name,
      validator: FormBuilderValidators.required(),
      valueTransformer: (value) => value?.toIso8601String(),
      builder: (field) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0),
            // border: InputBorder.none,
            errorText: field.errorText,
          ),
          child: TextButton(
            child: Text(
              field.value == null
                  ? label
                  : formatJalaliCompactDate(field.value!),
            ),
            onPressed: () async {
              final date = await showIntlDatePicker(
                context: context,
                calendarMode: Calendar.jalali,
                initialDate: initialDate ?? DateTime.now(),
                firstDate:
                    firstDate ??
                    DateTime.now().addYears(-4, CalendarMode.jalali),
                lastDate:
                    lastDate ??
                    DateTime.now().monthEndDate(CalendarMode.jalali),
              );
              field.didChange(date);
              onChanged?.call(date);
            },
          ),
        );
      },
    );
  }
}
