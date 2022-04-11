FROM oraclelinux:8.5
ENV python_version="38"
ENV ansible_version="4.3.0"
COPY scripts/* /etc/profile.d/
RUN yum update -y && \
    yum install oraclelinux-developer-release-el8 oracle-epel-release-el8 -y && \
    yum install -y python${python_version} \
                   python${python_version}-markupsafe \
                   python${python_version}-pyyaml \
                   python${python_version}-cryptography \
                   python${python_version}-jinja2 \
                   python${python_version}-pip \
                   python${python_version}-pycparser \
                   curl \
                   tar \
                   git \
                   jq
RUN curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | sh && \
    curl -L https://raw.githubusercontent.com/warrensbox/tgswitch/release/install.sh | sh && \
    chmod +x /etc/profile.d/*  && \
    alternatives --set python /usr/bin/python3 && \
    pip3 --quiet --no-cache-dir install ansible==${ansible_version} bbprc pywinrm pypsrp ortu lxml oci-cli && \
    ansible-galaxy collection install oracle.oci
# post install test
RUN python -c "import oci;print(oci.version)"