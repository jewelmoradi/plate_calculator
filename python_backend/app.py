from flask import Flask, request, jsonify
from PIL import Image
import io

app = Flask(__name__)


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
    image = Image.open(io.BytesIO(image_bytes))

    prediction = analyze_image(image)

    return jsonify({'prediction': prediction})


if __name__ == '__main__':
    app.run(debug=True)
