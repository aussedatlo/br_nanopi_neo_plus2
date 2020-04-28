################################################################################
#
# python-publicsuffix
#
################################################################################

PYTHON_PUBLICSUFFIX_VERSION = 1.1.1
PYTHON_PUBLICSUFFIX_SOURCE = publicsuffix-$(PYTHON_PUBLICSUFFIX_VERSION).tar.gz
PYTHON_PUBLICSUFFIX_SITE = https://files.pythonhosted.org/packages/d5/70/8124bab47b4b83c5846e124e91e8958696200acabc7404d3765f44212f8d
PYTHON_PUBLICSUFFIX_SETUP_TYPE = setuptools
PYTHON_PUBLICSUFFIX_LICENSE = MIT
PYTHON_PUBLICSUFFIX_LICENSE_FILES = LICENSE

$(eval $(python-package))
