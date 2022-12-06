import 'package:cek_ongkir/screen/ongkir/bloc/ongkir_bloc.dart';
import 'package:cek_ongkir/screen/ongkir/widgets/item_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OngkirPage extends StatefulWidget {
  final String origin;
  final String destination;
  final String weight;
  final String courier;

  const OngkirPage({
    super.key,
    required this.origin,
    required this.destination,
    required this.weight,
    required this.courier,
  });

  @override
  State<OngkirPage> createState() => _OngkirPageState();
}

class _OngkirPageState extends State<OngkirPage> {
  final OngkirBloc _ongkirBloc = OngkirBloc();

  @override
  void initState() {
    _ongkirBloc.add(
      GetCost(
        origin: widget.origin,
        destination: widget.destination,
        weight: widget.weight,
        courier: widget.courier,
      ),
    );
    super.initState();
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text("Cek Ongkir"),
      backgroundColor: const Color(0xFF930000),
      elevation: 0,
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (MediaQuery.of(context).size.width / 100) * 4,
          ),
        )
      ],
    );
  }

  Widget _listCost() {
    return SliverToBoxAdapter(
      child: BlocProvider(
        create: (_) => _ongkirBloc,
        child: BlocListener<OngkirBloc, OngkirState>(
          listener: (context, state) {
            if (state is OngkirError) {
              const SliverToBoxAdapter(
                child: Text("Error"),
              );
            }
          },
          child: BlocBuilder<OngkirBloc, OngkirState>(
            builder: (context, state) {
              if (state is OngkirInitial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is OngkirLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is OngkirLoaded) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.costModel.rajaongkir.results[0].costs.length,
                  itemBuilder: (context, index) {
                    return ItemList(
                      costModel: state.costModel.rajaongkir.results[0].costs[index],
                    );
                  },
                );
              } else if (state is OngkirError) {
                return const Center(
                  child: Text("Error"),
                );
              } else {
                return const Center(
                  child: Text("Error"),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.only(
          top: 8,
        ),
        color: const Color(0xFF930000),
        child: Container(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            color: Colors.white,
          ),
          child: CustomScrollView(
            slivers: [
              _listCost(),
            ],
          ),
        ),
      ),
    );
  }
}
