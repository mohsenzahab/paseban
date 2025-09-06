import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:paseban/core/constant/space.dart';

import '../../../domain/enums.dart';

class ConscriptionStageField<T> extends StatefulWidget {
  const ConscriptionStageField({
    super.key,
    this.stage,
    this.value,
    required this.onValueCreated,
    required this.onStageDeleted,
    required this.onValueEdited,
    required this.availableStages,
  });

  final List<ConscriptionStage> availableStages;
  final void Function(ConscriptionStage stage) onStageDeleted;
  final ConscriptionStage? stage;
  final T? value;

  @override
  State<ConscriptionStageField<T>> createState() =>
      _ConscriptionStageFieldState<T>();

  final ValueChanged<(ConscriptionStage, T)> onValueCreated;

  final ValueChanged<(ConscriptionStage, T)> onValueEdited;
}

class _ConscriptionStageFieldState<T> extends State<ConscriptionStageField<T>> {
  ConscriptionStage? stage;
  late final TextEditingController? textController;
  T? value;

  @override
  didUpdateWidget(ConscriptionStageField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    stage = widget.stage;
    value = widget.value;
    // if (T == int) {
    // textController!.text = '';
    // }
  }

  @override
  void initState() {
    super.initState();
    stage = widget.stage;
    value = widget.value;
    if (T == int) {
      textController = TextEditingController(text: value?.toString());
    }
  }

  bool get isAdd => widget.stage == null && widget.value == null;

  @override
  Widget build(BuildContext context) {
    Widget valueField;
    if (T == int) {
      valueField = TextFormField(
        controller: textController,
        decoration: const InputDecoration(labelText: 'مقدار'),
        textAlign: TextAlign.center,
        validator: FormBuilderValidators.integer(),
        autovalidateMode: AutovalidateMode.onUserInteraction,

        onChanged: (value) {
          setState(() {
            this.value = int.tryParse(value) as T;
          });
        },
      );
    } else if (T == GuardPostDifficulty) {
      valueField = InputDecorator(
        decoration: InputDecoration(isCollapsed: true, labelText: 'سطح دشواری'),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            value: value,
            items: GuardPostDifficulty.values
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: FittedBox(child: Text(e.nameFa)),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                this.value = value as T;
              });
            },
          ),
        ),
      );
    } else {
      valueField = SizedBox();
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 2,
          child: InputDecorator(
            decoration: InputDecoration(
              isDense: false,
              isCollapsed: true,
              labelText: 'مدت خدمتی',
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                value: stage,
                items: widget.availableStages.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: FittedBox(child: Text(e.faName)),
                  );
                }).toList(),
                selectedItemBuilder: (context) => widget.availableStages
                    .map((e) => Center(child: FittedBox(child: Text(e.faName))))
                    .toList(),
                onChanged: (ConscriptionStage? value) {
                  stage = value;
                  setState(() {});
                },
              ),
            ),
          ),
        ),
        kSpaceH12,
        Flexible(child: valueField),
        kSpaceH12,
        if (isAdd)
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              if (stage != null && value != null) {
                widget.onValueCreated.call((stage!, value!));
              }
            },
          )
        else ...[
          IconButton(
            icon: const Icon(Icons.delete_rounded, color: Colors.red),
            onPressed: () {
              widget.onStageDeleted(stage!);
            },
          ),
          if (value != widget.value || stage != widget.stage)
            IconButton(
              icon: const Icon(Icons.done_rounded, color: Colors.green),
              onPressed: () {
                if (stage != null && value != null) {
                  widget.onValueEdited.call((stage!, value!));
                }
              },
            ),
        ],
      ],
    );
  }
}
