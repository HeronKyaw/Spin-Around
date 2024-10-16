import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spin_around/modules/home/bloc/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:spin_around/modules/spinner_wheel/bloc/spinner_wheel_list_cubit/spinner_wheel_list_cubit.dart';
import 'package:spin_around/modules/spinner_wheel/views/spinner_wheel_list_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static final String tag = 'home';

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (context, index) {
        return BlocBuilder<BottomNavCubit, BottomNavState>(
          builder: (context, state) {
            // Based on selected tab, return appropriate content
            if (state is HomeTab) {
              return BlocProvider(
                create: (context) => SpinnerWheelListCubit()..fetchData(),
                child: SpinnerWheelListScreen(),
              );
            } else if (state is SearchTab) {
              return const Center(child: Text('Search Page'));
            } else if (state is ProfileTab) {
              return const Center(child: Text('Profile Page'));
            }
            return const SizedBox.shrink();
          },
        );
      },
      tabBar: CupertinoTabBar(
        onTap: (index) {
          context.read<BottomNavCubit>().selectTab(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
