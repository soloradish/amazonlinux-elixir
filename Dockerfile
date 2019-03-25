FROM amazonlinux:2

ARG OTP_VERSION="21.3"
ARG ELIXIR_VERSION="1.8.1"

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8     

RUN yum groupinstall "Development Tools" -y && \
    yum install wget ncurses-devel openssl-devel -y

RUN wget http://erlang.org/download/otp_src_${OTP_VERSION}.tar.gz && \
    tar -zxvf otp_src_${OTP_VERSION}.tar.gz && \
    rm otp_src_${OTP_VERSION}.tar.gz && \
    cd otp_src_${OTP_VERSION} && \
    ./configure && make && make install && \
    cd .. && rm -rf otp_src_${OTP_VERSION}  

RUN wget https://github.com/elixir-lang/elixir/archive/v${ELIXIR_VERSION}.zip && \
    unzip v${ELIXIR_VERSION}.zip && rm v${ELIXIR_VERSION}.zip && \
    cd elixir-${ELIXIR_VERSION} && \
    make && make install && \
    cd .. && rm -rf elixir-{ELIXIR_VERSION}
