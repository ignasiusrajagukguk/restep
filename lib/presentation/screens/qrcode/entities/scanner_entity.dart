// /// Pure domain entities for the Scanner feature.
// ///
// /// [ScanResultEntity] is a sealed class. After a QR/barcode lookup the API
// /// returns one concrete subtype depending on the scanned object's `type` field:
// ///
// ///   PackageScanData   — a physical shipment package
// ///   BoothScanData     — an exhibitor booth
// ///   BadgeScanData     — a visitor / exhibitor access badge
// ///   ParkingScanData   — a truck / vehicle parking slot
// ///   EmptiesScanData   — empty packaging (crates, pallets, etc.)
// ///
// /// Widgets switch on the sealed type instead of comparing raw strings:
// ///
// ///   switch (result) {
// ///     case PackageScanData()  => PackageScan(data: result, ctrl: ctrl),
// ///     case BoothScanData()    => BoothScan(data: result, ctrl: ctrl),
// ///     case BadgeScanData()    => BadgeScan(data: result, ctrl: ctrl),
// ///     case ParkingScanData()  => ParkingScan(data: result, ctrl: ctrl),
// ///     case EmptiesScanData()  => EmptiesScan(data: result, ctrl: ctrl),
// ///   }

// // ─── Status enums (shared across variants) ────────────────────────────────────

// /// Drives the animated success icon colour and status badge in every scan view.
// enum ScanResultStatus { inTransit, inStorage, damaged, delivered }

// /// Badge access decision returned by the API.
// enum BadgeAccessLevel { granted, flagged, denied }

// /// Zone-level access for a badge holder.
// enum ZoneAccessLevel { full, escortOnly, noAccess }

// /// Permission entry for a badge holder.
// enum PermissionStatus { allowed, restricted, blocked }

// /// Parking action to be performed after scanning.
// enum ParkingAction { inbound, outbound, rebook }

// // ─── Shared value objects ─────────────────────────────────────────────────────

// class ZoneAccess {
//   final String name;
//   final ZoneAccessLevel level;
//   const ZoneAccess({required this.name, required this.level});
// }

// class BadgePermission {
//   final String label;
//   final PermissionStatus status;
//   const BadgePermission({required this.label, required this.status});
// }

// // ─── Recent scan chip (scanner strip at top of scan page) ─────────────────────

// class RecentScanEntity {
//   final String id;
//   final String timeLabel;
//   final ScanResultStatus status;

//   const RecentScanEntity({
//     required this.id,
//     required this.timeLabel,
//     required this.status,
//   });
// }

// // ─── Base sealed class ────────────────────────────────────────────────────────

// /// Base for all scan result variants. Holds only fields truly common to every
// /// type (the scanned ID, a human-readable name/label, and the status colour).
// sealed class ScanResultEntity {
//   /// The raw value that was scanned (QR / barcode string).
//   final String scannedId;

//   /// Short human-readable label shown under the success icon.
//   final String displayName;

//   /// Drives the success icon colour and any status chips.
//   final ScanResultStatus? status;

//   const ScanResultEntity({
//     required this.scannedId,
//     required this.displayName,
//     this.status,
//   });
// }

// // ─── Package variant ──────────────────────────────────────────────────────────

// // class PackageScanData extends ScanResultEntity {
// //   /// e.g. "VLV-2048"
// //   final String shipmentRef;

// //   /// Client / company name, e.g. "GlobalTech GmbH"
// //   final String client;

// //   /// e.g. "Hall 3 · Stand 214B"
// //   final String destination;

// //   /// Shipment identifier (may differ from shipmentRef in some flows)
// //   final String shipment;

// //   /// e.g. "320 kg"
// //   final String weight;

// //   const PackageScanData({
// //     required super.scannedId,
// //     required super.displayName,
// //     required super.status,
// //     required this.shipmentRef,
// //     required this.client,
// //     required this.destination,
// //     required this.shipment,
// //     required this.weight,
// //   });
// // }

// class PackageScanData extends ScanResultEntity {
//   /// e.g. "VLV-2048"
//   final String shipmentCode;

//   /// Client / company name, e.g. "GlobalTech GmbH"
//   final String client;

//   /// e.g. "Hall 3 · Stand 214B"
//   final String recipient;

//   /// Shipment identifier (may differ from shipmentCode in some flows)
//   final String trackingCode;

//   final String deliveryWindow;
//   final InHandStatus statusPackage;
//   final DateTime deadlineTime;
//   final PackageType packageType;
//   final String? notes;
//   final DeliveryPriority priority;

//   /// e.g. "320 kg"
//   final String weight;

//   /// Matches [InHandEventsFilter.id] — e.g. "cabsat-2026"
//   final String? eventId;

//   /// Remote photo URLs attached to this package (warehouse photos, labels, etc.)
//   final List<String> photoUrls;

//   const PackageScanData({
//     required super.scannedId,
//     required super.displayName,
//     required super.status,
//     required this.statusPackage,
//     required this.shipmentCode,
//     required this.client,
//     required this.recipient,
//     required this.trackingCode,
//     required this.deliveryWindow,
//     required this.deadlineTime,
//     required this.packageType,
//     this.notes,
//     required this.priority,
//     required this.weight,
//     this.eventId,
//     this.photoUrls = const [],
//   });
// }

// // ─── Booth variant ────────────────────────────────────────────────────────────

// class BoothScanData extends ScanResultEntity {
//   /// e.g. "Stand 214B"
//   final String standNumber;

//   /// e.g. "Hall 3"
//   final String hall;

//   /// e.g. "GlobalTech GmbH"
//   final String exhibitor;

//   /// e.g. "Build-up", "Open", "Break-down"
//   final String phase;

//   const BoothScanData({
//     required super.scannedId,
//     required super.displayName,
//     required super.status,
//     required this.standNumber,
//     required this.hall,
//     required this.exhibitor,
//     required this.phase,
//   });
// }

// // ─── Badge variant ────────────────────────────────────────────────────────────

// class BadgeScanData extends ScanResultEntity {
//   /// e.g. "MA" — used for the avatar circle
//   final String initials;

//   /// e.g. "NovaTech GmbH"
//   final String company;

//   /// e.g. "ISE 2024 · Amsterdam RAI"
//   final String event;

//   /// e.g. "Exhibitor Plus"
//   final String ticketType;

//   /// e.g. "Jan 30 – Feb 2"
//   final String badgeValidity;

//   /// Number of check-ins recorded today
//   final int checkInsToday;

//   /// e.g. "Hall 7 · 09:42"
//   final String lastScan;

//   final BadgeAccessLevel accessLevel;

//   final List<ZoneAccess> zones;

//   final List<BadgePermission> permissions;

//   const BadgeScanData({
//     required super.scannedId,
//     required super.displayName,
//     required super.status,
//     required this.initials,
//     required this.company,
//     required this.event,
//     required this.ticketType,
//     required this.badgeValidity,
//     required this.checkInsToday,
//     required this.lastScan,
//     required this.accessLevel,
//     required this.zones,
//     required this.permissions,
//   });
// }

// // ─── Parking variant ──────────────────────────────────────────────────────────

// class ParkingScanData extends ScanResultEntity {
//   /// License plate string, e.g. "AA-123-BB"
//   final String licensePlate;

//   /// e.g. "Truck", "Van", "Car"
//   final String vehicleType;

//   /// e.g. "27 Mar 2025"
//   final String accessDate;

//   /// e.g. "08:00"
//   final String accessTimeFrom;

//   /// e.g. "16:00"
//   final String accessTimeUntil;

//   /// e.g. "Build-up", "Break-down", "Delivery"
//   final String accessWindow;

//   /// e.g. "P2"
//   final String parkingSite;

