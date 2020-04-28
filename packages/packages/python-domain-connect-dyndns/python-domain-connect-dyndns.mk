################################################################################
#
# python-domain-connect-dyndns
#
################################################################################

PYTHON_DOMAIN_CONNECT_DYNDNS_VERSION = 0.0.6
PYTHON_DOMAIN_CONNECT_DYNDNS_SOURCE = domain-connect-dyndns-$(PYTHON_DOMAIN_CONNECT_DYNDNS_VERSION).tar.gz
PYTHON_DOMAIN_CONNECT_DYNDNS_SITE = https://files.pythonhosted.org/packages/58/1a/69bf71e478f2fbd03e63ace2096b3ff0fa697de29e3b1865b67d0fe43cf5
PYTHON_DOMAIN_CONNECT_DYNDNS_SETUP_TYPE = setuptools
PYTHON_DOMAIN_CONNECT_DYNDNS_LICENSE = MIT
PYTHON_DOMAIN_CONNECT_DYNDNS_LICENSE_FILES = LICENSE

$(eval $(python-package))
