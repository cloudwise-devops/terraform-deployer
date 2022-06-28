FROM oraclelinux:8.5
ENV python_version="38"
ENV ansible_version="3.4.0"
ENV terraform_version="1.1.2"
COPY scripts/* /etc/profile.d/
RUN yum update -y && \
    yum install oraclelinux-developer-release-el8 oracle-epel-release-el8 yum-utils sudo tar zip -y && \
    yum install -y python${python_version} \
                   python${python_version}-pip \
                   curl make jq git unzip libcurl-devel && \
    yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo && \
    yum -y install terraform-${terraform_version} && \
    curl -L https://github.com/gruntwork-io/terragrunt/releases/download/v0.36.11/terragrunt_linux_amd64 -o /usr/bin/terragrunt && \
    chmod +x  /usr/bin/terragrunt && \
    useradd way4
RUN curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | sh && \
    curl -L https://raw.githubusercontent.com/warrensbox/tgswitch/release/install.sh | sh && \
    chmod +x /etc/profile.d/*  && \
    alternatives --set python /usr/bin/python3 && \
    pip3 --quiet --no-cache-dir install  \
                  ansible==${ansible_version} \
                  requests \
                  pyyaml \
                  jinja2 \
                  markupsafe \
                  pycparser \
                  cryptography \
                  jmespath \
                  bbprc \
                  pywinrm \
                  pypsrp \
                  ortu \
                  lxml  \
                  netaddr \
                  oci-cli && \
    ansible-galaxy collection install oracle.oci && \
    curl -L https://networkgenomics.com/try/mitogen-0.3.3.tar.gz -o /tmp/mitogen.tar.gz && \
    mkdir /opt/ansible_plugins && \
    tar -xvf tar -xvf /tmp/mitogen.tar.gz -C /opt/ansible_plugins && \
    rm -rf /tmp/mitogen.tar.gz
COPY deploy_suders /etc/sudoers.d/deploy_suders
RUN chmod 0440 /etc/sudoers.d/deploy_suders && \
    visudo -c
# post install test
RUN python -c "import oci;print(oci.version)"