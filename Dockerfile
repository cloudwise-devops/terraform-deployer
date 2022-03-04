FROM oraclelinux:8.5
COPY scripts/* /etc/profile.d/
RUN yum update -y && yum install -y curl tar git make
RUN curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | sh && \
    curl -L https://raw.githubusercontent.com/warrensbox/tgswitch/release/install.sh | sh && \
    chmod +x /etc/profile.d/*
