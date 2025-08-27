# Iranian Food Vision Model - Testing

This directory contains the testing script for my fine-tuned Llama Vision 3.2 11B model trained to recognize Persian/Iranian food dishes.

## 📋 Overview

The model was fine-tuned using Unsloth on Google Colab with a custom dataset of Iranian food images and captions. This testing script allows you to load the trained model locally and test it on new images.

## 🛠️ Setup

### Prerequisites
- Python 3.8 or higher
- At least 8GB RAM (16GB recommended)
- GPU with 8GB VRAM (optional but recommended for faster inference)

## 📊 Model Performance

### Training Details
- **Base Model:** Llama Vision 3.2 11B
- **Training Method:** LoRA (Low-Rank Adaptation)
- **Dataset:** Custom Iranian food images with Persian captions
- **Training Platform:** Google Colab with Unsloth
- **Adapter Size:** ~256MB

### Expected Outputs
The model can identify various Persian dishes including:
- Rice dishes (Polo)
- Stews (Khoreshts)
- Grilled items (Kebabs)
- Traditional sweets and desserts
- Regional specialties

**Happy Testing! 🍛✨**