//   final bool forkliftBooked;

//   /// Number of forklifts assigned (0 when none)
//   final int forkliftCount;

//   /// Max lift capacity per single forklift unit, in tonnes
//   final double forkliftMaxCapacityTon;

//   /// Combined capacity of all assigned forklifts, in tonnes
//   final double forkliftTotalCapacityTon;

//   const ParkingScanData({
//     required super.scannedId,
//     required super.displayName,
//     required super.status,
//     required this.licensePlate,
//     required this.vehicleType,
//     required this.accessDate,
//     required this.accessTimeFrom,
//     required this.accessTimeUntil,
//     required this.accessWindow,
//     required this.parkingSite,
//     required this.forkliftBooked,
//     required this.forkliftCount,
//     required this.forkliftMaxCapacityTon,
//     required this.forkliftTotalCapacityTon,
//   });
// }

// // ─── Empties variant ──────────────────────────────────────────────────────────

// class EmptiesScanData extends ScanResultEntity {
//   /// e.g. "Wooden Pallet", "Metal Crate"
//   final String containerType;

//   /// e.g. "12"
//   final int quantity;

//   /// e.g. "Hall 3 · Stand 214B"
//   final String currentLocation;

//   /// e.g. "Temp Storage B"
//   final String targetStorage;

//   /// e.g. "2025-04-01"
//   final String returnDeadline;

//   const EmptiesScanData({
//     required super.scannedId,
//     required super.displayName,
//     required super.status,
//     required this.containerType,
//     required this.quantity,
//     required this.currentLocation,
//     required this.targetStorage,
//     required this.returnDeadline,
//   });
// }

// enum PackageType { envelope, parcel, fragile, oversized }

// enum InHandStatus {
//   pending, // not yet attempted
//   attempted, // tried but failed (nobody home, etc.)
//   delivered, // successfully handed over
// }

// enum DeliveryPriority { normal, express, urgent }

// /// Pure domain entities for the Scanner feature.
// ///
// /// [ScanResultEntity] is a sealed class. After a QR/barcode lookup the API
// /// returns one concrete subtype depending on the scanned object's `type` field:
// ///
// ///   PackageScanData   — a physical shipment package
// ///   BoothScanData     — an exhibitor booth
// ///   BadgeScanData     — a visitor / exhibitor access badge
// ///   ParkingScanData   — a truck / vehicle parking slot
// ///   EmptiesScanData   — empty packaging (crates, pallets, etc.)
// ///
// /// Widgets switch on the sealed type instead of comparing raw strings:
// ///
// ///   switch (result) {
// ///     case PackageScanData()  => PackageScan(data: result, ctrl: ctrl),
// ///     case BoothScanData()    => BoothScan(data: result, ctrl: ctrl),
// ///     case BadgeScanData()    => BadgeScan(data: result, ctrl: ctrl),
// ///     case ParkingScanData()  => ParkingScan(data: result, ctrl: ctrl),
// ///     case EmptiesScanData()  => EmptiesScan(data: result, ctrl: ctrl),
// ///   }

// // ─── Status enums (shared across variants) ────────────────────────────────────

// /// Drives the animated success icon colour and status badge in every scan view.
// enum ScanResultStatus { inTransit, inStorage, damaged, delivered }

// /// Badge access decision returned by the API.
// enum BadgeAccessLevel { granted, flagged, denied }

// /// Zone-level access for a badge holder.
// enum ZoneAccessLevel { full, escortOnly, noAccess }

// /// Permission entry for a badge holder.
// enum PermissionStatus { allowed, restricted, blocked }

// /// Parking action to be performed after scanning.
// enum ParkingAction { inbound, outbound, rebook }

// // ─── Shared value objects ─────────────────────────────────────────────────────

// class ZoneAccess {
//   final String name;
//   final ZoneAccessLevel level;
//   const ZoneAccess({required this.name, required this.level});
// }

