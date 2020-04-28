################################################################################
#
# python-publicsuffixlist
#
################################################################################

PYTHON_PUBLICSUFFIXLIST_VERSION = 0.6.13
PYTHON_PUBLICSUFFIXLIST_SOURCE = publicsuffixlist-$(PYTHON_PUBLICSUFFIXLIST_VERSION).tar.gz
PYTHON_PUBLICSUFFIXLIST_SITE = https://files.pythonhosted.org/packages/a1/eb/9e656d3c0c05e5e9f19976eee9bc8fb50d91ef16711c5925f93dbbd7006c
PYTHON_PUBLICSUFFIXLIST_SETUP_TYPE = setuptools
PYTHON_PUBLICSUFFIXLIST_LICENSE = Mozilla Public License 2.0 (MPL 2.0)
PYTHON_PUBLICSUFFIXLIST_LICENSE_FILES = LICENSE

$(eval $(python-package))
