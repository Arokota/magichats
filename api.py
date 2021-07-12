from typing import Optional
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from python_terraform import *


class MHat(BaseModel):
    region: str
    c2_server: str
    num_of_instances: int
    
app = FastAPI()


#Added this to get rid of the CORS errors blocking cross origin traffic
#https://fastapi.tiangolo.com/tutorial/middleware/
#https://fastapi.tiangolo.com/tutorial/cors/
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_headers=["*"],
)

@app.post("/api/{mhat_id}")
def CreateMHat(mhat_id: str, mhat_request: MHat):
    t = Terraform(working_dir='modules/http-redirector')
    t.init()
    mhat_request_dict = mhat_request.dict()
    #mhat_request_dict.update({"mhat_id": mhat_id})
    # UPDATE THE ABOVE IN TF DOC TO NAME NODES BASED ON MHAT_ID
    return_code, stdout, stderr = t.apply(**{"skip_plan": True, "auto_approve": IsFlagged, "capture_output": True}, variables=mhat_request_dict)

    if return_code == 0:
        mhat_response_dict = {"Status": "Success"}
        script_output = t.output(json=True)
        i = 0
        for ip in script_output['public-ip']['value']:
            mhat_response_dict.update({f"mhat_ip{i}": ip})
            i = i + 1
    else:
        mhat_response_dict = {"Status": "Failure"}

    return mhat_response_dict

@app.delete("/api/{mhat_id}")
def DeleteMHat(mhat_id: str, mhat_request: MHat):
    t = Terraform(working_dir='modules/http-redirector')
    t.init()
    mhat_request_dict = mhat_request.dict()
    #mhat_request_dict.update({"mhat_id": mhat_id})
    # UPDATE THE ABOVE IN TF DOC TO NAME NODES BASED ON MHAT_ID
    return_code, stdout, stderr = t.apply(**{"skip_plan": True, "auto_approve": IsFlagged, "capture_output": True, "destroy": True}, variables=mhat_request_dict)

    if return_code == 0:
        mhat_response_dict = {"Status": "Success"}
    else:
        mhat_response_dict = {"Status": "Failure"}

    return mhat_response_dict

@app.get("/api/{mhat_id}")
def UpdateMHat(mhat_id: str):
    t = Terraform(working_dir="modules/http-redirector")
    t.init()
    script_output = t.output(json=True)
    #mhat_response_dict = script_output
    if script_output:
        mhat_response_dict = {"Status": "Success"}
        
    else:
        mhat_response_dict = {"Status": "Failure"}

    return mhat_response_dict