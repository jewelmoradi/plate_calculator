# AI Food Plate Calorie Estimator

**Bachelor’s Degree Project — Negin Moradi**  
**Shiraz University of Technology**

---

## Overview

**AI Food Plate Calorie Estimator** is a cross-platform mobile application built with **Flutter** that uses a vision-language model to analyze food images and support calorie and nutritional estimation.

The app allows users to:
- Capture or upload an image of their meal  
- Send it to the AI analysis API
- Receive calorie predictions and store them with timestamps  
- View their meal history through a connected Node.js & MongoDB backend  

This project demonstrates the integration of **computer vision**, **AI model development**, **backend APIs**, and **mobile development**.

---

## System Architecture

1. **Flutter Frontend:**  
   Handles UI, image capture (camera/gallery), and API communication.

2. **Flask Backend (Python):**  
   Provides the API endpoint for image analysis. The current implementation uses mock responses while the trained model is being prepared for integration and deployment.

3. **AI Model:**  
   A separately developed vision-language model is being fine-tuned and tested for food image analysis. Model experimentation is currently performed independently from the mobile application.

4. **Node.js + MongoDB Backend:**  
   Stores analyzed meal information and timestamps, and provides endpoints for fetching and managing meal history.

---

## Technologies Used

| Layer | Technology |
|-------|-------------|
| Frontend | Flutter (Dart), Image Picker, HTTP, Permission Handler |
| AI / Model Development | Python, PyTorch, Vision-Language Models, Parameter-Efficient Fine-Tuning |
| AI Backend | Python, Flask |
| Database Layer | Node.js, Express.js, MongoDB |
| Data Format | JSON, Base64 Encoded Images |
| Development | Google Colab, Android Studio |

---

## Features

- **Camera Integration** — Take a picture of your food.  
- **Gallery Upload** — Choose an existing image.  
- **AI Analysis** — Send the image to the Flask API for food image analysis.
- **Meal Logging** — Store results in MongoDB via Node.js backend.  
- **Meal History** — View previous meals with thumbnails, predictions, and timestamps.  
- **Expandable Meal View** — Tap a meal to see full details in a popup screen.  

---

## Setup & Installation

### Prerequisites
Make sure you have installed:
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Node.js](https://nodejs.org/)
- [Python 3](https://www.python.org/)
- [MongoDB](https://www.mongodb.com/try/download/community)

---

## Project Structure

<pre>plate_calculator/
├── lib/
│   ├── main.dart
│   ├── screens/
│   │   ├── camera_screen.dart
│   │   ├── gallery_screen.dart
│   │   └── history_screen.dart
│   └── services/
│       └── api_service.dart
├── model_testing/
│   ├── test_model.py
│   ├── requirements.txt
│   └── README.md
├── python_backend/
│   ├── app.py
│   └── requirements.txt
├── node_backend/
│   ├── server.js
│   ├── models/
│   ├── routes/
│   ├── package.json
│   └── package-lock.json
└── README.md
</pre>

---

## Developer

**Negin Moradi**  
Bachelor of Computer Engineering  
*Shiraz University of Technology*  

---

## Academic Project

This project was originally developed as part of my Bachelor's degree project at Shiraz University of Technology and is continuing as an ongoing academic and personal project.
