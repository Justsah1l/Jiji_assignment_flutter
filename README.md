# Learn with Jiji - Flutter Hiring Assignment

This repository contains the Flutter implementation for the "Learn with Jiji" landing screen, as part of the VeidaLabs Hiring Assignment.

## About the Screen

The screen implements the "Jiji" chatbot interface, designed to be a personal AI learning companion.
- **Header**: Features the "Jiji" branding and "Your AI Friend" subtitle.
- **Avatar**: A central avatar representing the AI persona.
- **Search/Input Area**: A floating entry field where users can ask questions (e.g., "Explain RAG").
- **Dynamic Response**:
    - **Interactive State**: The response card only appears after the user sends a query.
    - **RAG Demo**: If the user asks about "RAG", the app displays a specific explanation with PowerPoint and Video attachment cards.
    - **YouTube Integration**: For other queries, it dynamically generates a "What is [Query]" attachment that links to a real YouTube search.
    - **Generic Placeholder**: Includes Lorem Ipsum text for generic queries to simulate a full textual response.


- **Framework**: Flutter (Dart)
- **State Management**: `StatefulWidget` (Ephemeral state).
    - `setState` is used to manage the visibility of the response card and the content of the text fields. For a single-screen prototype, this is the most efficient and readable approach without adding unnecessary boilerplate.
- **External Packages**:
    - `url_launcher`: Used to securely open external links (like the YouTube search) in the system browser.
- **Security Awareness**:
    - `LaunchMode.externalApplication` is used when launching URLs to ensure the user is taken to their trusted browser rather than an in-app webview which can be less secure for general browsing.
    - Basic input validation ensures empty queries are not processed.

## How AI Tools Were Used

This project was reviewed with the assistance of Antigravity.

- **Verification**: The AI provided walkthroughs and checklist management to ensure all requirements (headers, search logic, attachments) were met within the time limit.


## How to Run

1.  **Clone the repository**.
2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Run the app**:
    ```bash
    flutter run
    ```
