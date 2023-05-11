// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:nutmeup/constants/Colors.dart';
import 'package:nutmeup/constants/DBNames.dart';
import 'package:nutmeup/controllers/extras.dart';
import 'package:nutmeup/models/Store/ProductModel.dart';

import '../utilities/utilities.dart';

class MyProducts extends StatefulWidget {
  const MyProducts({Key? key}) : super(key: key);

  @override
  State<MyProducts> createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> with Extra {
  SingleProduct({required ProductModel product}) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Image.network(
              product.gallery!.first.link!,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "  ${product.name}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16, color: colorBlue, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            formatAmount(product.price!.amount),
            style: TextStyle(
                fontSize: 16,
                color: colorLightBlue,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const SizedBox(
                width: 6,
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Color(0xffE4F0FF),
                  // border: Border.all(width: 1, color: colorLightBlue),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Text(
                  product.promotion == null ? "Promote" : "Promoting",
                  style: TextStyle(
                      fontSize: 15,
                      color: colorBlue,
                      fontWeight: FontWeight.w300),
                ),
              )),
              Container(
                margin: const EdgeInsets.only(left: 10),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Color(0xffE4F0FF),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: const Icon(Icons.more_horiz),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: StreamBuilder(
        stream: firestore
            .collection(PRODUCTS)
            .where("storeId", isEqualTo: userId)
            .where("status", isEqualTo: "ACTIVE")
            .snapshots(),
        builder: (a, AsyncSnapshot<QuerySnapshot> b) {
          if (b.hasError) {
            return Text("Something went wrong");
          }
          if (b.hasData) {
            if (b.data!.docs.length == 0) {
              return Container(
                alignment: Alignment.center,
                child: Text("No Products yet"),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          List<ProductModel> allProducts = [];
          b.data!.docs.forEach((element) {
            ProductModel single =
                ProductModel.fromJson(element.data() as Map<String, dynamic>);
            allProducts.add(single);
          });
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: 260),
            itemBuilder: (context, index) =>
                SingleProduct(product: allProducts[index]),
            itemCount: allProducts.length,
          );
        },
      ),
    );
  }
}
