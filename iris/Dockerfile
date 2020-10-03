FROM store/intersystems/iris-community:2020.2.0.211.0
ARG IRIS_PASSWORD

USER ${ISC_PACKAGE_MGRUSER}

COPY --chown=$ISC_PACKAGE_MGRUSER:$ISC_PACKAGE_IRISGROUP irissession.sh /
RUN chmod +x /irissession.sh

# copy iris source code
COPY --chown=$ISC_PACKAGE_MGRUSER:$ISC_PACKAGE_IRISGROUP src /tmp

RUN echo ${IRIS_PASSWORD} > /tmp/password.txt && /usr/irissys/dev/Container/changePassword.sh /tmp/password.txt

SHELL ["/irissession.sh"]

RUN \
  zn "USER" \
  set sc = 1

# bringing the standard shell back
SHELL ["/bin/bash", "-c"]