// class BadgePermission {
//   final String label;
//   final PermissionStatus status;
//   const BadgePermission({required this.label, required this.status});
// }

// // ─── Recent scan chip (scanner strip at top of scan page) ─────────────────────

// class RecentScanEntity {
//   final String id;
//   final String timeLabel;
//   final ScanResultStatus status;

//   const RecentScanEntity({
//     required this.id,
//     required this.timeLabel,
//     required this.status,
//   });
// }

// // ─── Base sealed class ────────────────────────────────────────────────────────

// /// Base for all scan result variants. Holds only fields truly common to every
// /// type (the scanned ID, a human-readable name/label, and the status colour).
// sealed class ScanResultEntity {
//   /// The raw value that was scanned (QR / barcode string).
//   final String scannedId;

//   /// Short human-readable label shown under the success icon.
//   final String displayName;

//   /// Drives the success icon colour and any status chips.
//   final ScanResultStatus? status;

//   const ScanResultEntity({
//     required this.scannedId,
//     required this.displayName,
//     this.status,
//   });
// }

// // ─── Package variant ──────────────────────────────────────────────────────────

// // class PackageScanData extends ScanResultEntity {
// //   /// e.g. "VLV-2048"
// //   final String shipmentRef;

// //   /// Client / company name, e.g. "GlobalTech GmbH"
// //   final String client;

// //   /// e.g. "Hall 3 · Stand 214B"
// //   final String destination;

// //   /// Shipment identifier (may differ from shipmentRef in some flows)
// //   final String shipment;

// //   /// e.g. "320 kg"
// //   final String weight;

// //   const PackageScanData({
// //     required super.scannedId,
// //     required super.displayName,
// //     required super.status,
// //     required this.shipmentRef,
// //     required this.client,
// //     required this.destination,
// //     required this.shipment,
// //     required this.weight,
// //   });
// // }

// class PackageScanData extends ScanResultEntity {
//   /// e.g. "VLV-2048"
//   final String shipmentCode;

//   /// Client / company name, e.g. "GlobalTech GmbH"
//   final String client;

//   /// e.g. "Hall 3 · Stand 214B"
//   final String recipient;

//   /// Shipment identifier (may differ from shipmentCode in some flows)
//   final String trackingCode;

//   final String deliveryWindow;
//   final InHandStatus statusPackage;
//   final DateTime deadlineTime;
//   final PackageType packageType;
//   final String? notes;
//   final DeliveryPriority priority;

//   /// e.g. "320 kg"
//   final String weight;

//   const PackageScanData({
//     required super.scannedId,
//     required super.displayName,
//     required super.status,
//     required this.statusPackage,
//     required this.shipmentCode,
//     required this.client,
//     required this.recipient,
//     required this.trackingCode,
//     required this.deliveryWindow,
//     required this.deadlineTime,
//     required this.packageType,
//     this.notes,
//     required this.priority,
//     required this.weight,
//   });
// }

// // ─── Booth variant ────────────────────────────────────────────────────────────

// class BoothScanData extends ScanResultEntity {
//   /// e.g. "Stand 214B"
//   final String standNumber;

//   /// e.g. "Hall 3"
//   final String hall;

//   /// e.g. "GlobalTech GmbH"
//   final String exhibitor;

//   /// e.g. "Build-up", "Open", "Break-down"
//   final String phase;

//   const BoothScanData({
//     required super.scannedId,
//     required super.displayName,
//     required super.status,
//     required this.standNumber,
//     required this.hall,
//     required this.exhibitor,
//     required this.phase,
//   });
// }

// // ─── Badge variant ────────────────────────────────────────────────────────────

// class BadgeScanData extends ScanResultEntity {
//   /// e.g. "MA" — used for the avatar circle
//   final String initials;

//   /// e.g. "NovaTech GmbH"
//   final String company;

//   /// e.g. "ISE 2024 · Amsterdam RAI"
//   final String event;

