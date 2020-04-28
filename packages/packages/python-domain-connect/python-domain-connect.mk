################################################################################
#
# python-domain-connect
#
################################################################################

PYTHON_DOMAIN_CONNECT_VERSION = 0.0.7
PYTHON_DOMAIN_CONNECT_SOURCE = domain_connect-$(PYTHON_DOMAIN_CONNECT_VERSION).tar.gz
PYTHON_DOMAIN_CONNECT_SITE = https://files.pythonhosted.org/packages/d3/cd/b5356dadea43a93cb4c3c671fd89ff339da30c46b2e4b7b78f992387e930
PYTHON_DOMAIN_CONNECT_SETUP_TYPE = setuptools
PYTHON_DOMAIN_CONNECT_LICENSE = https://github.com/Domain-Connect/domainconnect_python/blob/master/LICENSE

$(eval $(python-package))
