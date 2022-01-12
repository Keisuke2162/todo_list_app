import 'package:check_list_app/parent_task_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:check_list_app/auth_service.dart';

class SignProcess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, AuthService authService, _) {

        // ログイン状況確認
        switch (authService.status) {
          case Status.uninitialized:
            return Center(child: CircularProgressIndicator());

          case Status.unauthenticated:

          case Status.authenticating:
            authService.signInAnonymously();
            return Center(child: CircularProgressIndicator());

          case Status.authenticated:
            break;
        }
        return ParentDbProcess();
      },
    );
  }
}