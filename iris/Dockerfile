FROM store/intersystems/iris-community:2020.2.0.211.0
ARG IRIS_PASSWORD

USER irisowner

COPY --chown=51773:52773 irissession.sh /
RUN chmod +x /irissession.sh

# copy iris source code
COPY --chown=51773:52773 src /tmp

RUN echo ${IRIS_PASSWORD} > /tmp/password.txt && /usr/irissys/dev/Container/changePassword.sh /tmp/password.txt

SHELL ["/irissession.sh"]

RUN \
  zn "USER" \
  set sc = 1

# bringing the standard shell back
SHELL ["/bin/bash", "-c"]