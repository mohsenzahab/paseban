import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:paseban/domain/models/models.dart';
import 'package:paseban/presentation/cubit/monthly_post_table_cubit.dart';
import 'package:paseban/presentation/forms/base_form.dart';
import 'package:paseban/presentation/forms/soldier_form.dart';
import 'package:paseban/presentation/forms/widgets/conscription_stage_field.dart';
import 'package:paseban/presentation/posts_screen.dart';

class PolicyForm extends StatefulWidget {
  const PolicyForm({
    super.key,
    this.policy,
    this.soldier,
    this.onSubmit,
    this.onCleared,
  });

  final VoidCallback? onCleared;
  final ValueChanged<PostPolicy>? onSubmit;
  final PostPolicy? policy;
  final Soldier? soldier;

  @override
  State<PolicyForm> createState() => _PolicyFormState();
}

class _PolicyFormState extends State<PolicyForm> {
  Widget Function(ConscriptionStage? key)? _conscriptionStageFieldBuilder;
  Map<ConscriptionStage, dynamic>? conscriptionStages;
  PostPolicy? editing;
  DateTime? end;
  final formKey = GlobalKey<FormBuilderState>();
  late bool isEdit;
  List<Widget>? stageFields;
  DateTime? start;
  PostPolicyType? type;
  late final List<PostPolicyType> types;

  Priority? _priority;

