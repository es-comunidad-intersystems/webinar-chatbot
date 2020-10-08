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

# set iris password
RUN echo ${IRIS_PASSWORD} > /tmp/password.txt && /usr/irissys/dev/Container/changePassword.sh /tmp/password.txt

USER irisowner
SHELL ["/irissession.sh"]
RUN \
  zn "USER" \
  do $SYSTEM.OBJ.Load("/tmp/src/Chatbot/Installer.cls", "ck") \
  set vars("Namespace")="CHATBOT" \
  set vars("SourcePath")="/tmp/src" \
  set vars("DataDBPath")="/opt/chatbot/db/DATA" \
  set vars("CodeDBPath")="/opt/chatbot/db/CODE" \
  set vars("WebApp")="/chatbot/dialogflow" \
  set sc = ##class(Chatbot.Installer).Run(.vars)

# bringing the standard shell back
SHELL ["/bin/bash", "-c"]