#FROM nvcr.io/nvidia/pytorch:20.03-py3
FROM nvcr.io/nvidia/pytorch:20.11-py3

MAINTAINER Tobeta <tobeta2012@gmail.com>
RUN echo "now building..."

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN python3 -m pip install --upgrade pip

RUN apt-get install -y --no-install-recommends \
        libgeos-dev\
        libgl1-mesa-dev\
        libyaml-dev\
        locales

ENV PATH=/usr/local/cuda/bin/:$PATH
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64/:$LD_LIBRARY_PATH

RUN pip install --upgrade opencv-python opencv-contrib-python cython setuptools pycocotools xtcocotools json-tricks munkres thop
RUN pip install --upgrade easydict trimesh shapely
RUN pip install --upgrade tqdm>=4.35.0 torch==1.10.0+cu111 torchvision==0.11.1+cu111 -f https://download.pytorch.org/whl/cu111/torch_stable.html
RUN pip install mmcv-full==1.6.0 -f https://download.openmmlab.com/mmcv/dist/cu111/torch1.10.0/index.html
RUN pip install jupyterlab

# Ref. https://mmdetection3d.readthedocs.io/en/latest/getting_started.html#installation
RUN pip install mmdet
RUN git clone https://github.com/open-mmlab/mmsegmentation.git /mmsegmentation
WORKDIR /mmsegmentation
#RUN git checkout v0.20.0
RUN pip install -e .
RUN pip install llvmlite --ignore-installed
RUN git clone https://github.com/open-mmlab/mmdetection3d.git /mmdetection3d
WORKDIR /mmdetection3d
RUN pip install -v -e .

#RUN pip install openmim
#RUN mim install mmcv-full
#RUN mim install mmdet
#RUN mim install mmsegmentation
#RUN min install mmdet3d
#

#RUN pip install git+https://github.com/svenkreiss/poseval.git
# Ref. https://mmcv.readthedocs.io/en/latest/get_started/installation.html
#RUN pip install --upgrade tqdm>=4.35.0 torch==1.10.0+cu111 torchvision==0.11.1+cu111 -f https://download.pytorch.org/whl/cu111/torch_stable.html
#RUN pip install --upgrade mmcv-full -f https://download.openmmlab.com/mmcv/dist/cu111/torch1.10.0/index.html

RUN apt-get clean && \
        rm -rf /var/lib/apt/lists/*