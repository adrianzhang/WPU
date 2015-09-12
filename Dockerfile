FROM python:2.7.10

# install Node.js 4.0.0

# public key "Sam Roberts <octetcloud@keybase.io>"
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 9554F04D7259F04124DE6B476D5A82AC7E37093B \
    && gpg --keyserver pool.sks-keyservers.net --recv-keys 94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
	&& gpg --keyserver pool.sks-keyservers.net --recv-keys 0034A06D9D9B0064CE8ADF6BF1747F4AD2306D93 \
	&& gpg --keyserver pool.sks-keyservers.net --recv-keys FD3A5288F042B6850C66B31F09FE44734EB7990E \
	&& gpg --keyserver pool.sks-keyservers.net --recv-keys 71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
	&& gpg --keyserver pool.sks-keyservers.net --recv-keys DD8F2338BAE7501E3DD5AC78C273792F7D83545D

ENV NODE_VERSION v4.0.0

RUN set -x \
	&& mkdir -p /usr/src/nodejs \
	&& curl -SL "https://nodejs.org/dist/latest/node-$NODE_VERSION.tar.xz" -o nodejs.tar.xz \
	&& curl -SL "https://nodejs.org/dist/$NODE_VERSION/SHASUMS256.txt.asc" -o nodejs.tar.xz.asc \
	&& gpg --verify nodejs.tar.xz.asc \
	&& tar -xJC /usr/src/nodejs --strip-components=1 -f nodejs.tar.xz \
	&& rm nodejs.tar.xz \
	&& cd /usr/src/nodejs \
	&& ./configure \
	&& make \
	&& make install \
#	&& make test \
	&& make doc \
	&& rm -rf /usr/src/nodejs

ENTRYPOINT ["node"]
CMD [-e, "console.log('Hello from node.js ' + process.version)"]
