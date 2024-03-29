FROM alpine:latest
WORKDIR /workdir
ENV HOME=/root
ENV LANG=ja_JP.UTF-8
ENV LC_CTYPE=ja_JP.UTF-8
ENV TROFFONTS=/usr/share/fonts/ipafont:/usr/share/fonts/ipaexfont
ENV PATH=/usr/lib/heirloom-doctools/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV MANPATH=/usr/lib/heirloom-doctools/man
RUN apk update \
  && apk add --upgrade \
     heirloom-doctools \
     heirloom-doctools-doc \
     bash bmake make gcc musl-dev \
     font-ipa font-ipaex \
     ghostscript \
     git inkscape \
     perl perl-dev perl-app-cpanminus \
  && rm -f /var/cache/apk/*
RUN cd /usr/share/fonts/ipafont    && \
    ln -s ipam.ttf  IPAMincho.ttf  && \
    ln -s ipag.ttf  IPAGothic.ttf  && \
    ln -s ipamp.ttf IPAPMincho.ttf && \
    ln -s ipagp.ttf IPAPGothic.ttf
RUN cd /usr/share/fonts/ipaexfont     && \
    ln -s ipaexm.ttf  IPAexMincho.ttf && \
    ln -s ipaexg.ttf  IPAexGothic.ttf
RUN cpanm --installdeps -nq \
    https://github.com/kaz-utashiro/App-Greple-fbsd2.git
RUN ln -s heirloom-doctools.sh.disabled /etc/profile.d/heirloom-doctools.sh
COPY inputrc $HOME/.inputrc
COPY bashrc $HOME/.bashrc
CMD [ "bash" ]
