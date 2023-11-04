import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/config.dart'
    show
        BlockCubit,
        BlockState,
        BlockedUsersData,
        BlockedUsersError,
        BlockedUsersInitial,
        BlockedUsersLoading,
        Strings;
import 'widgets/unbloqued_profile_sheet.dart';

class BloquedListScreen extends StatefulWidget {
  const BloquedListScreen({super.key});

  static const String routeName = '/bloqued_list_screen';

  @override
  State<BloquedListScreen> createState() => _BloquedListScreenState();
}

class _BloquedListScreenState extends State<BloquedListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BlockCubit>().getUsersBloqued();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Blocked',
          style: TextStyle(
            color: Color(0xFF261638),
            fontSize: 20,
            fontFamily: Strings.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<BlockCubit, BlockState>(
        builder: (context, state) {
          return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: SafeArea(
                bottom: false,
                child: switch (state) {
                  BlockedUsersInitial() => Container(),
                  BlockedUsersLoading() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  BlockedUsersData() => state.users.isNotEmpty
                      ? ListView.builder(
                          itemCount: state.users.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                UnbloquedProfileSheet(
                                  user: state.users[index],
                                ),
                                const Divider(),
                              ],
                            );
                          },
                        )
                      : const Center(
                          child: Text('There are no blocked users'),
                        ),
                  BlockedUsersError() => Container(),
                }),
          );
        },
      ),
    );
  }
}
