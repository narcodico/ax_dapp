import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DropdownMenuMobile extends StatefulWidget {
  const DropdownMenuMobile();

  @override
  _DropdownMenuMobileState createState() => _DropdownMenuMobileState();
}

class _DropdownMenuMobileState extends State<DropdownMenuMobile> {
  String? dropdownValue = "";
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Need help?'),
          ),
          onTap: () {},
        ),
        PopupMenuItem(
          value: 2,
          child: ListTile(
            leading: FaIcon(
              FontAwesomeIcons.globeAmericas,
            ),
            title: Text('Website'),
          ),
          onTap: () => launch('https://www.athletex.io/'),
        ),
        PopupMenuItem(
          value: 3,
          child: ListTile(
            leading: Icon(Icons.description_outlined),
            title: Text('Litepaper'),
          ),
          onTap: () => launch(
              'https://athletex-markets.gitbook.io/athletex-huddle/start-here/litepaper'),
        ),
        PopupMenuItem(
          value: 4,
          child: ListTile(
            leading: FaIcon(
              FontAwesomeIcons.github,
            ),
            title: Text('GitHub'),
          ),
          onTap: () => launch('https://github.com/SportsToken'),
        ),
        PopupMenuItem(
          value: 5,
          child: ListTile(
            leading: FaIcon(
              FontAwesomeIcons.discord,
            ),
            title: Text('Discord'),
          ),
          onTap: () => launch('https://discord.com/invite/WFsyAuzp9V'),
        ),
        PopupMenuItem(
          value: 6,
          child: ListTile(
            leading: FaIcon(
              FontAwesomeIcons.twitter,
              // size: 25,
            ),
            title: Text('Twitter'),
          ),
          onTap: () => launch('https://twitter.com/athletex_dao?s=20'),
        ),
        PopupMenuItem(
          value: 7,
          child: ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
          ),
          onTap: () => {},
        ),
      ],
      icon: Icon(Icons.more_horiz),
      offset: Offset(0, 45),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }
}