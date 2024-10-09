import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spin_around/modules/home/bloc/bottom_nav_cubit/bottom_nav_cubit.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static final String tag = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Navigation with Cubit'),
      ),
      body: BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (context, state) {
          if (state is HomeTab) {
            return const Center(child: Text('Home Page'));
          } else if (state is SearchTab) {
            return const Center(child: Text('Search Page'));
          } else if (state is ProfileTab) {
            return const Center(child: Text('Profile Page'));
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (context, state) {
          int currentIndex = 0;
          if (state is SearchTab) {
            currentIndex = 1;
          } else if (state is ProfileTab) {
            currentIndex = 2;
          }

          return BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              context.read<BottomNavCubit>().selectTab(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}