//   /// e.g. "Exhibitor Plus"
//   final String ticketType;

//   /// e.g. "Jan 30 – Feb 2"
//   final String badgeValidity;

//   /// Number of check-ins recorded today
//   final int checkInsToday;

//   /// e.g. "Hall 7 · 09:42"
//   final String lastScan;

//   final BadgeAccessLevel accessLevel;

//   final List<ZoneAccess> zones;

//   final List<BadgePermission> permissions;

//   const BadgeScanData({
//     required super.scannedId,
//     required super.displayName,
//     required super.status,
//     required this.initials,
//     required this.company,
//     required this.event,
//     required this.ticketType,
//     required this.badgeValidity,
//     required this.checkInsToday,
//     required this.lastScan,
//     required this.accessLevel,
//     required this.zones,
//     required this.permissions,
//   });
// }

// // ─── Parking variant ──────────────────────────────────────────────────────────

// class ParkingScanData extends ScanResultEntity {
//   /// License plate string, e.g. "AA-123-BB"
//   final String licensePlate;

//   /// e.g. "Truck", "Van", "Car"
//   final String vehicleType;

//   /// e.g. "27 Mar 2025"
//   final String accessDate;

//   /// e.g. "08:00"
//   final String accessTimeFrom;

//   /// e.g. "16:00"
//   final String accessTimeUntil;

//   /// e.g. "Build-up", "Break-down", "Delivery"
//   final String accessWindow;

//   /// e.g. "P2"
//   final String parkingSite;

//   final bool forkliftBooked;

//   /// Number of forklifts assigned (0 when none)
//   final int forkliftCount;

//   /// Max lift capacity per single forklift unit, in tonnes
//   final double forkliftMaxCapacityTon;

//   /// Combined capacity of all assigned forklifts, in tonnes
//   final double forkliftTotalCapacityTon;

//   const ParkingScanData({
//     required super.scannedId,
//     required super.displayName,
//     required super.status,
//     required this.licensePlate,
//     required this.vehicleType,
//     required this.accessDate,
//     required this.accessTimeFrom,
//     required this.accessTimeUntil,
//     required this.accessWindow,
//     required this.parkingSite,
//     required this.forkliftBooked,
//     required this.forkliftCount,
//     required this.forkliftMaxCapacityTon,
//     required this.forkliftTotalCapacityTon,
//   });
// }

// // ─── Empties variant ──────────────────────────────────────────────────────────

// class EmptiesScanData extends ScanResultEntity {
//   /// e.g. "Wooden Pallet", "Metal Crate"
//   final String containerType;

//   /// e.g. "12"
//   final int quantity;

//   /// e.g. "Hall 3 · Stand 214B"
//   final String currentLocation;

//   /// e.g. "Temp Storage B"
//   final String targetStorage;

//   /// e.g. "2025-04-01"
//   final String returnDeadline;

//   const EmptiesScanData({
//     required super.scannedId,
//     required super.displayName,
//     required super.status,
//     required this.containerType,
//     required this.quantity,
//     required this.currentLocation,
//     required this.targetStorage,
//     required this.returnDeadline,
//   });
// }

// enum PackageType { envelope, parcel, fragile, oversized }

// enum InHandStatus {
//   pending, // not yet attempted
//   attempted, // tried but failed (nobody home, etc.)
//   delivered, // successfully handed over
// }

// enum DeliveryPriority { normal, express, urgent }

// /// Pure domain entities for the Scanner / Scan Package page.

// /// A recently scanned package chip shown in the strip.
// class RecentScanEntity {
//   final String packageId;
//   final String timeLabel;
//   final ScanResultStatus status;

//   const RecentScanEntity({
//     required this.packageId,
//     required this.timeLabel,
//     required this.status,
//   });
// }

// /// Full scan result — shown in the success overlay after a scan.
// class ScanResultEntity {
//   final String type;
//   final String packageId;
//   final String packageName;
//   final String shipmentRef;
//   final String client;
//   final String destination;
//   final ScanResultStatus status;
//   final String shipment;
//   final String weight;

