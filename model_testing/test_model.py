import torch
from transformers import MllamaForConditionalGeneration, AutoProcessor, BitsAndBytesConfig
from peft import PeftModel
from PIL import Image
from tkinter import filedialog
import tkinter as tk


def load_model():
    """Function to load the trained model"""

    base_model_path = "path/to/model"
    adapter_path = "path/to/adapter"

    quantization_config = BitsAndBytesConfig(
        load_in_4bit=True,
        bnb_4bit_compute_dtype=torch.float16,
        bnb_4bit_quant_type="nf4"
    )

    base_model, processor = None, None

    try:
        base_model = MllamaForConditionalGeneration.from_pretrained(
            base_model_path,
            torch_dtype=torch.float16,
            device_map="cpu",  # CPU since no GPU
            quantization_config=quantization_config,
            low_cpu_mem_usage=True,
            local_files_only=True
        )

        processor = AutoProcessor.from_pretrained(
            base_model_path,
            local_files_only=True
        )

    except Exception as e:
        print(f"Error loading base model: {e}")

    try:
        model = PeftModel.from_pretrained(base_model, adapter_path)
        print("Adapter loaded successfully!")

    except Exception as e:
        print(f"Error loading adapter: {e}")
        return None, None

    return model, processor


def select_image():
    """Opening a file dialog to select an image"""

    root = tk.Tk()
    root.withdraw()  # Hide the main window

    image_path = filedialog.askopenfilename(
        title="Select an image file",
        filetypes=[
            ("Image files", "*.jpg *.jpeg *.png *.bmp *.gif *.tiff"),
            ("All files", "*.*")
        ]
    )

    root.destroy()
    return image_path


def test_model(model, processor, image_path, question="Analyze the food in this picture."):
    """Testing the model on an image"""

    image = Image.open(image_path)  # Loading image

    # Ensure image is in RGB format
    if image.mode != 'RGB':
        image = image.convert('RGB')

    messages = [
        {
            "role": "user",
            "content": [
                {"type": "image"},
                {"type": "text", "text": question}
            ]
        }
    ]

    input_text = processor.apply_chat_template(messages, add_generation_prompt=True)
    inputs = processor(image, input_text, return_tensors="pt")

    # Move to same device as model
    if hasattr(model, 'device'):
        inputs = {k: v.to(model.device) if isinstance(v, torch.Tensor) else v for k, v in inputs.items()}

    print("Generating response...")
    with torch.no_grad():
        outputs = model.generate(
            **inputs,
            max_new_tokens=512,
            do_sample=True,
            temperature=0.7,
            pad_token_id=processor.tokenizer.eos_token_id if hasattr(processor, 'tokenizer') else None
        )

    response = processor.decode(outputs[0], skip_special_tokens=True)
    assistant_response = response.split("assistant\n")[-1] if "assistant\n" in response else response

    return assistant_response


def main():
    model, processor = load_model()

    if model is None or processor is None:
        print("Model failed to load.")
        return

    while True:
        print("\nOptions:")
        print("1. Select an image file")
        print("2. Exit")

        choice = input("\nChoose an option: ").strip()

        if choice == "1":
            print("Opening file dialog...")
            image_path = select_image()
            if not image_path:
                print("No image selected.")
                continue

        elif choice == "2":
            print("Goodbye!")
            break

        else:
            print("Invalid choice.")
            continue

        question = "Analyze the food in this picture."

        try:
            result = test_model(model, processor, image_path, question)

            print("Model response:")
            print(result)
            print("-" * 40)

        except Exception as e:
            print(f"Error during testing: {e}")


if __name__ == "__main__":
    main()
