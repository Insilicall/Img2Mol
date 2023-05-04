import os
import uuid
from fastapi import FastAPI, File, UploadFile
from img2mol.inference import *

img2mol = Img2MolInference(model_ckpt="model/model.ckpt", local_cddd=True)
app = FastAPI()

@app.post('/image_to_smiles/')
async def image_to_smiles(image: UploadFile = File(...)):
    extension = image.filename.split(".")[-1]
    file_path = os.path.abspath(str(uuid.uuid4()) + "." + extension)
    with open(file_path, 'wb') as f:
        f.write(await image.read())
    response = img2mol(filepath=file_path)
    os.remove(file_path)
    return response['smiles']
