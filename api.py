from typing import Optional
from fastapi import FastAPI
from pydantic import BaseModel
from python_terraform import *


class MHat(BaseModel):
    region: str
    c2_server: str
    num_of_instances: int
    
app = FastAPI()

@app.post("/http-redirector/{mhat_id}")
def CreateMHat(mhat_id: str, mhat_request: MHat):
    t = Terraform(working_dir='modules/http-redirector')
    t.init()
    mhat_request_dict = mhat_request.dict()
    #mhat_request_dict.update({"mhat_id": mhat_id})
    # UPDATE THE ABOVE IN TF DOC TO NAME NODES BASED ON MHAT_ID
    return_code, stdout, stderr = t.apply(**{"skip_plan": True, "auto_approve": IsFlagged, "capture_output": True}, variables=mhat_request_dict)

    if return_code == 0:
        mhat_response_dict = {"Success": True}
        script_output = t.output(json=True)
        i = 0
        for ip in script_output['public-ip']['value']:
            mhat_response_dict.update({f"mhat_ip{i}": ip})
            i = i + 1
    else:
        mhat_response_dict = {"Success": False}

    return mhat_response_dict

@app.delete("/http-redirector/{mhat_id}")
def DeleteMHat(mhat_id: str, mhat_request: MHat):
    t = Terraform(working_dir='modules/http-redirector')
    t.init()
    mhat_request_dict = mhat_request.dict()
    #mhat_request_dict.update({"mhat_id": mhat_id})
    # UPDATE THE ABOVE IN TF DOC TO NAME NODES BASED ON MHAT_ID
    return_code, stdout, stderr = t.apply(**{"skip_plan": True, "auto_approve": IsFlagged, "capture_output": True, "destroy": True}, variables=mhat_request_dict)

    if return_code == 0:
        mhat_response_dict = {"Success": True}
    else:
        mhat_response_dict = {"Success": False}

    return mhat_response_dict

@app.get("/http-redirector/{mhat_id}")
def UpdateMHat(mhat_id: str):
    t = Terraform(working_dir="modules/http-redirector")
    t.init()
    script_output = t.output(json=True)
    #mhat_response_dict = script_output
    if script_output:
        mhat_response_dict = {"Success": True}
        
    else:
        mhat_response_dict = {"Success": False}

    return mhat_response_dict