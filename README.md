# CourtBook - Flutter Sports Facility Booking App

A Flutter application for booking sports facilities and courts. Users can browse facilities, select
courts, choose time slots, and manage their bookings.

## How to Run

1. **Install dependencies:**
   "flutter pub get"

2. **Run the app:**
   "flutter run"

## Architecture Overview

The app follows a clean architecture pattern with feature-based organization:

```
lib/
├── core/                   # Shared utilities and configuration
│   ├── common/             # Models and widgets
│   ├── config/              # App router, theme, responsive config
│   ├── errors/             # handling exceptions
│   ├── services/           # Network service, storage service
│   ├── helpers/            # Date helpers, snackbar helpers
│   └── utils/              # Colors, text styles, strings
├── features/               # Feature modules
│   ├── home/               # Home screen and facility listing
│   ├── facility/           # Facility details and booking flow
│   └── bookings/           # Booking management
└── main.dart               # App entry point
```

**Architecture Diagram:**

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Presentation  │    │   Business      │    │      Data       │
│                 │    │                 │    │                 │
│  - Screens      │◄──►│  - Providers    │◄──►│  - Services     │
│  - Widgets      │    │  - Models       │    │  - JSON Assets  │
│  - UI Logic     │    │  - State Mgmt   │    │  - Persistence  │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## State Management Choice

**Provider Pattern** was chosen for state management because:

- **Simplicity**: Less boilerplate than BLoC for this project scope
- **Performance**: Efficient rebuilds with Consumer widgets and ChangeNotifier
- **Familiarity**: Faster development iteration during the assignment timeframe
- **Suitable Scale**: Perfect for the app's complexity level

The app uses `MultiProvider` with `ChangeNotifierProvider` for:

- `FacilityProvider`: Manages facility data, search, and filtering
- `BookingProvider`: Handles booking state, time slot generation, and conflict detection

## Persistence Choice

**SharedPreferences** was selected for data persistence because:

- **Local Storage**: All booking data is stored locally on device
- **JSON Serialization**: Bookings are serialized to JSON strings for storage
- **Simplicity**: No database setup required for this demo application
- **Cross-Platform**: Works consistently on both Android and iOS
- **Lightweight**: Suitable for the expected data volume

**Data Structure:**

- Bookings are stored as a JSON array in SharedPreferences
- Each booking includes: ID, facility/court info, date, time slots, and price
- Real-time conflict detection against stored bookings

## Booking Logic: Overlap Detection Algorithm

The booking system implements a robust time slot overlap detection algorithm:

### Data Structure

```dart
class Booking {
  final String id;
  final String facilityId;
  final String courtId;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
// ... other fields
}
```

### Overlap Detection Algorithm

**Core Logic** (in `BookingService.hasTimeSlotConflict()`):

```dart
// Convert times to minutes for easier comparison
final startMinutes = startTime.hour * 60 + startTime.minute;
final endMinutes = startMinutes + slotMinutes;

for (
final booking in existingBookings) {
final bookingStartMinutes = booking.startTime.hour * 60 + booking.startTime.minute;
final bookingEndMinutes = booking.endTime.hour * 60 + booking.endTime.minute;

// Overlap condition: Start < ExistingEnd AND ExistingStart < End
if (startMinutes < bookingEndMinutes && bookingStartMinutes < endMinutes) {
return true; // Conflict detected
}
}
```

### Why This Algorithm?

1. **Mathematical Precision**: Uses minute-based calculations for accurate time comparisons
2. **Efficient**: O(n) complexity where n = number of existing bookings for the court/date
3. **Comprehensive**: Detects all types of overlaps:
    - Partial overlaps (new booking starts during existing)
    - Complete overlaps (new booking encompasses existing)
    - Edge overlaps (new booking exactly touches existing)
4. **Real-time**: Validates conflicts before allowing bookings
5. **Scalable**: Works efficiently even with many bookings

### Time Slot Generation

- Generates 30-minute intervals from facility open to close time
- Filters out conflicting slots using the overlap algorithm
- Updates available slots dynamically when bookings are created/cancelled

## Future Improvements

If given more time, the following enhancements would be implemented:

- Unit tests for business logic
- Widget tests for UI components
- Integration tests for booking flow
- Performance testing and optimization
-

---

## Technical Stack

- **Framework**: Flutter 3.7.2+
- **State Management**: Provider + ChangeNotifier
- **Navigation**: GoRouter
- **Persistence**: SharedPreferences
- **Styling**: Custom theme system with responsive design
- **Dependencies**:
    - `provider`: State management
    - `go_router`: Navigation
    - `shared_preferences`: Local storage
    - `cached_network_image`: Image loading
    - `intl`: Date/time formatting
    - `uuid`: Unique ID generation

## Project Structure

The app follows Flutter best practices with:

- Feature-based folder organization
- Separation of concerns (UI, business logic, data)
- Reusable widgets and utilities
- Consistent naming conventions
- Responsive design implementation
