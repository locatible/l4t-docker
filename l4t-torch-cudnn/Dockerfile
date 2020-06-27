FROM nvcr.io/nvidia/l4t-pytorch:r32.4.2-pth1.5-py3

RUN useradd -m dev && usermod -a -G video dev && apt-get update -y && apt-get upgrade -y && apt-get install python3-matplotlib -y
ENV PATH $PATH:/home/dev/.local/bin

COPY pkgs /tmp/
RUN dpkg -i /tmp/libcudnn8_8.0.0.145-1+cuda10.2_arm64.deb && dpkg -i /tmp/libcudnn8-dev_8.0.0.145-1+cuda10.2_arm64.deb && dpkg -i /tmp/libcudnn8-doc_8.0.0.145-1+cuda10.2_arm64.deb 

RUN rm -Rf /tmp/*.sh /tmp/*.deb


LABEL description="cuDNN 8.0 layer for  NVIDIA L4T 32.4.2 + CUDA 10.2 + PyTorch 1.5.0"

