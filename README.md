# YassirTask – iOS Rick & Morty Character Explorer

An iOS application built as part of a take-home test, using **UIKit + MVVM + Combine** for the list and **SwiftUI** for character details.  
The app consumes the [Rick and Morty API](https://rickandmortyapi.com/) to display characters with support for filtering, pagination, and detail presentation.

---

## ✨ Features

- ✅ Fetch and display characters from the Rick & Morty API
- ✅ Infinite scrolling with pagination
- ✅ Filter characters by status: **All, Alive, Dead, Unknown**
- ✅ Character detail screen with:
  - Name
  - Image
  - Species
  - Status
  - Gender
- ✅ Error handling and loading state
- ✅ Unit tests for the ViewModel and service layer
- ✅ Modern UIKit styling with `UIButton.Configuration`
- ✅ Mix of UIKit (list) and SwiftUI (detail) for best of both worlds

---

## 📱 Screenshots

| Characters List | Filter Buttons | Character Details |
|-----------------|----------------|-------------------|
|<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-27 at 14 19 21" src="https://github.com/user-attachments/assets/be9fe5a0-db66-4aec-8fea-d3ab3134c9b5" /> | <img width="385" height="174" alt="Screenshot 2025-08-27 at 2 19 47 PM" src="https://github.com/user-attachments/assets/9ca82f59-2631-42d5-b0a3-b6c4dcc902c2" /> | <img width="1206" height="2622" alt="simulator_screenshot_F7D6159F-D405-4E44-819C-A4553B05E94F" src="https://github.com/user-attachments/assets/5e673809-4d73-4d88-a5af-a5f78b2a1699" /> |

*(Add screenshots in a `docs/screenshots/` folder for best presentation.)*

---

## 🛠️ Tech Stack

- **Language:** Swift 5
- **Architecture:** MVVM
- **UI Frameworks:** UIKit (list), SwiftUI (details)
- **Asynchronous programming:** Combine
- **Networking:** URLSession + JSONDecoder
- **Testing:** XCTest + Combine
- **Dependency Management:** None (lightweight, no external libraries)

---

## 🚀 Getting Started

### Prerequisites
- macOS (latest recommended)
- Xcode 15+
- iOS 15+ (minimum deployment target)

### Build & Run
1. Clone the repository:
   ```bash
   git clone https://github.com/ahmed-salaah/YassirTask.git
   cd YassirTask
