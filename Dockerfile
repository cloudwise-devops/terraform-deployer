FROM oraclelinux:8.5
RUN yum update -y && yum install -y curl tar
RUN curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | sh && \
    curl -L https://raw.githubusercontent.com/warrensbox/tgswitch/release/install.sh | sh