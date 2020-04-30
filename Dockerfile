FROM jboss/wildfly:18.0.1.Final

ENV KEYCLOAK_VERSION 9.0.3

# Install WildFly adapter
RUN curl -fsSL https://downloads.jboss.org/keycloak/$KEYCLOAK_VERSION/adapters/keycloak-oidc/keycloak-wildfly-adapter-dist-$KEYCLOAK_VERSION.tar.gz | tar xzf - -C /opt/jboss/wildfly \
  && $JBOSS_HOME/bin/jboss-cli.sh --file=$JBOSS_HOME/bin/adapter-install-offline.cli

RUN curl -fsSL https://downloads.jboss.org/keycloak/$KEYCLOAK_VERSION/adapters/saml/keycloak-saml-wildfly-adapter-dist-$KEYCLOAK_VERSION.tar.gz | tar xzf - -C /opt/jboss/wildfly \
  && $JBOSS_HOME/bin/jboss-cli.sh --file=$JBOSS_HOME/bin/adapter-install-saml-offline.cli

# add an admin user to wildfly with the credential: wildfly wildfly
RUN /opt/jboss/wildfly/bin/add-user.sh wildfly wildfly --silent