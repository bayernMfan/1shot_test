import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_test/features/order/data/repositroy/order_repository_impl.dart';
import 'package:test_test/features/order/presentation/bloc/order_bloc.dart';
import 'package:test_test/features/order/presentation/pages/merch_grid_tile.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          title: Text('Меню'),
          floating: true,
          flexibleSpace: Container(),
          expandedHeight: 60,
          actions: [
            Ink(
              decoration: const ShapeDecoration(
                color: Colors.blue,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: const Icon(Icons.add),
                color: Colors.white,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () =>
                    BlocProvider.of<OrderBloc>(context).add(OrderAddMerch()),
              ),
            ),
          ],
        ),
        BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderRandomMerchesGenerating)
              return SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            if (state is OrderRandomMerchesGenerated ||
                state is OrderRandomMerchesUpdated) {
              return SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return MerchGridTile(
                        merch: (state is OrderRandomMerchesGenerated)
                            ? state.merchs[index]
                            : (state as OrderRandomMerchesUpdated)
                                .merchs[index],
                        onDelete: () => BlocProvider.of<OrderBloc>(context)
                            .add(OrderDeleteMerch(index)));
                  },
                  childCount:
                      RepositoryProvider.of<OrderRepositoryImpl>(context)
                          .randomMerchandises
                          .length,
                ),
              );
            }

            return SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ]),
    );
  }
}
