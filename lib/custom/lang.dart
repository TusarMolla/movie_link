import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LangText{
  BuildContext context;
  LangText(this.context);

  AppLocalizations getLang(){
    return AppLocalizations.of(context);
  }
}