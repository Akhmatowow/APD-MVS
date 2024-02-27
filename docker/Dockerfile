# Официальный образ NVIDIA CUDA как базовый
FROM nvidia/cuda:11.7.1-cudnn8-devel-ubuntu22.04

# awoid public GPG key error
# RUN rm /etc/apt/sources.list.d/cuda.list \
#     && rm /etc/apt/sources.list.d/nvidia-ml.list \
#     && apt-key del 7fa2af80 \
#     && apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub \
#     && apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub

# Install the required packages for cv 
RUN DEBIAN_FRONTEND=noninteractive apt-get clean \
 && DEBIAN_FRONTEND=noninteractive apt-get update -qq \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ffmpeg libsm6 libxext6 git ninja-build libglib2.0-0 libsm6 libxrender-dev libxext6 \
    make \
    cmake \
    git \
    wget \
    curl \
    libeigen3-dev \
    libgmp-dev \
    libgmpxx4ldbl \
    libmpfr-dev \
    libboost-dev \
    libboost-thread-dev \
    libtbb-dev \
    build-essential \
    libopencv-dev \
    && rm -rf /var/lib/apt/lists/*

    # Install Miniconda
RUN curl -so /miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
 && chmod +x /miniconda.sh \
 && /miniconda.sh -b -p /miniconda \
 && rm /miniconda.sh

ENV PATH=/miniconda/bin:$PATH

# Create a Python 3.8 environment
RUN conda install -y conda-build \
 && conda create -y --name apd_mvs python=3.8 \
 && conda clean -ya


#  && conda activate ngdf


SHELL ["conda", "run", "--no-capture-output", "-n", "apd_mvs", "/bin/bash", "-c"]

ENV CONDA_DEFAULT_ENV=apd_mvs
ENV CONDA_PREFIX=/miniconda/envs/$CONDA_DEFAULT_ENV
ENV PATH=$CONDA_PREFIX/bin:$PATH
ENV CONDA_AUTO_UPDATE_CONDA=false

# Установите рабочий каталог
WORKDIR /workspace