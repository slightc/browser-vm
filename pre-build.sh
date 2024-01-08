sed -i 's|deb http://us.archive.ubuntu.com/ubuntu/|deb mirror://mirrors.ubuntu.com/mirrors.txt|g' /etc/apt/sources.list; \
    dpkg --add-architecture i386; \
    rm -rf /var/lib/apt/lists/*; \
    apt-get -q update;

DEBIAN_FRONTEND=noninteractive apt-get -q -y install \
    bc \
    build-essential \
    bzr \
    cpio \
    cvs \
    git \
    unzip \
    wget \
    libc6:i386 \
    libncurses5-dev \
    libssl-dev \
    texinfo \
    rsync;
