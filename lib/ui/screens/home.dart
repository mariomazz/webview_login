import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_login/core/routing/configurations/utils.dart';
import '../../core/autentication/auth_provider.dart';
import '../../core/routing/configurations/routes.dart';
import '../../core/services/services.dart';
import '../widgets/future_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final UsersService _service = UsersService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () async {
              await Provider.of<AuthProvider>(context, listen: false)
                  .authStatusChange();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: SizedBox.expand(
        child: FutureWidget<List<User>>(
          future: _service.getAll(),
          onLoading: (ctx) {
            return const Center(child: CircularProgressIndicator());
          },
          builder: (ctx, data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final el = data.elementAt(index);
                return ListTile(
                  onTap: () {
                    context.secureGo("${Routes.home}/${el.id}");
                  },
                  title: Text(el.name),
                  subtitle: Text(el.surname),
                  leading: Text('Età : ${el.age}'),
                  trailing: Text(el.birthDate.toLocal().toString()),
                );
              },
            );
          },
          onError: (ctx, err) {
            return const Text("Errore");
          },
        ),
      ),
    );
  }
}
