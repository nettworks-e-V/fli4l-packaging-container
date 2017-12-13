FROM debian:stretch
MAINTAINER Yves Schumann <yves@eisfair.org>

# Define environment vars
ENV WORK_DIR=/data/work \
    SHARED_DIR=/data/shared/fli4l \
    DEBIAN_FRONTEND=noninteractive

# Mount point for development workspace
RUN mkdir -p ${WORK_DIR}
VOLUME ${WORK_DIR}

# Mount point for shared resources like source archives etc
RUN mkdir -p ${SHARED_DIR}
VOLUME ${SHARED_DIR}

RUN apt-get update -y \
 && apt-get upgrade -y
RUN apt-get install -y --no-install-recommends \
    locales \
    mc \
    git \
    subversion \
    wget \
    libxml2-utils \
    dos2unix \
    make \
    netpbm \
    fig2dev \
    ghostscript \
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
    texlive-fonts-extra

# Set locale to UTF8
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
 && locale-gen en_US.UTF-8 \
 && dpkg-reconfigure locales \
 && /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8
