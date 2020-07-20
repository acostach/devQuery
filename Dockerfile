FROM nvcr.io/nvidia/l4t-base:r32.4.2 AS builder

WORKDIR /tmp/cuda-samples-master/Samples/deviceQuery
RUN apt-get update && apt-get install -y --no-install-recommends build-essential curl
RUN curl -sSfL https://github.com/NVIDIA/cuda-samples/archive/master.tar.gz | \
        tar xzf - -C /tmp/
WORKDIR /tmp/cuda-samples-master/Samples/deviceQuery
RUN make TARGET_ARCH=aarch64 SMS="60"

FROM nvcr.io/nvidia/l4t-base:r32.4.2
COPY --from=builder /tmp/cuda-samples-master/Samples/deviceQuery/deviceQuery /

CMD ["bash"]
