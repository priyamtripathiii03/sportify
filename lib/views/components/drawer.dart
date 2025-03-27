import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import 'about_screen.dart';
import 'favourite_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: black1,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/img/header.jpg'),
                  ),
                ),
                child: Container(),
              ),
            ),
            _createDrawerItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _createDrawerItem(
              icon: Icons.music_note,
              text: 'My Music',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FavouriteScreen(),
                  ),
                );
              },
            ),
            _createDrawerItem(
              icon: Icons.download,
              text: 'Downloads',
              onTap: () {},
            ),
            _createDrawerItem(
              icon: Icons.playlist_play,
              text: 'Playlists',
              onTap: () {},
            ),
            _createDrawerItem(
              icon: Icons.settings,
              text: 'Settings',
              onTap: () {},
            ),
            _createDrawerItem(
              icon: Icons.info_outline,
              text: 'About',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutScreen(),
                  ),
                );
              },
            ),
            const Spacer(),
            const Text(
              'Made by Priyam Tripathi',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  ListTile _createDrawerItem({
    required IconData icon,
    required String text,
    void Function()? onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      onTap: onTap,
    );
  }
}