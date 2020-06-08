import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymarket/constants.dart';
import 'package:mymarket/models/product.dart';

class Store {
  final Firestore _firestore = Firestore.instance;

  addProduct(Product product) {
    _firestore.collection(kProductCollection).add({
      kProductName: product.pName,
      kProductPrice: product.pPrice,
      kProductDescription: product.pDescription,
      kProductCategory: product.pCategory,
      kProductLocation: product.pLocation,
    });
  }

  Stream<QuerySnapshot> loadProduct() {
    return _firestore.collection(kProductCollection).snapshots();
  }

  deleteProduct(documentId) {
    _firestore.collection(kProductCollection).document(documentId).delete();
  }

  editProduct(data, documentId) {
    _firestore
        .collection(kProductCollection)
        .document(documentId)
        .updateData(data);
  }

  storeOrder(data, List<Product> products) {
    var documentRef = _firestore.collection(kOrders).document();
    documentRef.setData(data);
    for (var product in products) {
      documentRef.collection(kOrderDetails).document().setData({
        kProductName: product.pName,
        kProductPrice: product.pPrice,
        kProductQuantity: product.pQuantity,
        kProductLocation: product.pLocation,
      });
    }
  }

  Stream<QuerySnapshot> loadOrders() {
    _firestore.collection(kOrders).snapshots();
  }
}
