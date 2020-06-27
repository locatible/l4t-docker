# OpenCV 4.3.0 for NVIDIA L4T 32.4.2 + CUDA 10.2 + cuDNN 8.0 + PyTorch 1.5.0

This docker image contains the OpenCV built from [`locatible/l4t-torch-cudnn`](l4t-torch-cudnn)
, which adds a layer with the cuDNN 8.0 to the NVIDIA docker image `l4t-pytorch:r32.4.2-pth1.5-py3`.


The OpenCV is installed in `/usr/local` and an entry is entered to `/etc/profile` in
order to add the Python modules to the `PYTHONPATH` environment variable.

The CMAKE compilation is:

```
cmake \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local/ \
    -D WITH_CUDA=ON \
    -D ENABLE_FAST_MATH=1 \
    -D CUDA_FAST_MATH=1 \
    -D WITH_CUBLAS=1 \
    -D WITH_CUDA=ON \
    -D WITH_CUDNN=ON \
    -D OPENCV_DNN_CUDA=ON \
    -D WITH_CUBLAS=1 \
    -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-10.2 \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-$VERSION/modules/ \
    -D BUILD_EXAMPLES=OFF \
    -D BUILD_SHARED_LIBS=OFF \
    -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda \
    -D WITH_GTK=ON \
    -D WITH_PYTHON=ON \
    -D BUILD_NEW_PYTHON_SUPPORT=ON \
    -D BUILD_opencv_python3=ON \
    -D HAVE_opencv_python3=ON \
    -D PYTHON_DEFAULT_EXECUTABLE=/usr/bin/python3 \
    ../../opencv-$VERSION
```


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



	docker build -t locatible/l4t-torch-opencv:latest  .


## Running



	docker run --runtime nvidia --rm -it locatible/l4t-torch-opencv python3



