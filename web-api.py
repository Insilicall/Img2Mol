import os
import uuid
# import schedule
# import time
from fastapi import FastAPI, File, UploadFile
from img2mol.inference import *

model_was_loaded = False
model = None
app = FastAPI()

@app.post('/image_to_smiles/')
async def image_to_smiles(image: UploadFile = File(...)):
    extension = image.filename.split(".")[-1]
    file_path = os.path.abspath(str(uuid.uuid4()) + "." + extension)
    with open(file_path, 'wb') as f:
        f.write(await image.read())
    img2mol = get_model()
    response = img2mol(filepath=file_path)
    os.remove(file_path)
    return response['smiles']

def get_model():
    if model_was_loaded == False:
        model = Img2MolInference(model_ckpt="model/model.ckpt", local_cddd=True)
        model_was_loaded = True
        print("model_was_loaded")
    return model

# def deallocate_memory():
#     print("Restarting app...")

# schedule.every(1).minutes.do(deallocate_memory)
# while True:
#     schedule.run_pending()
#     time.sleep(1)