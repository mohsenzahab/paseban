import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paseban/presentation/cubit/monthly_post_table_cubit.dart';
import 'package:paseban/presentation/forms/policy_form.dart';

class PoliciesScreen extends StatefulWidget {
  const PoliciesScreen({super.key});

  @override
  State<PoliciesScreen> createState() => _PoliciesScreenState();
}

class _PoliciesScreenState extends State<PoliciesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سیاست های عمومی')),
      body: Container(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: BlocBuilder<MonthlyPostTableCubit, MonthlyPostTableState>(
                builder: (context, state) {
                  final policies = state.publicPolicies;
                  return ListView.builder(
                    itemCount: policies.length,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text(policies[index].title));
                    },
                  );
                },
              ),
            ),
            PolicyForm(),
          ],
        ),
      ),
    );
  }
}
