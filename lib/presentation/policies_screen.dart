import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paseban/domain/models/models.dart';
import 'package:paseban/presentation/cubit/monthly_post_table_cubit.dart';
import 'package:paseban/presentation/forms/policy_form.dart';

class PoliciesScreen extends StatefulWidget {
  const PoliciesScreen({super.key});

  @override
  State<PoliciesScreen> createState() => _PoliciesScreenState();
}

class _PoliciesScreenState extends State<PoliciesScreen> {
  PostPolicy? editingPolicy;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سیاست های عمومی')),
      body: Container(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: BlocBuilder<MonthlyPostTableCubit, MonthlyPostTableState>(
                builder: (context, state) {
                  final policies = state.publicPolicies;
                  return ListView.builder(
                    itemCount: policies.length,
                    itemBuilder: (context, index) {
                      final policy = policies[index];
                      final value = switch (policy) {
                        ValuePostPolicy p => p.value.toString(),

                        EqualHolidayPost() || EqualPostDifficulty() => null,
                      };
                      return ListTile(
                        title: Text(policy.title),
                        leading: Text(policy.priority.nameFa),
                        subtitle: value != null ? Text(value) : null,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                editingPolicy = policy;
                                setState(() {});
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                context
                                    .read<MonthlyPostTableCubit>()
                                    .removePolicy(policy);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            PolicyForm(
              policy: editingPolicy,
              onCleared: () {
                setState(() {
                  editingPolicy = null;
                });
              },
              onSubmit: (value) {
                if (editingPolicy != null) {
                  context.read<MonthlyPostTableCubit>().editPolicy(
                    value,
                    editingPolicy!.id!,
                  );
                } else {
                  context.read<MonthlyPostTableCubit>().addPolicy(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
