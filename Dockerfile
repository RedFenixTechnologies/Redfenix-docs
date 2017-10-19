FROM alpine:3.3
MAINTAINER Daniel Izquierdo <djizquier@gmail.com>

ENV BUILD_PACKAGES bash curl-dev ruby-dev build-base \
                   tar gcc gnupg procps musl-dev make linux-headers \
                   zlib zlib-dev openssl openssl-dev libssl1.0
ENV RUBY_PACKAGES ruby ruby-io-console ruby-bundler
ENV RVM_USER    rvm
ENV RVM_GROUP   rvm
ENV SU_RVM      su - $RVM_USER -c

# Dependencies for getting/building
RUN apk update && \
    apk upgrade && \
    apk add $BUILD_PACKAGES && \
    apk add $RUBY_PACKAGES && \
    gem install rake -N

# User
RUN addgroup $RVM_GROUP && \
    adduser -h /home/$RVM_USER -g 'RVM User' -s /bin/bash -G $RVM_GROUP -D $RVM_USER 

# Download and Build
RUN $SU_RVM 'gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
             curl -L -o stable.tar.gz https://github.com/rvm/rvm/archive/stable.tar.gz && \
             gunzip -c stable.tar.gz | tar xf - && \
             cd rvm-stable && ./scripts/install'
RUN $SU_RVM './.rvm/bin/rvm install 2.3.0 --disable-binary --movable --autolibs=0'

# RVM really doesn't like parts of Alpine (such as musl ldd)
# so you have to fake it
ADD /home/rvm/.profile /home/$RVM_USER/.profile
RUN chown $RVM_USER.$RVM_GROUP /home/$RVM_USER/.profile 

# Tidy a little.
RUN $SU_RVM 'rm -rf rvm-stable stable.tar.gz' && \
    rm -rf /var/cache/apk/*



# Update and install all of the required packages.
# At the end, remove the apk cache
# RUN apk update && \
#     apk upgrade && \
#     apk add $BUILD_PACKAGES && \
#     apk add $RUBY_PACKAGES && \
#     rm -rf /var/cache/apk/*

RUN mkdir /usr/app
RUN \curl -sSL https://get.rvm.io | bash
RUN rvm upgrade 2.2.3 2.3.1
RUN gem install bundler
WORKDIR /usr/app

COPY Gemfile /usr/app/
COPY Gemfile.lock /usr/app/
RUN bundle install

COPY . /usr/app

CMD ["bundle exec middleman server"]
