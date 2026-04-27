import kagglehub
import torch
from transformers import AutoProcessor, AutoModelForCausalLM

MODEL_PATH = kagglehub.model_download("google/gemma-4/transformers/gemma-4-26b-a4b-it")

# Load model
processor = AutoProcessor.from_pretrained(MODEL_PATH)
model = AutoModelForCausalLM.from_pretrained(
    MODEL_PATH,
    dtype=torch.bfloat16,
    device_map="auto"
)

# Prompt
messages = [
    {"role": "system", "content": "You are Gemma, a helpful assistant that answers all messages concisely."},
    {"role": "user", "content": "Hello! Introduce yourself please."},
]

if __name__ == "__main__":
    while True:
        try:
            # Process input
            text = processor.apply_chat_template(
                messages, 
                tokenize=False, 
                add_generation_prompt=True, 
                enable_thinking=False
            )
            inputs = processor(text=text, return_tensors="pt").to(model.device)
            input_len = inputs["input_ids"].shape[-1]

            # Generate output
            outputs = model.generate(**inputs, max_new_tokens=1024)
            response = processor.decode(outputs[0][input_len:], skip_special_tokens=True)

            # Parse thinking
            processor.parse_response(response)
            print(f"Gemma: {response}")

            # Next message
            messages.append({"role": "user", "content": input("Message: ")})

        except KeyboardInterrupt:
            print("Goodbye...")
            break
