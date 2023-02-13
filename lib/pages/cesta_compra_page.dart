import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/producto.dart';

class CestaCompraPage extends StatefulWidget {
  const CestaCompraPage({super.key});

  @override
  State<CestaCompraPage> createState() => _CestaCompraPageState();
}

class _CestaCompraPageState extends State<CestaCompraPage> {
  List<Producto> listaProductos = [];
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('cesta_compra')
        .snapshots()
        .listen((productos) {
      mapProducto(productos);
    });
    fetchProductos();
  }

  // Obtenemos los datos de Firebase Firestorage
  void fetchProductos() async {
    var lista_compra =
        await FirebaseFirestore.instance.collection("cesta_compra").get();
    mapProducto(lista_compra);
  }

  void mapProducto(QuerySnapshot<Map<String, dynamic>> lista_compra) {
    var _list = lista_compra.docs
        .map((producto) => Producto(
              id: producto.id,
              descripcion: producto["descripcion"],
              cantidad: producto["cantidad"] ?? "",
            ))
        .toList();
    setState(() {
      listaProductos = _list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cesta Compra'),
        elevation: 0,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: ListView.builder(
          itemCount: listaProductos.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(listaProductos[index].descripcion),
              subtitle: Text(listaProductos[index].cantidad ?? ''),
            );
          }),
    );
  }
}