//   const ScanResultEntity({
//     required this.type,
//     required this.packageId,
//     required this.packageName,
//     required this.shipmentRef,
//     required this.client,
//     required this.destination,
//     required this.status,
//     required this.shipment,
//     required this.weight,
//   });
// }

// /// Package status — drives icon colour and status badge colour.
// enum ScanResultStatus { inTransit, inStorage, damaged, delivered }

/// Pure domain entities for the Scanner feature.
///
/// [ScanResultEntity] is a sealed class. After a QR/barcode lookup the API
/// returns one concrete subtype depending on the scanned object's `type` field:
///
///   PackageScanData   — a physical shipment package
///   BoothScanData     — an exhibitor booth
///   BadgeScanData     — a visitor / exhibitor access badge
///   ParkingScanData   — a truck / vehicle parking slot
///   EmptiesScanData   — empty packaging (crates, pallets, etc.)
///
/// Widgets switch on the sealed type instead of comparing raw strings:
///
///   switch (result) {
///     case PackageScanData()  => PackageScan(data: result, ctrl: ctrl),
///     case BoothScanData()    => BoothScan(data: result, ctrl: ctrl),
///     case BadgeScanData()    => BadgeScan(data: result, ctrl: ctrl),
///     case ParkingScanData()  => ParkingScan(data: result, ctrl: ctrl),
///     case EmptiesScanData()  => EmptiesScan(data: result, ctrl: ctrl),
///   }

// ─── Status enums (shared across variants) ────────────────────────────────────

/// Drives the animated success icon colour and status badge in every scan view.
enum ScanResultStatus { inTransit, inStorage, damaged, delivered }

/// Badge access decision returned by the API.
enum BadgeAccessLevel { granted, flagged, denied }

/// Zone-level access for a badge holder.
enum ZoneAccessLevel { full, escortOnly, noAccess }

/// Permission entry for a badge holder.
enum PermissionStatus { allowed, restricted, blocked }

/// Parking action to be performed after scanning.
enum ParkingAction { inbound, outbound, rebook }

// ─── Shared value objects ─────────────────────────────────────────────────────

class ZoneAccess {
  final String name;
  final ZoneAccessLevel level;
  const ZoneAccess({required this.name, required this.level});
}

class BadgePermission {
  final String label;
  final PermissionStatus status;
  const BadgePermission({required this.label, required this.status});
}

// ─── Recent scan chip (scanner strip at top of scan page) ─────────────────────

class RecentScanEntity {
  final String id;
  final String timeLabel;
  final ScanResultStatus status;

  const RecentScanEntity({
    required this.id,
    required this.timeLabel,
    required this.status,
  });
}

// ─── Base sealed class ────────────────────────────────────────────────────────

/// Base for all scan result variants. Holds only fields truly common to every
/// type (the scanned ID, a human-readable name/label, and the status colour).
sealed class ScanResultEntity {
  /// The raw value that was scanned (QR / barcode string).
  final String scannedId;

  /// Short human-readable label shown under the success icon.
  final String displayName;

  /// Drives the success icon colour and any status chips.
  final ScanResultStatus? status;

  const ScanResultEntity({
    required this.scannedId,
    required this.displayName,
    this.status,
  });
}

// ─── Package variant ──────────────────────────────────────────────────────────

// class PackageScanData extends ScanResultEntity {
//   /// e.g. "VLV-2048"
//   final String shipmentRef;

//   /// Client / company name, e.g. "GlobalTech GmbH"
//   final String client;

//   /// e.g. "Hall 3 · Stand 214B"
//   final String destination;

//   /// Shipment identifier (may differ from shipmentRef in some flows)
//   final String shipment;

//   /// e.g. "320 kg"
//   final String weight;

