import 'dart:math';

import 'package:crypto_currency/core/core.dart';
import 'package:crypto_currency/home_page/bloc/home_page_bloc.dart';
import 'package:crypto_currency/home_page/view/widgets/currency_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_client/rest_client.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderScope(
      child: BlocProvider(
        create: (ctx) {
          return HomePageBloc(
            restClient: ctx.read<RestClient>(),
          );
        },
        child: _HomePage(),
      ),
    );
  }
}

class _HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<_HomePage> {
  late final HomePageBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<HomePageBloc>();
    _bloc.add(LoadAllRatesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomePageBloc, HomePageState>(
      bloc: _bloc,
      listenWhen: (prevState, currentState) =>
          prevState.loading != currentState.loading,
      listener: (_, state) {
        LoaderScope.of(context).changeLoaderVisibility(state.loading);
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomePageBloc, HomePageState>(
            bloc: _bloc,
            builder: (_, state) {
              return NotificationListener<ScrollNotification>(
                onNotification: _handleScrollNotification,
                child: ListView.builder(
                    itemCount: state.rates.length,
                    itemBuilder: (_, itemIndex) {
                      return RateListItem(
                        color: Color(Random().nextInt(16777216)).withOpacity(1),
                        rateModel: state.rates[itemIndex],
                      );
                    }),
              );
            },
          ),
        ),
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.metrics.atEdge) {
      if (notification.metrics.pixels != 0) {
        print('At bottom');
        _bloc.add(LoadNextPageEvent());
      }
    }
    return true;
    // if (notification.depth == 0) {
    //   if (notification is UserScrollNotification) {
    //     switch (notification.direction) {
    //       case ScrollDirection.forward:
    //         break;
    //       case ScrollDirection.reverse:
    //       case ScrollDirection.idle:
    //         break;
    //     }
    //   }
    // }
    // return false;
  }
}
