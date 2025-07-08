import 'package:flutter/material.dart';

class CustomSettingsListTile extends StatefulWidget {
  const CustomSettingsListTile({super.key, required this.tileTitle, required this.tileIcon, required this.iconBg, });

  final String tileTitle;
  final IconData tileIcon;
  final Color iconBg;

  @override
  State<CustomSettingsListTile> createState() => _CustomSettingsListTileState();
}

class _CustomSettingsListTileState extends State<CustomSettingsListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: widget.iconBg,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.all(8),
        child: Icon(widget.tileIcon, color: Colors.white),
      ),
      title: Text(widget.tileTitle),
      onTap: () {},
    );
  }
}
