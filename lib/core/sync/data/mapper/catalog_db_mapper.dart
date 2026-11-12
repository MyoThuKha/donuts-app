import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/database/daos/catalog_dao.dart';
import 'package:donuts/core/database/daos/member_dao.dart';
import 'package:donuts/core/sync/data/dto/catalog_dto.dart';
import 'package:donuts/core/sync/data/dto/member_dto.dart';
import 'package:drift/drift.dart';

extension CatalogDtoDbMapper on CatalogDto {
  CatalogRows toRows() => (
    products: [for (final p in products) p.toCompanion()],
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
    banners: [for (final b in banners) b.toCompanion()],
    shops: [for (final s in shops) s.toCompanion()],
  );
}

extension ProductDtoDbMapper on ProductDto {
  ProductsTableCompanion toCompanion() => ProductsTableCompanion.insert(
    id: id,
    code: code,
    name: name,
    priceMmk: priceMmk,
    isNew: isNew,
    discountPercent: Value(discountPercent),
    description: description,
    imageUrl: imageUrl,
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
  BannersTableCompanion toCompanion() => BannersTableCompanion.insert(
    id: id,
    tag: tag,
    title: title,
    style: style.name,
    imageUrl: imageUrl,
    imageAsset: Value(imageAsset),
    sortOrder: sortOrder,
  );
}

extension ShopDtoDbMapper on ShopDto {
  ShopsTableCompanion toCompanion() => ShopsTableCompanion.insert(
    id: id,
    name: name,
    address: address,
    imageUrl: imageUrl,
    imageAsset: Value(imageAsset),
    sortOrder: sortOrder,
  );
}

extension MemberSeedDtoDbMapper on MemberSeedDto {
  MemberRows toRows() => (
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
        ),
    ],
    challenges: [for (final c in challenges) c.toCompanion()],
    gifts: [
      for (final g in gifts)
        GiftsTableCompanion.insert(
          id: g.id,
          title: g.title,
          costPoints: g.costPoints,
          imageAsset: Value(g.imageAsset),
          sortOrder: g.sortOrder,
        ),
    ],
  );
}

extension ChallengeDtoDbMapper on ChallengeDto {
  ChallengesTableCompanion toCompanion() => ChallengesTableCompanion.insert(
    id: id,
    title: title,
    kind: kind.name,
    progress: progress,
    target: target,
    rewardPoints: rewardPoints,
    imageAsset: Value(imageAsset),
    sortOrder: sortOrder,
  );
}
