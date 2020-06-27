
if [ $# -ne 1 ]
then
  echo "./build-opencv.sh <workdir>"
  exit 1
fi

if [ ! -d $1 ]
then
  echo "Not a directory <$1>"
  exit 1
fi

WORKDIR=$1
VERSION=4.3.0
cd ${WORKDIR}

sudo apt install build-essential libgtk2.0-dev python3-pip -y
pip3 install --upgrade pip
pip3 install numpy

if [ ! -d opencv_contrib-$VERSION ]
then
  git clone -b ${VERSION} https://github.com/opencv/opencv_contrib.git opencv_contrib-$VERSION
fi

if [ ! -d opencv-$VERSION ]
then
  git clone -b ${VERSION} https://github.com/opencv/opencv.git opencv-$VERSION
fi


export PATH=/usr/local/cuda-10.2/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-10.2/lib64:$LD_LIBRARY_PATH

sudo apt install -y build-essential cmake unzip pkg-config \
  libjpeg-dev libpng-dev libtiff-dev libavcodec-dev libavformat-dev libswscale-dev \
  libv4l-dev libxvidcore-dev libx264-dev libgtk-3-dev \
  libatlas-base-dev gfortran \
  python3-dev

mkdir -p build/opencv-${VERSION}
cd build/opencv-${VERSION}


export CUDNN_INCLUDE_DIR=/usr/include
patch ../../opencv-$VERSION/cmake/FindCUDNN.cmake < /tmp/FindCUDNN.cmake.patch
cat ../../opencv-$VERSION/cmake/FindCUDNN.cmake

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


echo "Press any key to proceed or ctrl+c to abort ..."
read
make -j$(nproc)
make install
