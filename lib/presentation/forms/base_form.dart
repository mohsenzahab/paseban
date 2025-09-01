import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

enum ClearButtonBehavior { pop, clear }

class BaseForm extends StatefulWidget {
  const BaseForm({
    super.key,
    required this.builder,
    required this.title,
    this.onSubmit,
    this.initialValue,
    this.onChanged,
    this.addButtonLabel,
    this.clearButtonLabel,
    this.clearButtonBehavior = ClearButtonBehavior.pop,
    this.onClear,
  });
  final Widget Function(
    BuildContext context,
    GlobalKey<FormBuilderState> formKey,
  )
  builder;
  final String title;
  final String? addButtonLabel;
  final String? clearButtonLabel;
  final ClearButtonBehavior clearButtonBehavior;
  final ValueChanged<Map<String, dynamic>>? onSubmit;
  final Map<String, dynamic>? initialValue;
  final VoidCallback? onChanged;
  final VoidCallback? onClear;

  @override
  State<BaseForm> createState() => _BaseFormState();
}

class _BaseFormState extends State<BaseForm> {
  final formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
      ),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * 0.8,
        minWidth: 400,
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8.0,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(widget.title, style: TextStyle(fontSize: 20)),
          ),
          const Divider(thickness: 2),
          FormBuilder(
            key: formKey,
            onChanged: widget.onChanged,
            initialValue: widget.initialValue ?? {},
            child: widget.builder(context, formKey),
          ),
          const Divider(thickness: 2),
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 12.0,
            children: [
              TextButton(
                onPressed: () {
                  switch (widget.clearButtonBehavior) {
                    case ClearButtonBehavior.pop:
                      Navigator.pop(context);
                      break;
                    case ClearButtonBehavior.clear:
                      formKey.currentState!.reset();
                  }
                  widget.onClear?.call();
                },
                child: Text(widget.clearButtonLabel ?? "لغو"),
              ),
              FilledButton(
                onPressed: () {
                  _handleSubmit();
                },
                child: Text(widget.addButtonLabel ?? "ذخیره"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleSubmit() {
    if (formKey.currentState!.saveAndValidate()) {
      final data = Map<String, dynamic>.from(formKey.currentState!.value);
      formKey.currentState!.reset(); // clears after submit
      widget.onSubmit?.call(data);
    }
  }
}
