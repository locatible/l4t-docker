# Jupyter Notebooks 2.1.5 with OpenCV 4.3.0 and PyTorch 1.5.0 (CUDA and cuDNN) enabled

This docker image exposes the port `8888` with access to a jupyter notebook with 
[OpenCV 4.3.0](l4t-torch-opencv) and PyTorch 1.5.0 provided by 
[NVIDIA L4T PyTorch](https://ngc.nvidia.com/catalog/containers/nvidia:l4t-pytorch)


## Requirements


In order to build OpenCV the CUDA libs must be loaded, so we need the `nvidia` runtime defined as default.

The `/etc/docker/daemon.json` should look like:

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

If you make some changes in that file, please restart docker `sudo systemctl restart docker`.



## Building



	docker build -t locatible/l4t-torch-cv-jupyter:latest  .


## Running


It's recommended to user a local volume to bind the notebooks. The docker `VOLUME` path is
`/home/dev/notebooks`. So, please use `--volume <LocalAbsolutePath>:/home/dev/notebooks` so
you won't loose the notebooks when the context is recreated.


Also, map the port `8888` locally, eg: `--publish 8888:8888`. 

Additinally, use the `--hostname <ip>`  to facilitate the access to the notebook when it starts


	docker run --runtime nvidia --rm -it \
		--volume /path/to/notebooks:/home/dev/notebooks \
		--publish 8888:8888 \
		--hostname 10.0.0.111 \
 		locatible/l4t-torch-cv-jupyter



## Testing

The command above will print the access token in the logs, so please click the link 
(make sure the IP is correct)


The log will look like


```
[W 10:44:37.044 NotebookApp] No web browser found: could not locate runnable browser.
[C 10:44:37.045 NotebookApp] 
    
    To access the notebook, open this file in a browser:
        file:///home/dev/.local/share/jupyter/runtime/nbserver-1-open.html
    Or copy and paste one of these URLs:
        http://1d8f7567177f:8888/?token=28962...d70570
     or http://127.0.0.1:8888/?token=28962...d70570

```


## Running as Daemon

If you prefer, you can run the jupyter as daemon by adding the `--detach` to the run command. 
In this case, it's recommended to also bind the directory `/home/dev/.local/` to a folder in 
the host, so it will be persisted.




        docker run --runtime nvidia --rm -it \
		--detach \
                --volume /path/to/notebooks:/home/dev/notebooks \
		--volume /path/to/.local:/home/dev/.local \
                --publish 8888:8888 \
                --hostname 10.0.0.111 \
                locatible/l4t-torch-cv-jupyter



To get the token, please see the file `.local/share/jupyter/runtime/nbserver-1.json`.


Browse to `http://<ip>:8888/` and provide the token.