//   const PackageScanData({
//     required super.scannedId,
//     required super.displayName,
//     required super.status,
//     required this.shipmentRef,
//     required this.client,
//     required this.destination,
//     required this.shipment,
//     required this.weight,
//   });
// }

class PackageScanData extends ScanResultEntity {
  /// e.g. "VLV-2048"
  final String shipmentCode;

  /// Client / company name, e.g. "GlobalTech GmbH"
  final String client;

  /// e.g. "Hall 3 · Stand 214B"
  final String recipient;

  /// Shipment identifier (may differ from shipmentCode in some flows)
  final String trackingCode;

  final String deliveryWindow;
  final InHandStatus statusPackage;
  final DateTime deadlineTime;
  final PackageType packageType;
  final String? notes;
  final DeliveryPriority priority;

  /// e.g. "320 kg"
  final String weight;

  /// Matches [InHandEventsFilter.id] — e.g. "cabsat-2026"
  final String? eventId;

  /// Remote photo URLs attached to this package (warehouse photos, labels, etc.)
  final List<String> photoUrls;

  const PackageScanData({
    required super.scannedId,
    required super.displayName,
    required super.status,
    required this.statusPackage,
    required this.shipmentCode,
    required this.client,
    required this.recipient,
    required this.trackingCode,
    required this.deliveryWindow,
    required this.deadlineTime,
    required this.packageType,
    this.notes,
    required this.priority,
    required this.weight,
    this.eventId,
    this.photoUrls = const [],
  });
}

// ─── Booth variant ────────────────────────────────────────────────────────────

// ─── Booth value objects ──────────────────────────────────────────────────────

/// Status of a single package linked to a booth.
enum BoothPackageStatus { delivered, inTransit, inStorage, damaged }

/// A package associated with a booth, shown in the Packages tab.
class BoothPackageData {
  final String packageId;
  final String name;
  final BoothPackageStatus status;
  const BoothPackageData({
    required this.packageId,
    required this.name,
    required this.status,
  });
}

/// A person contact (exhibitor contact or Valverde handler) for a booth.
class BoothContactData {
  final String name;
  final String initials;
  final String role;
  const BoothContactData({
    required this.name,
    required this.initials,
    required this.role,
  });
}

/// A single event in the booth's activity / delivery timeline.
class BoothActivityEventData {
  final String time;
  final String title;
  final String subtitle;

  /// Raw string colour key: 'green', 'amber', 'red', 'blue'
  final String dotColor;
  const BoothActivityEventData({
    required this.time,
    required this.title,
    required this.subtitle,
    required this.dotColor,
  });
}

// ─── Booth variant ────────────────────────────────────────────────────────────

class BoothScanData extends ScanResultEntity {
  /// e.g. "Stand 214B"
  final String standNumber;

  /// e.g. "Hall 3 · ISE 2024 · Amsterdam RAI"
  final String hall;

  /// e.g. "GlobalTech GmbH"
  final String exhibitor;

  /// e.g. "Build-up", "Open", "Break-down"
  final String phase;

  /// e.g. "Island stand"
  final String standType;

  /// e.g. "148 m² (12 × 12.3)"
  final String size;

  /// e.g. "Jan 28 – Jan 29"
  final String buildUp;

  /// e.g. "Feb 2 from 18:00"
  final String breakDown;

  /// e.g. "Today · 09:42"
  final String lastDelivery;

  /// e.g. "Yes — 2 pallets"
  final String forkLiftNeeded;

  /// e.g. "84.2 kg"
  final String co2;

  /// Packages linked to this booth (Packages tab).
  final List<BoothPackageData> packages;

  /// Exhibitor / stand contacts (Contacts tab).
  final List<BoothContactData> contacts;

  /// Valverde handlers assigned to this booth (Contacts tab).
  final List<BoothContactData> handlers;

  /// Delivery timeline events (Activity tab).
  final List<BoothActivityEventData> activity;

