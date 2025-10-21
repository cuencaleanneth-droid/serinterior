# Ser Interior: Blueprint

## Overview

Ser Interior is a mobile application that connects people with holistic therapists, psychologists, and coaches. The app provides a platform for users to find the right professional for their needs, book sessions, and communicate securely.

## Style, Design, and Features

### Initial Version

- **Objective:** Create a visually appealing and intuitive user interface that is mobile responsive and follows modern design guidelines.
- **Visually Balanced Layout:** The app uses clean spacing, modern components, and polished styles to create a user-friendly experience.
- **Color Palette:** A vibrant and energetic color palette with a wide range of hues and concentrations to create a unique look and feel.
- **Typography:** Expressive and relevant typography with an emphasis on font sizes to ease understanding, including hero text, section headlines, and keywords in paragraphs.
- **Iconography:** Modern and interactive iconography to enhance user understanding and logical navigation of the app.
- **Interactivity:** Interactive elements such as buttons, text fields, and navigation bars have a "glow" effect created by a shadow and elegant use of color.
- **Images:** Placeholder images are used for therapist profiles.

### Navigation

- **`main.dart`:** The main entry point of the app, which sets up the main app widget and the bottom navigation bar.
- **`barra_navegacion.dart`:** A custom bottom navigation bar with icons for "Inicio," "Terapeutas," "Reservas," and "Chat."
- **`inicio.dart`:** The home screen of the app, featuring a welcome message, a call to action to find a therapist, and a section with testimonials.
- **`terapeutas.dart`:** A screen that allows users to search for therapists by name or specialty.
- **`reservas.dart`:** A placeholder screen for booking sessions with therapists.
- **`chat.dart`:** A placeholder screen for secure communication with therapists.

## Current Change: Removing the "Blog de Bienestar"

- **Objective:** Remove the "Blog de Bienestar" feature card from the main screen.
- **`lib/tarjetas.dart`:** Removed the `Feature` widget with the title 'Blog de Bienestar' from the `_features` list.
