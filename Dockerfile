# phenotips installation
# 
# VERSION 1.0
#

FROM tomcat:9.0.37-jdk8

MAINTAINER Robert Reihs <robert.reihs@gmail.com>

RUN apt-get update 
 
RUN sed -i 's/redirectPort="8443"/redirectPort="8443" URIEncoding="UTF-8"/g' /usr/local/tomcat/conf/server.xml \
    && wget https://nexus.phenotips.org/nexus/content/repositories/releases/org/phenotips/phenotips-war/1.4.9/phenotips-war-1.4.9.war  \
    && wget https://nexus.phenotips.org/nexus/content/repositories/releases/org/phenotips/solr-configuration/1.4.9/solr-configuration-1.4.9.jar \
    && unzip phenotips-war-1.4.9.war -d /opt/ROOT \
#    && chmod -R 777 /usr/local/tomcat/webapps/ROOT \
#    && rm -R /usr/local/tomcat/webapps/ROOT \
    && mv /opt/ROOT /usr/local/tomcat/webapps/ \
    && mkdir -p /var/lib/phenotips \
    && unzip solr-configuration-1.4.9.jar  -d /opt/solr \
    && mv /opt/solr /var/lib/phenotips/ \
    && sed -i 's/# xwiki.db=xwiki/xwiki.db=phenotips/g' /usr/local/tomcat/webapps/ROOT/WEB-INF/xwiki.cfg \
    && unzip -o /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/xwiki-platform-oldcore-7.4.6.jar -d /usr/local/tomcat/webapps/ROOT/WEB-INF/classes \
    && sed -i 's/column="XWV_USER_AGENT" not-null="true" length="8192"/column="XWV_USER_AGENT" not-null="true" length="2048"/g' /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/xwiki.hbm.xml
       

COPY configs/hibernate.cfg.xml /usr/local/tomcat/webapps/ROOT/WEB-INF/hibernate.cfg.xml

CMD ["/opt/bibbox-scripts/entrypoint.sh"]
    
ADD scripts /opt/bibbox-scripts
WORKDIR /opt/bibbox-scripts
RUN chmod a+x *.sh

ENTRYPOINT ["/opt/bibbox-scripts/entrypoint.sh"]
