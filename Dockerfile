FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

# title
ENV TITLE=Wechat

RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends wget libatomic1 libxkbcommon-x11-0 libxcb-icccm4 libxcb-image0 libxcb-render-util0 libxcb-keysyms1 desktop-file-utils fonts-noto-cjk-extra && \
  wget https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.deb -O /config/.cache/wechat.deb && \
  apt-get install -y /config/.cache/wechat.deb && \
  fc-cache -fv && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /config/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config
