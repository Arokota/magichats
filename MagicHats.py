from python_terraform import *
import os
import typer as typer
import json
from datetime import datetime

app = typer.Typer()

@app.command()
def create(region: str = typer.Argument("")):
    t = Terraform(working_dir='modules/http-redirector')
    t.init()

    vars = {
        #'target':f'module.{target}',
        'region': region,
        'c2_server':'3.135.62.18',
        'num_of_instances':'2',
        #'var_file':'magichats.tfvars'
    }
    return_code, stdout, stderr = t.apply(**{"skip_plan": True, "auto_approve": IsFlagged, "capture_output": True}, variables=vars)
    print(stdout)
    if return_code == 0:
        script_output = t.output(json=True)
        print("[+] Success!")
        for ip in script_output['public-ip']['value']:
            typer.secho(f"{ip}---[Redirecting]------>{vars['c2_server']}", fg=typer.colors.GREEN)
    else:
        err_file = datetime.now().strftime('mh_errlog_%H_%M_%d_%m_%Y.txt')
        with open(err_file, 'w') as out:
            out.write(stderr)
        typer.secho(f"[-] Failed to create instances! ReturnCode: {return_code}", fg=typer.colors.RED)
        typer.secho(f"[-] Error log written to {err_file}", fg=typer.colors.RED)
    
    #Create HTTP Redirector via http-redirector module
    #terraform apply --target=module.$module -var region=$region -var c2_server=$c2_server -var num_of_instances=$count -var-file=magichats.tfvars -auto-approve

@app.command()
def destroy(region: str):
    vars = {
        #'target':f'module.{target}',
        'region':region,
        'c2_server':'3.135.62.18',
        'num_of_instances':'2',
        #'var_file':'magichats.tfvars'
    }

    t = Terraform(working_dir='modules/http-redirector')
    t.init()
    typer.secho("[*] Going down for destruction...")
    script_output = t.output(json=True)
    if script_output:
        print("Tearing down the following nodes: ")
        for ip in script_output['public-ip']['value']:
                typer.secho(f"{ip}---[Stopping Redirecting]------>{vars['c2_server']}", fg=typer.colors.GREEN)
        t.apply(**{"skip_plan": True, "auto_approve": IsFlagged, "capture_output": True, "destroy": True},variables=vars)
        typer.secho("Done.", fg=typer.colors.GREEN)
    else:
        typer.secho("[-] No servers detected.", fg=typer.colors.RED)
        exit()

if __name__ == "__main__":
    app()