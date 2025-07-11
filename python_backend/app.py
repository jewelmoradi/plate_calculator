from flask import Flask, request, jsonify
from PIL import Image
import io

app = Flask(__name__)


@app.route('/analyze', methods=['POST'])
def analyze():
    if 'image' not in request.files:
        return jsonify({'error': 'No image uploaded'}), 400

    image_file = request.files['image']
    image_bytes = image_file.read()
    image = Image.open(io.BytesIO(image_bytes))

    # --- Your AI model would go here ---
    result = {'analyze': 'dummy result'}  # Temporary response

    return jsonify(result)


if __name__ == '__main__':
    app.run(debug=True)
