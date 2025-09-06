import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paseban/domain/enums.dart';
import 'package:paseban/domain/models/models.dart';

import '../../domain/models/post_policies.dart';
import '../cubit/monthly_post_table_cubit.dart';

class PolicyTile extends StatelessWidget {
  const PolicyTile({super.key, required this.policy, this.onEdit});

  final PostPolicy policy;
  final ValueChanged<PostPolicy>? onEdit;

  @override
  Widget build(BuildContext context) {
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
              onEdit?.call(policy);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<MonthlyPostTableCubit>().removePolicy(policy);
            },
          ),
        ],
      ),
    );
  }
}
