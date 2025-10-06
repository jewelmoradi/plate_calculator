# AI Food Plate Calorie Estimator

**Bachelor’s Degree Project — Negin Moradi**  
**Shiraz University of Technology**

---

## Overview

**AI Food Plate Calorie Estimator** is a cross-platform mobile application built with **Flutter** that uses **machine learning** to estimate the calories of a food item from a photo.  

The app allows users to:
- Capture or upload an image of their meal  
- Send it to a trained AI model (Flask backend) for analysis  
- Receive calorie predictions and store them with timestamps  
- View their meal history through a connected Node.js & MongoDB backend  

This project demonstrates the integration of **computer vision**, **cloud APIs**, and **mobile development**, aiming to simplify calorie tracking for everyday users.

---

## System Architecture

1. **Flutter Frontend:**  
   Handles UI, image capture (camera/gallery), and API communication.  
2. **Flask Backend (Python):**  
   Hosts the trained food recognition/calorie estimation model.  
   *(Currently returns mock predictions until the final model is deployed.)*  
3. **Node.js + MongoDB Backend:**  
   Stores each analyzed meal (image, AI response, timestamp).  
   Provides endpoints for fetching and managing user meal history.

---

## Technologies Used

| Layer | Technology |
|-------|-------------|
| Frontend | Flutter (Dart), Image Picker, HTTP, Permission Handler |
| AI Backend | Python, Flask, TensorFlow / PyTorch (for the final model) |
| Database Layer | Node.js, Express.js, MongoDB |
| Data Format | JSON, Base64 Encoded Images |
| Hosting | Localhost during development (Android emulator) |

---

## Features

- **Camera Integration** — Take a picture of your food.  
- **Gallery Upload** — Choose an existing image.  
- **AI Prediction** — Send the image to the Flask API for calorie estimation.  
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
│   │   ├── history_screen.dart
│   └── services/
│       └── api_service.dart
├── backend-python/
│   └── app.py
├── backend-node/
│   ├── server.js
│   └── models/
│       └── meal.js
└── README.md
</pre>

---

## Developer

**Negin Moradi**  
Bachelor of Computer Engineering  
*Shiraz University of Technology*  

---

## License

This project is developed for academic purposes as part of a Bachelor's degree project.
