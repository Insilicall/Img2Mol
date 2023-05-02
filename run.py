import torch
from img2mol.inference import *
from IPython.display import display
from PIL import Image
import os
os.listdir("model/")

device = "cpu"
img2mol = Img2MolInference(model_ckpt="model/model.ckpt", device=device)
cddd_server = CDDDRequest()

os.listdir("examples/")
res = img2mol(filepath="examples/digital_example1.png", cddd_server=cddd_server)
print(res['smiles'])