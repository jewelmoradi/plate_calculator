from flask import Flask, request, jsonify
from PIL import Image
import io
import random

app = Flask(__name__)


# mock captions that simulate a vision model's predictions
captions = [
    "A plate with assorted vegetables",
    "A bowl of salad with tomatoes and cucumbers",
    "Grilled chicken with rice and beans",
    "A blurry image of food",
    "Empty plate",
    "Image too dark to detect"
]


# dummy function to check if the image is analyzed
def analyze_image(image):
    if image.size[0] > 500:
        return "Large image"
    else:
        return "Small image"


@app.route('/analyze', methods=['POST'])
def analyze():
    if 'image' not in request.files:
        return jsonify({'error': 'No image uploaded'}), 400

    image_file = request.files['image']
    image_bytes = image_file.read()

    try:
        image = Image.open(io.BytesIO(image_bytes))
        image.verify()  # checking to make sure it's an image
    except Exception as e:
        return jsonify({'error': 'Invalid image file'}), 400

    prediction = random.choice(captions)

    return jsonify({'prediction': prediction})


if __name__ == '__main__':
    app.run(debug=True)
