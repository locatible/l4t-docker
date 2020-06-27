# cuDNN 8.0 layer for  NVIDIA L4T 32.4.2 + CUDA 10.2 + PyTorch 1.5.0

This docker image adds a layer with the cuDNN 8.0 to the NVIDIA docker image `l4t-pytorch:r32.4.2-pth1.5-py3`.



## Requirements


### Disable NVIDIA runtime 
Disable the nvidia runtime for this build.

The `/etc/docker/daemon.json` should look like:

```
{
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
         } 
    }
}
```

If you make some changes in that file, please restart docker `sudo systemctl restart docker`.


### Copy the `.deb.` packages

Place the `.deb` packages in the `pkgs` folder. You can get them using JetPack 4.4 download feature.

The required files are:

+ `pkgs/libcudnn8_8.0.0.145-1+cuda10.2_arm64.deb`
+ `pkgs/libcudnn8-dev_8.0.0.145-1+cuda10.2_arm64.deb` 
+ `pkgs/libcudnn8-doc_8.0.0.145-1+cuda10.2_arm64.deb`


## Building



	docker build -t locatible/l4t-torch-cudnn:latest  .



## Running

After the build please enable the nvidia runtime.


```
{
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
         }
    },
    "default-runtime": "nvidia" 
}
```



	docker run --runtime nvidia --rm -it locatible/l4t-torch-cudnn python3


## Testing

With the python3 console, run the following:

```
import torch
torch.cuda.is_available()
```

The answer must be `True`

