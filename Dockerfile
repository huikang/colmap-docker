FROM ubuntu:xenial

RUN apt-get update && apt-get install -y \
    git \
    cmake \
    build-essential \
    libboost-program-options-dev \
    libboost-filesystem-dev \
    libboost-graph-dev \
    libboost-regex-dev \
    libboost-system-dev \
    libboost-test-dev \
    libeigen3-dev \
    libsuitesparse-dev \
    libfreeimage-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    libglew-dev \
    qtbase5-dev \
    libqt5opengl5-dev \
    libcgal-dev \
    libatlas-base-dev libsuitesparse-dev \
    libcgal-qt5-dev \
    && rm -rf /var/lib/apt/lists/*

RUN    git clone https://ceres-solver.googlesource.com/ceres-solver
RUN    cd ceres-solver \
        && git checkout $(git describe --tags) \
        && mkdir build \
        && cd build \
        && cmake .. -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF \
        && make \
        && make install

RUN git clone https://github.com/colmap/colmap
RUN cd colmap \
            && git checkout dev \
            && mkdir build \
            && cd build \
            && cmake .. \
            && make \
            && make install

RUN ls ./colmap
