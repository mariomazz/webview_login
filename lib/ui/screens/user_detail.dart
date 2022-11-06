import 'package:flutter/material.dart';
import '../../core/services/services.dart';
import '../widgets/future_widget.dart';

class UserDetailPage extends StatelessWidget {
  final String userId;
  const UserDetailPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final UsersService service = UsersService();
    return FutureWidget<UserDetail>(
      onLoading: (ctx) {
        return const Center(child: CircularProgressIndicator());
      },
      future: service.getById(userId),
      builder: (ctx, user) => Scaffold(
        appBar: AppBar(
          title: Text("${user.name} ${user.surname}"),
        ),
        body: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                user.userAvatar,
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 20),
              Text(user.userDescription),
              const SizedBox(height: 20),
              Text(user.age.toString()),
              const SizedBox(height: 20),
              Text(user.birthDate.toString()),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
