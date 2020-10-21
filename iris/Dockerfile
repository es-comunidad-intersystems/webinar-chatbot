FROM store/intersystems/iris-community:2020.2.0.211.0
ARG IRIS_PASSWORD

USER root
COPY --chown=51773:52773 irissession.sh /
RUN chmod +x /irissession.sh

# create app dirs
RUN mkdir -p /opt/chatbot/db/DATA
RUN mkdir -p /opt/chatbot/db/CODE
RUN chown -R 51773:52773 /opt/chatbot

# copy iris source code
WORKDIR /tmp
COPY --chown=51773:52773 src src
COPY --chown=51773:52773 install install

# set iris password
RUN echo ${IRIS_PASSWORD} > /tmp/password.txt && /usr/irissys/dev/Container/changePassword.sh /tmp/password.txt

# download zpm package manager
#RUN mkdir -p /tmp/deps \
# && cd /tmp/deps \
# && wget -q https://pm.community.intersystems.com/packages/zpm/latest/installer -O zpm.xml

USER irisowner
SHELL ["/irissession.sh"]
RUN \
  zn "USER" \
  do $SYSTEM.OBJ.Load("/tmp/src/Chatbot/Installer.cls", "ck") \
  set vars("Namespace")="CHATBOT" \
  set vars("SourcePath")="/tmp/src" \
  set vars("DataDBPath")="/opt/chatbot/db/DATA" \
  set vars("CodeDBPath")="/opt/chatbot/db/CODE" \
  set sc = ##class(Chatbot.Installer).Run(.vars) \
  #zn "CHATBOT" \
  #do $system.OBJ.Load("/tmp/deps/zpm.xml", "ck") \
  #zpm "install webterminal" \
  set sc = 1

# bringing the standard shell back
SHELL ["/bin/bash", "-c"]