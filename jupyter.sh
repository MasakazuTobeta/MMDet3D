docker run --rm --name mmdet_jupyter -p 8888:8888 \
    -v $(pwd):/workspace \
    -w /workspace \
    -it masakazutobeta/mmdet3d:latest jupyter lab \
    --no-browser --port=8888 --ip=0.0.0.0 --allow-root