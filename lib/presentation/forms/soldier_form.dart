import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl_date_picker/intl_date_picker.dart';
import 'package:paseban/core/utils/date_helper.dart';
import 'package:paseban/presentation/cubit/monthly_post_table_cubit.dart';
import 'package:paseban/presentation/forms/base_form.dart';

import '../../domain/enums.dart';
import '../../domain/models/soldier.dart';

class SoldierForm extends StatefulWidget {
  const SoldierForm({super.key, this.soldier});
  final Soldier? soldier;

  static Future<T?> show<T>(BuildContext context, {Soldier? soldier}) {
    return showDialog<T>(
      context: context,
      builder: (context) => Dialog(child: SoldierForm(soldier: soldier)),
    );
  }

  @override
  State<SoldierForm> createState() => _SoldierFormState();
}

class _SoldierFormState extends State<SoldierForm> {
  Soldier? get soldier => widget.soldier;
  bool get isEdit => soldier != null;

  @override
  void initState() {
    super.initState();
  }

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
        return Column(
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
              decoration: const InputDecoration(labelText: 'نام خانوادگی'),
              keyboardType: TextInputType.name,
              validator: FormBuilderValidators.required(),
            ),

            FormBuilderDropdown(
              name: 'rank',
              decoration: const InputDecoration(labelText: 'درجه'),
              items: MilitaryRank.values.map((e) {
                return DropdownMenuItem(value: e.index, child: Text(e.faName));
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
  });

  final String name;
  final String label;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<DateTime>(
      name: name,
      validator: FormBuilderValidators.required(),
      valueTransformer: (value) => value?.millisecondsSinceEpoch,
      builder: (field) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0),
            border: InputBorder.none,
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
                initialDate: DateTime.now().addYears(-1, CalendarMode.jalali),
                firstDate: DateTime.now().addYears(-4, CalendarMode.jalali),
                lastDate: DateTime.now(),
              );
              if (date != null) field.didChange(date);
            },
          ),
        );
      },
    );
  }
}
