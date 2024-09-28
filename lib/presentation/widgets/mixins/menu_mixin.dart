import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';

mixin MenuMixin {
  List<String> getMenuItems(BuildContext context) => [
        L10n.of(context).tr.lblHomePage,
        L10n.of(context).tr.lblTeachers,
        L10n.of(context).tr.lblDonors,
        L10n.of(context).tr.lblAbout,
        L10n.of(context).tr.lblContact,
        L10n.of(context).tr.lblBlog,
      ];
}
