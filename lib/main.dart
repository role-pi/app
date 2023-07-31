import 'package:flutter/cupertino.dart';
import 'package:role/controllers/usuarios_view_model.dart';
import 'package:provider/provider.dart';
import 'package:role/models/usuario.dart';
import 'package:role/views/usuario_row.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsuariosViewModel()),
      ],
      child: CupertinoApp(
        title: 'MVVM',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UsuariosViewModel usersViewModel = context.watch<UsuariosViewModel>();

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Rolê'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: usersViewModel.usuarios.length,
                itemBuilder: (context, index) {
                  Usuario user = usersViewModel.usuarios[index];
                  return UsuarioRow(usuario: user);
                },
              ),
            ),
            CupertinoButton(
              onPressed: () async {
                usersViewModel.getUsers();
              },
              child: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}
