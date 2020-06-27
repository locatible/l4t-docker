FROM locatible/l4t-torch-cudnn:latest

ADD FindCUDNN.cmake.patch build-opencv.sh /tmp/

RUN mkdir -p /build/third_party && cd /build  && /tmp/build-opencv.sh third_party



LABEL description="OpenCV 4.3.0 for NVIDIA L4T 32.4.2 + CUDA 10.2 + cuDNN 8.0 + PyTorch 1.5.0"



