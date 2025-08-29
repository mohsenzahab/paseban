import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class BaseForm extends StatefulWidget {
  const BaseForm({
    super.key,
    required this.builder,
    required this.title,
    this.onSubmit,
    this.initialValue,
  });
  final Widget Function(
    BuildContext context,
    GlobalKey<FormBuilderState> formKey,
  )
  builder;
  final String title;
  final ValueChanged<Map<String, dynamic>>? onSubmit;
  final Map<String, dynamic>? initialValue;

  @override
  State<BaseForm> createState() => _BaseFormState();
}

class _BaseFormState extends State<BaseForm> {
  final formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(widget.title),
          ),
          const Divider(),
          SingleChildScrollView(
            child: FormBuilder(
              key: formKey,
              initialValue: widget.initialValue ?? {},
              child: widget.builder(context, formKey),
            ),
          ),
          const Divider(),
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 12.0,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("لغو"),
              ),
              FilledButton(
                onPressed: () {
                  _handleSubmit();
                },
                child: const Text("ذخیره"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleSubmit() {
    if (formKey.currentState!.saveAndValidate()) {
      final data = formKey.currentState!.value;
      widget.onSubmit?.call(data);

      formKey.currentState!.reset(); // clears after submit
    }
  }
}
