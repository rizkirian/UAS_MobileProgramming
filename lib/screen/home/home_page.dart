import 'package:cached_network_image/cached_network_image.dart';
import 'package:cek_ongkir/data/model/news_model.dart';
import 'package:cek_ongkir/screen/home/bloc/home_bloc.dart';
import 'package:cek_ongkir/screen/home/widgets/city_dropdown.dart';
import 'package:cek_ongkir/screen/home/widgets/weight_textfield.dart';
import 'package:cek_ongkir/screen/ongkir/ongkir_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

const List<String> courier = <String>[
  "jne",
  "pos",
  "tiki",
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _homeBloc = HomeBloc();
  final HomeBloc _homeBloc1 = HomeBloc();
  String? selectedOriginCity;
  String? selectedDestinationCity;
  final etWeightController = TextEditingController();
  String? selectedCourier;
  String? weight;

  @override
  void initState() {
    _homeBloc1.add(GetNewsList());
    _homeBloc.add(GetCityList());
    super.initState();
  }

  Widget _space() {
    return const SliverToBoxAdapter(
      child: SizedBox(
        height: 20,
      ),
    );
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

  Widget _cityOrigin() {
    return BlocProvider(
        create: (_) => _homeBloc,
        child: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is CityListError) {
              const SliverToBoxAdapter(
                child: Text("Error"),
              );
            }
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is CityListLoading) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is CityListLoaded) {
                return SliverToBoxAdapter(
                  child: CityDropdown(
                    cityList: state.cityModel.rajaongkir.results,
                    title: "Kota Asal",
                    hint: "Pilih Kota Asal",
                    onSelected: (value) {
                      debugPrint(value);
                      selectedOriginCity = value;
                    },
                  ),
                );
              } else {
                return const SliverToBoxAdapter(
                  child: Text("Error"),
                );
              }
            },
          ),
        ));
  }

  Widget _cityDestination() {
    return BlocProvider(
        create: (_) => _homeBloc,
        child: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is CityListError) {
              const SliverToBoxAdapter(
                child: Text("Error"),
              );
            }
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is CityListLoading) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is CityListLoaded) {
                return SliverToBoxAdapter(
                  child: CityDropdown(
                    cityList: state.cityModel.rajaongkir.results,
                    title: "Kota Tujuan",
                    hint: "Pilih Kota Tujuan",
                    onSelected: (value) {
                      debugPrint(value);
                      selectedDestinationCity = value;
                    },
                  ),
                );
              } else {
                return const SliverToBoxAdapter(
                  child: Text("Error"),
                );
              }
            },
          ),
        ));
  }

  Widget _weightTextfield() {
    return SliverToBoxAdapter(
      child: WeightTextfield(
        title: "Berat Barang",
        hint: "Masukkan Berat Barang",
        controller: etWeightController,
        textInputType: TextInputType.number,
        onChanged: (value) {
          weight = value;
        },
      ),
    );
  }

  Widget _courierDropdown() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Kurir"),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: selectedCourier,
            hint: const Text("Pilih Kurir"),
            items: courier.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCourier = value;
              });
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFE5E5E5),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFE5E5E5),
                ),
              ),
              hintText: "Pilih Kurir",
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _listNews() {
    return BlocProvider(
      create: (_) => _homeBloc1,
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          print("Listener $state");
          if (state is NewsListError) {
            const SliverToBoxAdapter(
              child: Text("Error"),
            );
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            print("Builder $state");
            if (state is NewsListLoading) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is NewsListLoaded) {
              return SliverToBoxAdapter(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.newsModel.articles!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () async {
                        openBrowser(state.newsModel.articles![index].url!);
                      },
                      child: CachedNetworkImage(
                        height: 200,
                        width: double.infinity,
                        imageUrl: state.newsModel.articles![index].urlToImage!,
                        imageBuilder: (context, imageProvider) => Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              scale: 2.0,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 40,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                              child: Text(
                                state.newsModel.articles![index].content!,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Transform.scale(
                          scale: 0.05,
                          child: const CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const SliverToBoxAdapter(
                child: Text("Error Data"),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _button() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(
          bottom: (MediaQuery.of(context).size.width / 100) * 4,
        ),
        child: ElevatedButton(
          // On press fetch cost
          onPressed: () {
            if (selectedOriginCity == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Kota Asal Harus Diisi"),
                ),
              );
            } else if (selectedDestinationCity == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Kota Tujuan Harus Diisi"),
                ),
              );
            } else if (weight == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Berat Barang Harus Diisi"),
                ),
              );
            } else if (selectedCourier == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Kurir Harus Diisi"),
                ),
              );
            } else {
              // Go to ongkir page with value
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OngkirPage(
                    origin: selectedOriginCity!,
                    destination: selectedDestinationCity!,
                    weight: weight!,
                    courier: selectedCourier!,
                  ),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF930000),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: (MediaQuery.of(context).size.width / 100) * 4,
            ),
            width: MediaQuery.of(context).size.width,
            child: const Text(
              "Cek Harga",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openBrowser(String url) async {
    if (await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
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
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  _cityOrigin(),
                  _space(),
                  _cityDestination(),
                  _space(),
                  _weightTextfield(),
                  _space(),
                  _courierDropdown(),
                  _space(),
                  // _listNews(),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 70,
                    ),
                  ),
                ],
              ),
              _button(),
            ],
          ),
        ),
      ),
    );
  }
}
