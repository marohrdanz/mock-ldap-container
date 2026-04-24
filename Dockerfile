#
#  Open LDAP
#  Based on public github repo: https://github.com/dinkel/docker-openldap
#

FROM debian:trixie

ARG TAG

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        slapd ldap-utils vim && \
    mv /etc/ldap /etc/ldap.dist

COPY modules/ /etc/ldap.dist/modules
COPY entrypoint.sh /entrypoint.sh

EXPOSE 389

VOLUME ["/etc/ldap", "/var/lib/ldap"]

ENTRYPOINT ["/entrypoint.sh"]

COPY ldif_prepopulate /etc/ldap.dist/prepopulate

## user configurations
## (it's nice to have pretty when you log in)
RUN printf 'PS1="\033[1;32m\u@ldap_container:\w $ \033[0m"\nalias ls="ls --color=auto"\nalias vi=vim\n' >> /etc/skel/.bashrc && \
    printf 'alias grep="grep -n --color"\n' >> /etc/skel/.bashrc && \
    printf "syntax on\n:set hlsearch\n:set ruler\n:set ts=2\n:set list\n:set listchars=tab:<>\ninoremap jj <ESC>" >> /etc/skel/.vimrc && \
    echo '-w "\\n"' >> /etc/skel/.curlrc   && \
    cp /etc/skel/.bashrc /root/  && \
    cp /etc/skel/.vimrc  /root/  && \
    cp /etc/skel/.curlrc /root/

RUN mkdir -p /var/run/slapd

CMD ["slapd", "-d", "256", "-u", "openldap", "-g", "openldap"]
