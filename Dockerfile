FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

# title
ENV TITLE=Wechat

RUN \
  echo "**** add icon ****" && \
  curl -o /kclient/public/favicon.ico https://res.wx.qq.com/a/wx_fed/assets/res/NTI4MWU5.ico && \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends libatk1.0-0 libatk-bridge2.0-0 libatomic1 libxkbcommon-x11-0 libxcb-icccm4 libxcb-image0 libxcb-render-util0 libxcb-keysyms1 desktop-file-utils fonts-noto-cjk-extra && \
  curl -o /tmp/wechat.deb https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.deb && \
  apt-get install -y /tmp/wechat.deb && \
  fc-cache -fv && \
  sed -i "s/UI.initSetting('enable_ime', false)/UI.initSetting('enable_ime', true)/" /usr/local/share/kasmvnc/www/dist/main.bundle.js
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
