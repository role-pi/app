import 'package:flutter/cupertino.dart';
import 'package:role/controllers/eventos_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:role/models/evento.dart';
import 'package:role/views/evento_item_row.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EventosListViewModel usersViewModel = context.watch<EventosListViewModel>();

    return WillPopScope(
      onWillPop: () async => false,
      child: CupertinoPageScaffold(
        child: Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      delegate:
                          _LogoHeaderDelegate(), // Replace with your logo header delegate
                      pinned: true,
                    ),
                    SliverList.separated(
                      separatorBuilder: (context, index) => SizedBox(height: 8),
                      itemCount: usersViewModel.eventos.length,
                      itemBuilder: (context, index) {
                        Evento evento = usersViewModel.eventos[index];
                        return EventoItemRow(
                          evento: evento,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoButton(
                  onPressed: () async {
                    usersViewModel.get();
                  },
                  child: const Text('Atualizar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 0; // Hide the header when collapsed

  @override
  double get maxExtent => 100; // Adjust the max height of the header

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // Replace this with your app logo widget
    return Container(
      // Set the background color of the header
      child: Align(
        alignment: Alignment.centerLeft,
        child: Image.asset(
          'assets/Logo.png',
          height: 50,
        ), // Replace this with your app logo widget
      ),
    );
  }

  @override
  bool shouldRebuild(_LogoHeaderDelegate oldDelegate) {
    return false;
  }
}
