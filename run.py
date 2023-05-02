import os
import uuid
from flask import Flask, request
from img2mol.inference import *

app = Flask(__name__)

@app.route('/image_to_smiles/', methods=['POST'])
def image_to_smiles():
    image = request.files['image']
    extension = image.filename.split(".")[-1]
    file_path = os.path.abspath(str(uuid.uuid4()) + "." + extension)
    image.save(file_path)
    img2mol = Img2MolInference(model_ckpt="model/model.ckpt")
    cddd_server = CDDDRequest()
    response = img2mol(filepath=file_path, cddd_server=cddd_server)
    os.remove(file_path)
    return response['smiles']
