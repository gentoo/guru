# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_11 )

inherit bash-completion-r1 optfeature python-single-r1

DESCRIPTION="Simple chroot build environment manager for building RPMs"
HOMEPAGE="
	https://rpm-software-management.github.io/mock/
	https://github.com/rpm-software-management/mock/
"
SRC_URI="https://github.com/rpm-software-management/mock/releases/download/${P}-1/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#DEPEND=""
RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		app-arch/rpm[python,${PYTHON_SINGLE_USEDEP}]
		dev-python/backoff[${PYTHON_USEDEP}]
		dev-python/distro[${PYTHON_USEDEP}]
		dev-python/pyroute2[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/rpmautospec-core[${PYTHON_USEDEP}]
		dev-python/templated-dictionary[${PYTHON_USEDEP}]
	')
	acct-group/mock
	app-containers/podman
	dev-util/distribution-gpg-keys
	dev-util/mock-core-configs
"

src_prepare() {
	default

	sed -i -e "s|^VERSION\s*=.*|VERSION=\"${PV}\"|" \
		-e "s|^SYSCONFDIR\s*=.*|SYSCONFDIR=\"${EPREFIX}/etc\"|" \
		-e "s|^PYTHONDIR\s*=.*|PYTHONDIR=\"$(python_get_sitedir)\"|" \
		-e "s|^PKGPYTHONDIR\s*=.*|PKGPYTHONDIR=\"$(python_get_sitedir)/mockbuild\"|" \
		py/mockbuild/constants.py py/mock-parse-buildlog.py || die

	sed -i -e "s|^_MOCK_NVR = None$|_MOCK_NVR = \"${P}-1\"|" py/mock.py || die
	sed -i -e "s|@VERSION@|${PV}|" docs/mock.1 docs/mock-parse-buildlog.1 || die

	sed -i -e 's|"/bin/free"|"/usr/bin/free"|' py/mockbuild/plugins/hw_info.py || die
}

src_compile() { :; }

src_install() {
	python_domodule py/mockbuild
	python_newscript py/mock.py mock
	python_newscript py/mock-parse-buildlog.py mock-parse-buildlog
	dobin mockchain

	exeinto /usr/libexec/mock
	doexe create_default_route_in_container.sh

	dobashcomp etc/bash_completion.d/mock
	bashcomp_alias mock mock-parse-buildlog
	dodoc docs/site-defaults.cfg
	doman docs/mock.1 docs/mock-parse-buildlog.1

	insinto /etc/mock
	doins etc/mock/*
	insinto /etc/pki/mock
	doins etc/pki/*

	diropts -m0775 -o root -g mock
	keepdir /var/lib/mock
}

pkg_postinst() {
	optfeature "chain mode support" app-arch/createrepo_c
	optfeature "pigz in root_cache plugin" app-arch/pigz
	optfeature "nspawn instead of chroot" sys-apps/systemd
	optfeature "lvm_root plugin support" sys-fs/lvm2
	optfeature "procenv plugin support" sys-process/procenv
}
