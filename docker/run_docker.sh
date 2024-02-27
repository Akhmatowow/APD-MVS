#!/bin/bash
docker run --gpus 'all,"capabilities=compute,utility,graphics"' -it\
           -e CUDA_VISIBLE_DEVICES=7\
           -v /mnt/data/a.akhmatova/workspace/:/workspace \
           --memory=100g --cpuset-cpus=10-39  --shm-size=32Gb \
           --name akhmatova_apd_mvs akhmatova/apd_mvs bash
