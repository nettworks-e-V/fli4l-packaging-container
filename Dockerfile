FROM debian:stretch
MAINTAINER Yves Schumann <yves@eisfair.org>

# Define environment vars
# Set PERL_USE_UNSAFE_INC to make Debian 9 latex2html work
ENV WORK_DIR=/data/work \
    SHARED_DIR=/data/shared/fli4l \
    DEBIAN_FRONTEND=noninteractive \
    PERL_USE_UNSAFE_INC=1 \
    LC_ALL=en_US.UTF-8 \
    TZ='Europe/Berlin'

# Mount point for development workspace
RUN mkdir -p ${WORK_DIR}
VOLUME ${WORK_DIR}

# Mount point for shared resources like source archives etc
RUN mkdir -p ${SHARED_DIR}
VOLUME ${SHARED_DIR}

RUN apt-get update -y \
 && apt-get upgrade -y
RUN apt-get install -y --no-install-recommends \
    dos2unix \
    curl \
    fig2dev \
    git \
    locales \
    libxml2-utils \
    make \
    mc \
    netpbm \
    openssh-client \
    ghostscript \
    rsync \
    subversion \
    texlive-font-utils \
    texlive-latex-base \
    texlive-lang-english \
    texlive-lang-french \
    texlive-lang-german \
    texlive-latex-recommended \
    texlive-fonts-recommended \
    lmodern \
    texlive-latex-extra \
    latex2html \
    texlive-fonts-extra \
    wget

# Set locale to UTF8
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
 && locale-gen en_US.UTF-8 \
 && dpkg-reconfigure locales \
 && /usr/sbin/update-locale LANG=en_US.UTF-8

# Set timezone to Europe/Berlin
RUN echo $TZ > /etc/timezone && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata
