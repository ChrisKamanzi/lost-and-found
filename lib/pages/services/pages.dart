import 'package:flutter/material.dart';

import '../../generated/app_localizations.dart';

List<Map<String, dynamic>> getLocalizedPages(BuildContext context) {
  return [
    {
      'title': AppLocalizations.of(context)!.reportFoundTitle,
      'description': AppLocalizations.of(context)!.reportFoundDescription,
      'icon': Icons.report,
    },
    {
      'title': AppLocalizations.of(context)!.searchMapTitle,
      'description': AppLocalizations.of(context)!.searchMapDescription,
      'icon': Icons.map,
    },
    {
      'title': AppLocalizations.of(context)!.messagingTitle,
      'description': AppLocalizations.of(context)!.messagingDescription,
      'icon': Icons.message,
    },
  ];
}


