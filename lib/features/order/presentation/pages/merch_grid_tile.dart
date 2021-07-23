import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:test_test/features/order/domain/entities/merch.dart';

class MerchGridTile extends StatefulWidget {
  final Merch? merch;
  final VoidCallback? onDelete;
  MerchGridTile({Key? key, @required this.merch, @required this.onDelete})
      : super(key: key);

  @override
  _MerchGridTileState createState() => _MerchGridTileState();
}

class _MerchGridTileState extends State<MerchGridTile> {
  final cacheManager = DefaultCacheManager();
  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Text(
          widget.merch?.name ?? 'Merchandise',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        )),
      ),
      child: Container(
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: Colors.grey,
                child: (widget.merch?.image == null)
                    ? Container()
                    : CachedNetworkImage(
                        cacheManager: cacheManager,
                        fit: BoxFit.cover,
                        imageUrl: widget.merch!.image!.thumb!,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Ink(
                decoration: const ShapeDecoration(
                  color: Colors.blue,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.white,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: widget.onDelete,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
