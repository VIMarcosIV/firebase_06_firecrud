import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/producto.dart';

const COLLECTION_NAME = 'cesta_compra';

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
        actions: [
          IconButton(
              onPressed: () {
                showItemDialog();
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
          itemCount: listaProductos.length,
          itemBuilder: (context, index) {
            return Slidable(
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      eliminarProducto(listaProductos[index].id);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text("Se ha eliminado el producto correctamente"),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.blueAccent,
                      ));
                    },
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                    // Ponemos una snackbar para avisar de que se a eliminado un producto
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      actualizarProducto(
                          listaProductos[index].id,
                          listaProductos[index].descripcion,
                          listaProductos[index].cantidad);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text("Se ha actualizado el producto correctamente"),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.blueAccent,
                      ));
                    },
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.white,
                    icon: Icons.update,
                    label: 'Update',
                  ),
                ],
              ),
              child: ListTile(
                title: Text(listaProductos[index].descripcion),
                subtitle: Text(listaProductos[index].cantidad ?? ''),
              ),
            );
          }),
    );
  }

  void showItemDialog() {
    var nameController = TextEditingController();
    var quantityController = TextEditingController();

    //1- Llamamos a showDialog para abrir una ventana emergente
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Añadir producto",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                      decoration: InputDecoration(
                          labelText: "Descripción del producto"),
                      controller: nameController),
                  TextField(
                    decoration: InputDecoration(labelText: "Cantidad"),
                    controller: quantityController,
                  ),
                  TextButton(
                    onPressed: () {
                      var descripcion = nameController.text.trim();
                      var cantidad = quantityController.text.trim();
                      addProducto(descripcion, cantidad);
                    },
                    child: Text("Añadir"),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void addProducto(String desc, String cant) {
    Producto p = Producto(id: "id", descripcion: desc, cantidad: cant);
    FirebaseFirestore.instance.collection(COLLECTION_NAME).add(p.toJson());
  }

  void eliminarProducto(String id) {
    FirebaseFirestore.instance.collection(COLLECTION_NAME).doc(id).delete();
  }

  void actualizarProducto(String id, String desc, String? cant) {
    var nameController = TextEditingController();
    var quantityController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Modificar producto",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                      decoration: InputDecoration(
                          labelText: "Valor anterior (Descripción): " + desc),
                      controller: nameController),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Valor anterior (Cantidad): " + cant!),
                    controller: quantityController,
                  ),
                  TextButton(
                    onPressed: () {
                      var descripcion = nameController.text.trim();
                      var cantidad = quantityController.text.trim();
                      FirebaseFirestore.instance
                          .collection(COLLECTION_NAME)
                          .doc(id)
                          .update(
                        {"descripcion": descripcion, "cantidad": cantidad},
                      );
                      Navigator.pop(context);
                    },
                    child: Text("Modificar"),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
