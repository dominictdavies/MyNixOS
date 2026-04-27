import kagglehub
import torch
import threading
from transformers import AutoProcessor, AutoModelForCausalLM, TextIteratorStreamer

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
]

if __name__ == "__main__":
    while True:
        try:
            user_input = input("You: ")
            messages.append({"role": "user", "content": user_input})

            # Process input
            text = processor.apply_chat_template(
                messages, 
                tokenize=False, 
                add_generation_prompt=True
            )
            inputs = processor(text=text, return_tensors="pt").to(model.device)

            # Setup streamer
            streamer = TextIteratorStreamer(processor.tokenizer, skip_prompt=True, skip_special_tokens=True)

            # Define generation arguments
            generation_kwargs = dict(
                **inputs,
                streamer=streamer,
                max_new_tokens=1024,
            )

            # Run generation in a separate thread
            thread = threading.Thread(target=model.generate, kwargs=generation_kwargs)
            thread.start()

            # Print tokens as they arrive
            print("Gemma: ", end="", flush=True)
            full_response = ""
            for new_text in streamer:
                print(new_text, end="", flush=True)
                full_response += new_text
            print()

            # Update history with response
            messages.append({"role": "assistant", "content": full_response})

        except KeyboardInterrupt:
            print("\nGoodbye...")
            break

        except Exception as e:
            print(f"\nAn error occurred: {e}")
            break
