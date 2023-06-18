import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syscraft_task/app_locale/lang_key.dart';
import 'package:syscraft_task/model/artist_model.dart';
import 'package:syscraft_task/repository/response/api_resp.dart';
import 'package:syscraft_task/src/extensions/space_extension.dart';
import 'package:syscraft_task/src/extensions/text_style_extension.dart';
import 'package:syscraft_task/src/ui/home/cubit/home_cubit.dart';
import 'package:syscraft_task/src/widgets/app_scaffold.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..init(context),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            return DefaultTabController(
              length: 2,
              child: AppScaffold(
                noneClickable: state.isBusy,
                appBar: AppBar(
                  title: Text(
                    LangKey.home,
                    style: const TextStyle().bold.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () => _showLogoutDialog(context),
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                    ),
                  ],
                  bottom: TabBar(
                    tabs: const [
                      Tab(text: LangKey.artists),
                      Tab(text: LangKey.users),
                    ],
                    labelStyle: const TextStyle().bold.copyWith(
                          color: Colors.white,
                        ),
                    unselectedLabelStyle: const TextStyle().regular.copyWith(
                          color: Colors.white,
                        ),
                    onTap: (index) =>
                        context.read<HomeCubit>().onTabChange(index),
                  ),
                ),
                body: state.selectTab == 0
                    ? state.artistList?.isNotEmpty ?? false
                        ? ListView.separated(
                            itemBuilder: (_, index) {
                              final item = state.artistList![index];
                              return _artistItem(item, context);
                            },
                            separatorBuilder: (_, index) =>
                                const Divider(height: 8),
                            itemCount: state.artistList?.length ?? 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            shrinkWrap: true,
                          )
                        : Center(
                            child: Text(
                              LangKey.noRecordFound,
                              style: const TextStyle().regular.copyWith(
                                    color: Colors.black38,
                                  ),
                            ),
                          )
                    : state.userList?.isNotEmpty ?? false
                        ? ListView.separated(
                            itemBuilder: (_, index) {
                              final item = state.userList![index];
                              return _userItem(item, context);
                            },
                            separatorBuilder: (_, index) =>
                                const Divider(height: 16),
                            itemCount: state.userList?.length ?? 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            shrinkWrap: true,
                          )
                        : Center(
                            child: Text(
                              LangKey.noRecordFound,
                              style: const TextStyle().regular.copyWith(
                                    color: Colors.black38,
                                  ),
                            ),
                          ),
                floatingAction: FloatingActionButton(
                  onPressed: () => context.read<HomeCubit>().goToArtist(),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            LangKey.logout,
            style: const TextStyle().bold,
          ),
          content: Text(
            LangKey.logoutText,
            style: const TextStyle().regular,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.zero,
              ),
              child: Text(
                LangKey.no.toUpperCase(),
                style: const TextStyle().bold,
              ),
            ),
            TextButton(
              onPressed: () => context.read<HomeCubit>().logout(),
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.zero,
              ),
              child: Text(
                LangKey.yes.toUpperCase(),
                style: const TextStyle().bold,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _artistItem(ArtistModel item, BuildContext context) {
    return ListTile(
      title: Text(
        item.name ?? 'N/A',
        style: const TextStyle().bold.copyWith(
              fontSize: 16,
            ),
      ),
      subtitle: Text(
        item.dob ?? 'N/A',
        style: const TextStyle().regular,
      ),
      dense: true,
      contentPadding: EdgeInsets.zero,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _actionButton(
            onTap: () => context.read<HomeCubit>().deleteArtist(item),
            icon: Icons.delete,
          ),
          6.toSpace,
          _actionButton(
            onTap: () => context.read<HomeCubit>().editArtist(item),
            icon: Icons.edit,
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
          padding: const EdgeInsets.all(5),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: const Size(30, 30)),
      child: Icon(
        icon,
        color: Colors.black,
      ),
    );
  }

  Widget _userItem(User item, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       _rowItem("Name", item.firstName ?? ''),
        5.toSpace,
        _rowItem("Company", item.company?.name ?? ''),
        5.toSpace,
        _rowItem("City", item.address?.city ?? ''),
        5.toSpace,
        _rowItem("Address", item.address?.address ?? ''),
      ],
    );
  }

  Widget _rowItem(String label,String value){
    return Row(
      children: [
        Expanded(
          flex: 30,
          child: Text(
           label,
            style: const TextStyle().bold.copyWith(
              fontSize: 16,
            ),
          ),
        ),
        3.toSpace,
        Expanded(
          flex: 10,
          child: Text(
            ":",
            style: const TextStyle().bold.copyWith(
              fontSize: 16,
            ),
          ),
        ),
        3.toSpace,
        Expanded(
          flex: 60,
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle().regular.copyWith(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