  const BoothScanData({
    required super.scannedId,
    required super.displayName,
    required super.status,
    required this.standNumber,
    required this.hall,
    required this.exhibitor,
    required this.phase,
    required this.standType,
    required this.size,
    required this.buildUp,
    required this.breakDown,
    required this.lastDelivery,
    required this.forkLiftNeeded,
    required this.co2,
    this.packages = const [],
    this.contacts = const [],
    this.handlers = const [],
    this.activity = const [],
  });
}

// ─── Badge variant ────────────────────────────────────────────────────────────

class BadgeScanData extends ScanResultEntity {
  /// e.g. "MA" — used for the avatar circle
  final String initials;

  /// e.g. "NovaTech GmbH"
  final String company;

  /// e.g. "ISE 2024 · Amsterdam RAI"
  final String event;

  /// e.g. "Exhibitor Plus"
  final String ticketType;

  /// e.g. "Jan 30 – Feb 2"
  final String badgeValidity;

  /// Number of check-ins recorded today
  final int checkInsToday;

  /// e.g. "Hall 7 · 09:42"
  final String lastScan;

  final BadgeAccessLevel accessLevel;

  final List<ZoneAccess> zones;

  final List<BadgePermission> permissions;

  const BadgeScanData({
    required super.scannedId,
    required super.displayName,
    required super.status,
    required this.initials,
    required this.company,
    required this.event,
    required this.ticketType,
    required this.badgeValidity,
    required this.checkInsToday,
    required this.lastScan,
    required this.accessLevel,
    required this.zones,
    required this.permissions,
  });
}

// ─── Parking variant ──────────────────────────────────────────────────────────

class ParkingScanData extends ScanResultEntity {
  /// License plate string, e.g. "AA-123-BB"
  final String licensePlate;

  /// e.g. "Truck", "Van", "Car"
  final String vehicleType;

  /// e.g. "27 Mar 2025"
  final String accessDate;

  /// e.g. "08:00"
  final String accessTimeFrom;

  /// e.g. "16:00"
  final String accessTimeUntil;

  /// e.g. "Build-up", "Break-down", "Delivery"
  final String accessWindow;

  /// e.g. "P2"
  final String parkingSite;

  final bool forkliftBooked;

  /// Number of forklifts assigned (0 when none)
  final int forkliftCount;

  /// Max lift capacity per single forklift unit, in tonnes
  final double forkliftMaxCapacityTon;

  /// Combined capacity of all assigned forklifts, in tonnes
  final double forkliftTotalCapacityTon;

  const ParkingScanData({
    required super.scannedId,
    required super.displayName,
    required super.status,
    required this.licensePlate,
    required this.vehicleType,
    required this.accessDate,
    required this.accessTimeFrom,
    required this.accessTimeUntil,
    required this.accessWindow,
    required this.parkingSite,
    required this.forkliftBooked,
    required this.forkliftCount,
    required this.forkliftMaxCapacityTon,
    required this.forkliftTotalCapacityTon,
  });
}

// ─── Empties variant ──────────────────────────────────────────────────────────

class EmptiesScanData extends ScanResultEntity {
  /// e.g. "Wooden Pallet", "Metal Crate"
  final String containerType;

  /// e.g. "12"
  final int quantity;

  /// e.g. "Hall 3 · Stand 214B"
  final String currentLocation;

  /// e.g. "Temp Storage B"
  final String targetStorage;

  /// e.g. "2025-04-01"
  final String returnDeadline;

  const EmptiesScanData({
    required super.scannedId,
    required super.displayName,
    required super.status,
    required this.containerType,
    required this.quantity,
    required this.currentLocation,
    required this.targetStorage,
    required this.returnDeadline,
  });
}

enum PackageType { envelope, parcel, fragile, oversized }

enum InHandStatus {
  pending, // not yet attempted
  attempted, // tried but failed (nobody home, etc.)
  delivered, // successfully handed over
}

enum DeliveryPriority { normal, express, urgent }
