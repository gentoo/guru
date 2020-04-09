# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

#ERROR   -  Unable to read git logs of '/var/tmp/portage/dev-python/pymdown-extensions-7.0.0/work/pymdown-extensions-7.0.0/docs/src/markdown/index.md'. To ignore this error, set option 'ignoring_missing_git: true'
#ERROR   -  Error reading page 'index.md': Cmd('git') failed due to: exit code(128)
#DOCBUILDER="mkdocs"
#DOCDEPEND="
#	dev-python/mkdocs-minify-plugin
#	dev-python/mkdocs-git-revision-date-localized-plugin
#	dev-python/mkdocs-material
#	dev-python/pymdown-lexers
#	dev-python/pyspelling
#	dev-python/pymdown-extensions
#"

inherit distutils-r1 #docs

DESCRIPTION="Extensions for Python Markdown."
HOMEPAGE="
	https://github.com/facelessuser/pymdown-extensions
	https://pypi.org/project/pymdown-extensions
"
SRC_URI="https://github.com/facelessuser/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/markdown-3.2[${PYTHON_USEDEP}]"

DEPEND="test? (
		dev-python/pyyaml[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
