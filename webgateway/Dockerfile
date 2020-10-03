
FROM containers.intersystems.com/intersystems/webgateway:2020.2.0.211.0

# apache: enable ssl
RUN a2enmod ssl
WORKDIR /etc/apache2/sites-enabled
RUN ln -s ../sites-available/default-ssl.conf default-ssl.conf

# ssl certificate
WORKDIR /etc/ssl
#COPY ssl-cert.pem /etc/ssl/certs/ssl-cert-snakeoil.pem
#COPY ssl-cert.key /etc/ssl/private/ssl-cert-snakeoil.key

# apache: CSP module config
COPY CSP.conf /etc/apache2/mods-available/CSP.conf

# webgateway config
COPY CSP.ini /opt/webgateway/bin/CSP.ini
RUN bash /configHttpd.sh

# run apache2
WORKDIR /
ENTRYPOINT ["/cspEntryPoint.sh"]
CMD ["apache2ctl -DFOREGROUND &"]
