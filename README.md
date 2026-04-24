# Dockerized Standalone LDAP Daemon

Quick and dirty OpenLDAP service for testing applications that authenticate to LDAP.

This container is based on the GitHub repo: [https://github.com/dinkel/docker-openldap](https://github.com/dinkel/docker-openldap)

## QuickStart

Build and start container:

```bash
docker-compose build
docker-compose up -d
```

The container takes a few seconds to start up. Once you see `slapd starting` in the log output the initialization has completed.

## Example Queries

Query this LDAP container:

```bash
## Return record for user with common name 'usertwo'
ldapsearch -x -H ldap://localhost:9489 -b dc=example,dc=com -s sub "(CN=usertwo)"
## Search for users in 'group2'
ldapsearch -x -H ldap://localhost:9489 -b dc=example,dc=com -s sub "(memberOf=CN=group2,OU=Girard,DC=example,DC=com)"
## Return groups for user with common name 'usertwo'
ldapsearch -x -H ldap://localhost:9489 -b dc=example,dc=com -s sub "(CN=usertwo)" memberOf
## Return the title and display name for all users with 'User' in their title
ldapsearch -x -H ldap://localhost:9489 -b dc=example,dc=com -s sub "(title=*User*)" title displayName
## Return the title and display name for all users in group2
ldapsearch -x -H ldap://localhost:9489 -b dc=example,dc=com \
   -s sub "(memberOf=CN=group2,OU=Girard,DC=example,DC=com)" \
   title displayName
```