  @override
  didUpdateWidget(covariant PolicyForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    isEdit = widget.policy != null;
    if (oldWidget.policy != widget.policy) {
      editing = widget.policy;
      type = editing?.type;
      priority = editing?.priority;
      if (editing is StagedPostPolicy) {
        conscriptionStages = (editing as StagedPostPolicy).stagePriority;
      } else {
        conscriptionStages = null;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    isEdit = widget.policy != null;
    types = soldierId != null
        ? PostPolicyType.values.take(9).toList()
        : PostPolicyType.values.skip(3).toList();

    editing = widget.policy;
    if (editing != null) {
      type = editing!.type;
      priority = editing!.priority;
      if (editing is StagedPostPolicy) {
        conscriptionStages = (editing as StagedPostPolicy).stagePriority;
      } else {
        conscriptionStages = null;
      }
    }
  }

  Priority? get priority => _priority ?? editing?.priority;

  set priority(Priority? value) => _priority ??= value;

  int? get soldierId => widget.soldier?.id!;

  List<Widget> getPolicyWidget(GlobalKey<FormBuilderState> formKey) {
    final cubit = context.read<MonthlyPostTableCubit>();
    List<Widget> widgets = [];
    switch (type!) {
      case PostPolicyType.leave:
        if (soldierId == null) break;

        priority = Priority.absolute;
        widgets = [
          FormBuilderJalaliDatePicker(
            name: 'start',
            label: 'تاریخ شروع مرخصی',
            onChanged: (value) {
              start = value;
              _initLeavePolicy();
              setState(() {});
            },
          ),
          FormBuilderJalaliDatePicker(
            name: 'end',
            label: 'تاریخ پایان مرخصی',
            onChanged: (value) {
              end = value;
              _initLeavePolicy();
              setState(() {});
            },
          ),
        ];
        break;
      case PostPolicyType.friendSoldiers:
        if (soldierId == null) break;
        priority = Priority.veryLow;
        widgets = [
          FormBuilderMultiDropdown(
            label: 'دوستان',
            onChanged: (value) {
              _initFriendsPolicy(value);
              setState(() {});
            },
            items: cubit.state.soldiers.values
                .skipWhile((value) => value.id == widget.soldier!.id!)
                .map(
                  (e) => DropdownMenuItem(
                    value: e.id!,
                    child: Text("${e.firstName} ${e.lastName}"),
                  ),
                )
                .toList(),
            name: 'value',
          ),
        ];
        break;

      case PostPolicyType.weekOffDays:
        if (soldierId == null) break;

        priority = Priority.low;
        widgets = [
          FormBuilderMultiDropdown(
            label: 'روزهای آف',

            items: Weekday.values
                .map(
                  (e) => DropdownMenuItem(value: e.index, child: Text(e.name)),
                )
                .toList(),
            name: 'value',
            onChanged: (value) {
              _initWeekOffDaysPolicy(value);
              setState(() {});
            },
          ),
        ];
        break;

      case PostPolicyType.noNightNNight:
        priority = Priority.medium;

        widgets = [
          FormBuilderTextField(
            name: 'value',
            decoration: const InputDecoration(labelText: 'فاصله نگهبانی'),
            validator: FormBuilderValidators.integer(),
            onChanged: (value) {
              _initNoNightPolicy(value);
              setState(() {});
            },
          ),
        ];
        break;

      case PostPolicyType.noNight1Night:
        priority = Priority.veryHigh;
        widgets = [];
        editing = PostPolicy.noNight1Night(soldierId: soldierId);

        break;
      case PostPolicyType.noNight2Night:
        priority = Priority.high;
        widgets = [];
        editing = PostPolicy.noNight2Night(soldierId: soldierId);
        break;

      case PostPolicyType.minPostCount:
        priority = Priority.medium;
        widgets = [
          FormBuilderTextField(
            name: 'value',
            decoration: const InputDecoration(labelText: 'حداقل تعداد پست ها'),
            validator: FormBuilderValidators.integer(),
            onChanged: (value) {
              _initMinPostCountPolicy(value);
              setState(() {});
            },
          ),
        ];
        _initConscriptionStageFields<int>();
        break;

      case PostPolicyType.maxPostCount:
        priority = Priority.high;
        widgets = [
          FormBuilderTextField(
            name: 'value',
            decoration: const InputDecoration(labelText: 'حداکثر تعداد پست ها'),
            validator: FormBuilderValidators.integer(),
            onChanged: (value) {
              _initMaxPostCountPolicy(value);
              setState(() {});
            },
          ),
        ];
        _initConscriptionStageFields<int>();

        break;

      case PostPolicyType.noWeekendPerMonth:
        priority = Priority.veryHigh;
        widgets = [
          FormBuilderTextField(
            name: 'value',
            decoration: const InputDecoration(labelText: 'تعداد روز '),
            validator: FormBuilderValidators.integer(),
            onChanged: (value) {
              _initNoWeekendPerMonthPolicy(value);
              setState(() {});
            },
          ),
        ];
        _initConscriptionStageFields<int>();
        break;

      case PostPolicyType.equalHolidayPost:
        if (soldierId != null) break;

        priority = Priority.medium;
        widgets = [];
        editing = PostPolicy.equalHolidayPost();
        _initConscriptionStageFields<int>();
        break;

      case PostPolicyType.equalPostDifficulty:
        if (soldierId != null) break;

        priority = Priority.medium;
        widgets = [];
        editing = PostPolicy.equalPostDifficulty();
        _initConscriptionStageFields<GuardPostDifficulty>();
        break;
    }
    formKey.currentState!.patchValue({'priority': priority!.index});
    return widgets;
  }

  MonthlyPostTableCubit get cubit => context.read<MonthlyPostTableCubit>();

  void _initFriendsPolicy(List<DropdownMenuItem<int>> value) {
    final soldiers = cubit.state.soldiers;
    editing = PostPolicy.friendSoldiers(
      soldierId: soldierId,
      value: value.map((e) => soldiers[e.value]!.id!).toList(),
    );
  }

  void _initLeavePolicy() {
    if (start != null && end != null) {
      editing = PostPolicy.leave(
        soldierId: soldierId,
        value: DateTimeRange(start: start!, end: end!),
      );
    }
  }

  void _initWeekOffDaysPolicy(List<DropdownMenuItem<int>> value) {
    editing = PostPolicy.weekOffDays(
      soldierId: soldierId,
      value: value.map((e) => Weekday.values[e.value!]).toList(),
    );
  }

  void _initNoNightPolicy(String? value) {
    if (value != null) {
      editing = PostPolicy.noNightNNight(
        soldierId: soldierId,
        value: int.parse(value),
      );
    }
  }

  void _initMinPostCountPolicy(String? value) {
    if (value != null) {
      editing = PostPolicy.minPostCount(
        soldierId: soldierId,
        value: int.parse(value),
      );
    }
  }

  void _initMaxPostCountPolicy(String? value) {
    if (value != null) {
      editing = PostPolicy.maxPostCount(
        soldierId: soldierId,
        value: int.parse(value),
      );
    }
  }

  void _initNoWeekendPerMonthPolicy(String? value) {
    if (value != null) {
      editing = PostPolicy.noWeekendPerMonth(
        soldierId: soldierId,
        value: int.parse(value),
      );
    }
  }

  void _initConscriptionStageFields<T>() {
    conscriptionStages ??= <ConscriptionStage, T>{};
    _conscriptionStageFieldBuilder = (ConscriptionStage? key) {
      return ConscriptionStageField<T>(
        stage: key,
        value: key == null ? null : conscriptionStages![key],
        onValueCreated: (v) {
          conscriptionStages![v.$1] = v.$2;
          setState(() {});
        },
        onValueEdited: (v) {
          conscriptionStages!.remove(key);
          conscriptionStages![v.$1] = v.$2;
          setState(() {});
        },
        onStageDeleted: (stage) {
          conscriptionStages!.remove(stage);

          setState(() {});
        },
        availableStages: ConscriptionStage.values.where((stage) {
          return !conscriptionStages!.keys.contains(stage) || key == stage;
        }).toList(),
      );
    };
  }

  void _clear() {
    editing = null;
    conscriptionStages = null;
    priority = null;
    type = null;
    isEdit = false;
    // formKey.currentState!.reset();
    setState(() {});
    widget.onCleared?.call();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BaseForm(
        // key: formKey,
        addButtonLabel: !isEdit ? 'افزودن سیاست' : 'ویرایش   سیاست',
        clearButtonLabel: 'پاک کردن فرم',
        clearButtonBehavior: ClearButtonBehavior.clear,
        initialValue: editing?.toFormValues() ?? {},
        onSubmit: (value) {
          if (editing is StagedPostPolicy) {
            editing =
                (editing as StagedPostPolicy).copyWith(
                      stagePriority: conscriptionStages,
                    )
                    as PostPolicy;
          }
          widget.onSubmit?.call(editing!.copyWith(priority: priority));
          _clear();
        },
        onClear: () {
          _clear();
        },
        builder: (context, formKey) {
          final widgets = type == null ? [] : getPolicyWidget(formKey);

          return Column(
            spacing: 12.0,
            children: [
              InputDecorator(
                decoration: InputDecoration(
                  labelText: 'نوع سیاست',
                  hintText: 'نوع سیاست را انتخاب کنید',
                  isCollapsed: true,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    value: type,
                    items: types.map((e) {
                      return DropdownMenuItem(value: e, child: Text(e.title));
                    }).toList(),
                    selectedItemBuilder: (context) =>
                        types.map((e) => Center(child: Text(e.title))).toList(),
                    onChanged: (PostPolicyType? value) {
                      setState(() {
                        type = value;
                        conscriptionStages = null;
                      });
                    },
                  ),
                ),
              ),
              if (type != null) ...widgets,
              if (priority != null)
                FormBuilderDropdown(
                  name: 'priority',
                  decoration: const InputDecoration(labelText: ' الویت سیاست'),
                  initialValue: priority!.index,
                  items: Priority.values
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.index,
                          child: Text(e.nameFa),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    priority = Priority.values[value!];
                    // setState(() {});
                  },
                ),
              if (conscriptionStages != null && soldierId == null)
                Form(
                  child: InputDecorator(
                    decoration: const InputDecoration(isCollapsed: true),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        spacing: 12,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (conscriptionStages!.isNotEmpty)
                            ...conscriptionStages!.keys.map(
                              _conscriptionStageFieldBuilder!,
                            ),

                          _conscriptionStageFieldBuilder!(null),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
        title: "افزودن سیاست",
      ),
    );
  }
}
