import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:paseban/domain/models/models.dart';
import 'package:paseban/presentation/cubit/monthly_post_table_cubit.dart';

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
  GuardPost? editingPost;
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
                                    formKey.currentState!.patchValue(
                                      editingPost!.toFormValues(),
                                    );
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
              flex: 1,
              child: FormBuilder(
                key: formKey,
                initialValue: editingPost?.toFormValues() ?? {},
                child: Column(
                  spacing: 12.0,
                  children: [
                    const Text("افزودن پست"),
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
                    FormBuilderTextField(
                      name: "repeat",
                      decoration: const InputDecoration(labelText: 'تکرار'),
                      initialValue: 1.toString(),
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

                    FormBuilderField<List<Weekday>>(
                      valueTransformer: (value) =>
                          value?.map((e) => e.index).toList(),
                      builder: (field) {
                        final selectedItems = field.value ?? [];

                        return DropdownButton2(
                          isExpanded: true,
                          items: Weekday.values
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item,
                                  //disable default onTap to avoid closing menu when selecting an item
                                  enabled: false,
                                  child: StatefulBuilder(
                                    builder: (context, menuSetState) {
                                      final isSelected = selectedItems.contains(
                                        item,
                                      );
                                      return InkWell(
                                        onTap: () {
                                          isSelected
                                              ? selectedItems.remove(item)
                                              : selectedItems.add(item);
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
                                                  Icons.check_box_outline_blank,
                                                ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: Text(
                                                  item.name,
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
                          onChanged: (value) {
                            field.didChange(selectedItems.toList());
                          },
                          selectedItemBuilder: (context) {
                            return Weekday.values.map((item) {
                              return Container(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  field.value?.map((e) => e.name).join(', ') ??
                                      '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 1,
                                ),
                              );
                            }).toList();
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.only(left: 16, right: 8),
                            height: 40,
                            // width: 140,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.zero,
                          ),
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
                                      final isSelected = selectedItems.contains(
                                        e,
                                      );
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
                                                  Icons.check_box_outline_blank,
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

                    ElevatedButton(
                      child: const Text("افزودن"),
                      onPressed: () {
                        if (formKey.currentState!.saveAndValidate()) {
                          final values = formKey.currentState!.value;
                          final post = GuardPost.fromMap(values);
                          context.read<MonthlyPostTableCubit>().addGuardPost(
                            post,
                          );
                          formKey.currentState!.reset();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
