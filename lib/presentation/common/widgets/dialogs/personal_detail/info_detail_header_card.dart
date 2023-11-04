import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/config.dart'
    show AppTheme, BlockCubit, BlockState, BlockedUsersLoading, Strings;
import '../../../../../domain/domain.dart' show UserEntity;
import '../../widgets.dart';
import 'block_user_sheet.dart';
import 'report_user_sheet.dart';

class InfoDetailHeaderCard extends StatelessWidget {
  const InfoDetailHeaderCard({
    super.key,
    required this.user,
    required this.tabControllerReport,
    required this.tabsReport,
  });

  final UserEntity? user;
  final TabController tabControllerReport;
  final List<Widget> tabsReport;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 25, left: 15, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 32,
                    )),
                Text(
                  user?.name ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isDismissible: false,
                      enableDrag: false,
                      useSafeArea: true,
                      isScrollControlled: false,
                      builder: (BuildContext context) {
                        return Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: SafeArea(
                            bottom: false,
                            child: DraggableScrollableSheet(
                              initialChildSize: 1.0,
                              maxChildSize: 1.0,
                              builder: (BuildContext context,
                                  ScrollController scrollController) {
                                return SizedBox(
                                  height: size.height * 0.80,
                                  width: size.width * 0.95,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 20.0),
                                      SizedBox(
                                        height: size.height * 0.05,
                                        width: size.width,
                                        child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 15,
                                          ),
                                          leading: const CircleAvatarProfile(
                                            image: 'assets/imgs/girl1.png',
                                          ),
                                          title: Text(
                                            '${user?.name} (31)',
                                            style: const TextStyle(
                                              color: Color(0xFF261638),
                                              fontSize: 20,
                                              fontFamily: Strings.fontFamily,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          trailing: BlocBuilder<BlockCubit,
                                              BlockState>(
                                            builder: (context, state) {
                                              return IconButton(
                                                onPressed: (state
                                                        is BlockedUsersLoading)
                                                    ? null
                                                    : () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                icon: const Icon(
                                                  Icons.cancel_outlined,
                                                  color: AppTheme.disabledColor,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 25.0),
                                      BlocBuilder<BlockCubit, BlockState>(
                                        builder: (context, state) {
                                          return TabBar(
                                            controller: tabControllerReport,
                                            tabs: tabsReport,
                                            onTap: (index) {
                                              if ((index == 0) &&
                                                  (state ==
                                                      BlockedUsersLoading())) {
                                                tabControllerReport.index = 1;
                                              }
                                            },
                                          );
                                        },
                                      ),
                                      Expanded(
                                        child: TabBarView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          controller: tabControllerReport,
                                          children: [
                                            ReportUserSheet(size: size),
                                            BlockUserSheet(user: user)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              controller: DraggableScrollableController(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.no_accounts_outlined,
                    color: Colors.white,
                    size: 32,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 25,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6000000238418579),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '95% match',
                  style: TextStyle(
                    color: Color.fromARGB(255, 231, 77, 16),
                    fontSize: 12,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
