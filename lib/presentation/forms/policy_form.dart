import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:paseban/domain/models/models.dart';
import 'package:paseban/presentation/cubit/monthly_post_table_cubit.dart';
import 'package:paseban/presentation/forms/base_form.dart';
import 'package:paseban/presentation/forms/soldier_form.dart';
import 'package:paseban/presentation/posts_screen.dart';

class PolicyForm extends StatelessWidget {
  const PolicyForm({super.key, this.policy});
  final PostPolicy? policy;

  @override
  Widget build(BuildContext context) {
    PostPolicyType? type;

    return BaseForm(
      builder: (context, formKey) {
        return StatefulBuilder(
          builder: (context, setState) {
            final title = type?.title;

            return Column(
              spacing: 12.0,
              children: [
                DropdownButton(
                  value: type,
                  items: PostPolicyType.values.map((e) {
                    return DropdownMenuItem(value: e, child: Text(e.title));
                  }).toList(),
                  selectedItemBuilder: (context) =>
                      PostPolicyType.values.map((e) => Text(e.title)).toList(),
                  onChanged: (PostPolicyType? value) {
                    type = value;
                    setState(() {});
                  },
                ),
                if (title != null) Text(title),
                if (type != null) ...getPolicyWidget(context, type!),
              ],
            );
          },
        );
      },
      title: "افزودن سیاست",
    );
  }

  List<Widget> getPolicyWidget(
    BuildContext context,
    PostPolicyType type, {
    int? soldierId,
  }) {
    final cubit = context.read<MonthlyPostTableCubit>();
    final List<Widget> widgets = switch (type) {
      PostPolicyType.leave => [
        FormBuilderJalaliDatePicker(name: 'start', label: 'تاریخ شروع مرخصی'),
        FormBuilderJalaliDatePicker(name: 'end', label: 'تاریخ پایان مرخصی'),
      ],

      PostPolicyType.friendSoldiers => [
        FormBuilderMultiDropdown(
          label: 'دوستان',
          items: cubit.state.soldiers.values
              .skipWhile((value) => value.id == soldierId)
              .map(
                (e) => DropdownMenuItem(
                  value: e.id!,
                  child: Text("${e.firstName} ${e.lastName}"),
                ),
              )
              .toList(),
          name: 'value',
        ),
      ],

      PostPolicyType.weekOffDays => [
        FormBuilderMultiDropdown(
          label: 'روزهای آفلاین',
          items: Weekday.values
              .map((e) => DropdownMenuItem(value: e.index, child: Text(e.name)))
              .toList(),
          name: 'value',
        ),
      ],

      PostPolicyType.noNightNNight => [
        FormBuilderTextField(
          name: 'value',
          validator: FormBuilderValidators.required(),
        ),
      ],

      PostPolicyType.noNight1Night => [],

      PostPolicyType.noNight2Night => [],

      PostPolicyType.minPostCount => [
        FormBuilderTextField(
          name: 'value',
          validator: FormBuilderValidators.required(),
        ),
      ],

      PostPolicyType.maxPostCount => [
        FormBuilderTextField(
          name: 'value',
          validator: FormBuilderValidators.required(),
        ),
      ],

      PostPolicyType.noWeekendPerMonth => [
        FormBuilderTextField(
          name: 'value',
          validator: FormBuilderValidators.required(),
        ),
      ],

      PostPolicyType.equalHolidayPost => [],

      PostPolicyType.equalPostDifficulty => [],
    };
    widgets.add(
      FormBuilderDropdown(
        name: 'priority',
        items: Priority.values
            .map((e) => DropdownMenuItem(value: e.index, child: Text(e.name)))
            .toList(),
      ),
    );
    return widgets;
  }
}
