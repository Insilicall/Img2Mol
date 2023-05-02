from flask import Flask, jsonify, request
from img2mol.inference import *
import os

app = Flask(__name__)

@app.route('/image_to_smiles/', methods=['POST'])
def image_to_smiles():
    file = request.files['file']
    filepath = os.path.abspath(file.filename)
    file.save(filepath)
    device = "cpu"
    img2mol = Img2MolInference(model_ckpt="model/model.ckpt", device=device)
    cddd_server = CDDDRequest()
    res = img2mol(filepath=filepath, cddd_server=cddd_server)
    return jsonify(res['smiles'])
