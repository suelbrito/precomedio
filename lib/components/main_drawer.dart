import 'package:flutter/material.dart';
import 'package:precomedio/utils/app_routes.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget _createItem(IconData icon, String label, Function() onTap) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 80,
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            color: Theme.of(context).colorScheme.secondary,
            alignment: Alignment.bottomLeft,
            child: const Text(
              'Opções',
              style: TextStyle(
                  fontWeight: FontWeight.w900, fontSize: 20, color: Colors.white
                  //color: Theme.of(context).colorScheme.primary
                  ),
            ),
          ),
          _createItem(Icons.home, 'Início',
              () => Navigator.of(context).pushReplacementNamed(AppRoutes.HOME)),
          _createItem(
              Icons.local_offer,
              'Tickets',
              () =>
                  Navigator.of(context).pushReplacementNamed(AppRoutes.TICKET))
        ],
      ),
    );
  }
}
