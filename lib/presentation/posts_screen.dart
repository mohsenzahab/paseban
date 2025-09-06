import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:paseban/domain/models/models.dart';
import 'package:paseban/presentation/cubit/monthly_post_table_cubit.dart';
import 'package:paseban/presentation/forms/soldier_form.dart';
import 'package:paseban/presentation/forms/widgets/weekday_selector.dart';

import '../domain/enums.dart';
import 'forms/base_form.dart';

const monthDays = [
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
];

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  RawGuardPost? editingPost;
  int repeat = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("پست ها")),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: BlocBuilder<MonthlyPostTableCubit, MonthlyPostTableState>(
                builder: (context, state) {
                  final posts = state.guardPosts.values.toList();
                  return Container(
                    child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text(posts[index].title),
                          title: Text(posts[index].difficulty.name),
                          subtitle: Text("${posts[index].shiftsPerDay}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  setState(() {
                                    editingPost = posts[index];
                                    final values = editingPost!.toFormValues();
                                    formKey.currentState!.patchValue(values);
                                  });
                                },
                              ),
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<MonthlyPostTableCubit>()
                                      .deleteGuardPost(posts[index].id);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: BaseForm(
                formKey: formKey,
                title: "افزودن پست",
                initialValue: editingPost?.toFormValues() ?? {},
                onSubmit: (value) {
                  final post = RawGuardPost.fromMap(value);
                  if (editingPost == null) {
                    context.read<MonthlyPostTableCubit>().addGuardPost(post);
                  } else {
                    context.read<MonthlyPostTableCubit>().editGuardPost(
                      post,
                      editingPost!.id!,
                    );
                  }
                },
                onClear: () {
                  setState(() {
                    editingPost = null;
                  });
                },

                clearButtonBehavior: ClearButtonBehavior.clear,
                builder: (BuildContext context, GlobalKey<FormBuilderState> formKey) {
                  return Column(
                    spacing: 12.0,
                    children: [
                      FormBuilderTextField(
                        name: "title",
                        decoration: const InputDecoration(labelText: "عنوان"),
                        validator: FormBuilderValidators.required(),
                      ),
                      FormBuilderTextField(
                        name: "shiftsPerDay",
                        decoration: const InputDecoration(
                          labelText: 'تعداد پاس ها',
                        ),
                        validator: FormBuilderValidators.required(),
                        keyboardType: TextInputType.number,
                        valueTransformer: (value) => int.parse(value!),
                      ),

                      FormBuilderDropdown(
                        name: 'difficulty',
                        initialValue: GuardPostDifficulty.medium.index,
                        items: GuardPostDifficulty.values
                            .map(
                              (e) => DropdownMenuItem(
                                value: e.index,
                                child: Text(e.name),
                              ),
                            )
                            .toList(),
                        decoration: const InputDecoration(labelText: 'سختی'),
                      ),

                      FormBuilderTextField(
                        name: "repeat",
                        decoration: const InputDecoration(labelText: 'تکرار'),
                        initialValue: repeat.toString(),
                        keyboardType: TextInputType.number,
                        validator: FormBuilderValidators.integer(),
                        onChanged: (value) {
                          repeat = int.tryParse(value!) ?? 1;
                          setState(() {});
                        },
                        valueTransformer: (value) => int.parse(value!),
                      ),
                      if (repeat > 1)
                        FormBuilderJalaliDatePicker(
                          name: 'periodStartDate',
                          label: 'تاریخ شروع',
                        ),

                      FormBuilderField<List<List<Weekday>>>(
                        valueTransformer: (value) => value
                            ?.map((e) => e.map((e) => e.index).toList())
                            .toList(),
                        builder: (field) {
                          return WeekdaySelector(
                            weeksCount: repeat,
                            selected: field.value,
                            onSelectionChanged: (selectedDays) {
                              field.didChange(selectedDays);
                            },
                          );
                        },
                        name: 'weekdays',
                      ),

                      FormBuilderField<List<int>>(
                        builder: (field) {
                          final selectedItems = field.value ?? [];
                          return DropdownButton2(
                            isExpanded: true,
                            items: monthDays
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: StatefulBuilder(
                                      builder: (context, menuSetState) {
                                        final isSelected = selectedItems
                                            .contains(e);
                                        return InkWell(
                                          onTap: () {
                                            isSelected
                                                ? selectedItems.remove(e)
                                                : selectedItems.add(e);
                                            //This rebuilds the StatefulWidget to update the button's text
                                            field.didChange(selectedItems);
                                            //This rebuilds the dropdownMenu Widget to update the check mark
                                            menuSetState(() {});
                                          },
                                          child: Container(
                                            height: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0,
                                            ),
                                            child: Row(
                                              children: [
                                                if (isSelected)
                                                  const Icon(
                                                    Icons.check_box_outlined,
                                                  )
                                                else
                                                  const Icon(
                                                    Icons
                                                        .check_box_outline_blank,
                                                  ),
                                                const SizedBox(width: 16),
                                                Expanded(
                                                  child: Text(
                                                    e.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                                .toList(),
                            value: selectedItems.isEmpty
                                ? null
                                : selectedItems.last,
                            onChanged: (value) {},
                            selectedItemBuilder: (context) {
                              return monthDays.map((item) {
                                return Container(
                                  alignment: AlignmentDirectional.center,
                                  child: Text(
                                    field.value?.join(', ') ?? '',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                );
                              }).toList();
                            },
                          );
                        },
                        name: 'monthDays',
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FormBuilderMultiDropdown<T> extends StatelessWidget {
  const FormBuilderMultiDropdown({
    super.key,
    required this.items,
    required this.name,
    required this.label,
    this.onChanged,
  });
  final List<DropdownMenuItem<T>> items;
  final String name;
  final String label;
  final ValueChanged<List<T>>? onChanged;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<List<T>>(
      builder: (field) {
        final selectedItems = field.value ?? [];
        return DropdownButton2(
          isExpanded: true,
          hint: Text(label),
          items: items.map((e) {
            final item = e.value;
            return DropdownMenuItem(
              value: item,
              child: StatefulBuilder(
                builder: (context, menuSetState) {
                  final isSelected = selectedItems.contains(item);
                  return InkWell(
                    onTap: () {
                      isSelected
                          ? selectedItems.remove(item)
                          : selectedItems.add(item!);
                      //This rebuilds the StatefulWidget to update the button's text
                      field.didChange(selectedItems);
                      onChanged?.call(selectedItems);
                      //This rebuilds the dropdownMenu Widget to update the check mark
                      menuSetState(() {});
                    },
                    child: Container(
                      height: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          if (isSelected)
                            const Icon(Icons.check_box_outlined)
                          else
                            const Icon(Icons.check_box_outline_blank),
                          const SizedBox(width: 16),
                          Expanded(child: e.child),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }).toList(),
          value: selectedItems.isEmpty ? null : selectedItems.last,
          onChanged: (value) {},
          selectedItemBuilder: (context) {
            return items.map((item) {
              return Container(
                alignment: AlignmentDirectional.center,
                child: Text(
                  field.value?.join(', ') ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              );
            }).toList();
          },
        );
      },
      name: name,
    );
  }
}
