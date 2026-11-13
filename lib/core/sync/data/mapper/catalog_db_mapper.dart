import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/database/daos/catalog_dao.dart';
import 'package:donuts/core/database/daos/member_dao.dart';
import 'package:donuts/core/sync/data/dto/catalog_dto.dart';
import 'package:donuts/core/sync/data/dto/member_dto.dart';
import 'package:drift/drift.dart';

extension CatalogDtoDbMapper on CatalogDto {
  /// Image URLs that are relative resolve against [imageBase]. Absolute ones
  /// stay as they are.
  CatalogRows toRows({required Uri imageBase}) => (
    products: [for (final p in products) p.toCompanion(imageBase)],
    sections: [for (final s in sections) s.toCompanion()],
    sectionProducts: [
      for (final s in sections)
        for (final (i, productId) in s.productIds.indexed)
          SectionProductsTableCompanion.insert(
            sectionId: s.id,
            productId: productId,
            sortOrder: i,
          ),
    ],
    banners: [for (final b in banners) b.toCompanion(imageBase)],
    shops: [for (final s in shops) s.toCompanion(imageBase)],
    gifts: [for (final g in gifts) g.toCompanion(imageBase)],
  );
}

extension ProductDtoDbMapper on ProductDto {
  ProductsTableCompanion toCompanion(Uri imageBase) =>
      ProductsTableCompanion.insert(
        id: id,
        code: code,
        name: name,
        priceMmk: priceMmk,
        isNew: isNew,
        discountPercent: Value(discountPercent),
        description: description,
        imageUrl: imageBase.resolve(imageUrl).toString(),
        imageAsset: Value(imageAsset),
        updatedAt: updatedAt,
      );
}

extension HomeSectionDtoDbMapper on HomeSectionDto {
  HomeSectionsTableCompanion toCompanion() => HomeSectionsTableCompanion.insert(
    id: id,
    titleKey: titleKey,
    sortOrder: sortOrder,
  );
}

extension BannerDtoDbMapper on BannerDto {
  BannersTableCompanion toCompanion(Uri imageBase) =>
      BannersTableCompanion.insert(
        id: id,
        tag: tag,
        title: title,
        style: style.name,
        imageUrl: imageBase.resolve(imageUrl).toString(),
        imageAsset: Value(imageAsset),
        sortOrder: sortOrder,
      );
}

extension ShopDtoDbMapper on ShopDto {
  ShopsTableCompanion toCompanion(Uri imageBase) => ShopsTableCompanion.insert(
    id: id,
    name: name,
    address: address,
    imageUrl: imageBase.resolve(imageUrl).toString(),
    imageAsset: Value(imageAsset),
    sortOrder: sortOrder,
  );
}

extension MemberSeedDtoDbMapper on MemberSeedDto {
  /// Relative tier and challenge image URLs resolve against [imageBase],
  /// like the catalog's.
  MemberRows toRows({required Uri imageBase}) => (
    profile: MemberProfileTableCompanion.insert(
      id: const Value(MemberDao.profileId),
      totalPoints: profile.totalPoints,
      avatarUrl: profile.avatarUrl,
      avatarAsset: Value(profile.avatarAsset),
      notificationCount: profile.notificationCount,
      rewardsCount: profile.rewardsCount,
    ),
    tiers: [
      for (final t in tiers)
        TiersTableCompanion.insert(
          id: t.id,
          name: t.name,
          minPoints: t.minPoints,
          sortOrder: t.sortOrder,
          imageUrl: Value(_resolve(imageBase, t.imageUrl)),
          imageAsset: Value(t.imageAsset),
        ),
    ],
    challenges: [for (final c in challenges) c.toCompanion(imageBase)],
  );
}

extension GiftDtoDbMapper on GiftDto {
  GiftsTableCompanion toCompanion(Uri imageBase) => GiftsTableCompanion.insert(
    id: id,
    title: title,
    costPoints: costPoints,
    imageUrl: Value(_resolve(imageBase, imageUrl)),
    imageAsset: Value(imageAsset),
    sortOrder: sortOrder,
  );
}

/// [url] against [imageBase] when it is relative; null stays null.
String? _resolve(Uri imageBase, String? url) =>
    url == null ? null : imageBase.resolve(url).toString();

extension ChallengeDtoDbMapper on ChallengeDto {
  ChallengesTableCompanion toCompanion(Uri imageBase) =>
      ChallengesTableCompanion.insert(
        id: id,
        title: title,
        kind: kind.name,
        progress: progress,
        target: target,
        rewardPoints: rewardPoints,
        imageUrl: Value(_resolve(imageBase, imageUrl)),
        imageAsset: Value(imageAsset),
        sortOrder: sortOrder,
      );
}
