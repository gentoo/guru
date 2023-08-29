# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 git-r3

DESCRIPTION="Evernote CLI"
HOMEPAGE="https://github.com/Evernote/evernote-sdk-python3"
EGIT_REPO_URI="https://github.com/jeffkowalski/geeknote"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="dev-python/evernote3[${PYTHON_USEDEP}]
dev-python/html2text[${PYTHON_USEDEP}]
dev-python/sqlalchemy[${PYTHON_USEDEP}]
dev-python/markdown2[${PYTHON_USEDEP}]
dev-python/beautifulsoup4[${PYTHON_USEDEP}]
dev-python/thrift[${PYTHON_USEDEP}]
dev-python/lxml[${PYTHON_USEDEP}]"

src_prepare() {
	eapply "${FILESDIR}"/completion.patch

	default
}

python_install_all() {
	distutils-r1_python_install_all --bash-completion-dir="${D}"/etc/bash_completion.d
}
