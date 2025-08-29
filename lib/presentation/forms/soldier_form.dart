import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
            FormBuilderDateTimePicker(
              name: 'dateOfEnlistment',
              decoration: const InputDecoration(labelText: 'تاریخ اعزام'),
              validator: FormBuilderValidators.required(),
              valueTransformer: (value) => value?.millisecondsSinceEpoch,
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
