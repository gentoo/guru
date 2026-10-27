# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

MY_REV="9bdf31556675e795c7c7c4f033f194dc075d5919"

DESCRIPTION="Simple Django model translations without nasty hacks"
HOMEPAGE="
	https://github.com/django-extensions/django-extensions/
	https://pypi.org/project/django-extensions/
"
SRC_URI="https://github.com/django-extensions/django-extensions/archive/${MY_REV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/${PN}-${MY_REV}"

PATCHES=(
	# requires shortuuid which isn't packaged
	"${FILESDIR}"/remove-shortuuid-models.patch
)

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/django-4.2[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		${RDEPEND}
		dev-python/aiosmtpd[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-{cov,django} )
EPYTEST_IGNORE=(
	tests/test_shortuuid_field.py
)
EPYTEST_DESELECT=(
	tests/management/commands/test_export_emails.py::test_do_export_emails_format_vcard_start
	tests/test_dumpscript.py::DumpScriptTests::test_replaced_stderr
	tests/test_dumpscript.py::DumpScriptTests::test_replaced_stdout
	tests/test_dumpscript.py::DumpScriptTests::test_runs
	tests/test_dumpscript.py::DumpScriptTests::test_valid_syntax
	tests/test_dumpscript.py::DumpScriptTests::test_with_datetimefield
)
distutils_enable_tests pytest

python_test() {
	local -x DJANGO_SETTINGS_MODULE="tests.testapp.settings"
	epytest
}
