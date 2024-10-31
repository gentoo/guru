# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=poetry

inherit distutils-r1 systemd xdg-utils desktop

DESCRIPTION="Automatic CPU speed & power optimizer for Linux"
HOMEPAGE="https://github.com/AdnanHodzic/auto-cpufreq"
SRC_URI="https://github.com/AdnanHodzic/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/distro[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/pyinotify[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-python/poetry-core[${PYTHON_USEDEP}]
"

DOCS=( README.md )

src_prepare() {
	default
	# Update pyproject.toml to avoid dynamic_versioning in poetry
	sed -i 's/poetry_dynamic_versioning.backend/poetry.core.masonry.api/' pyproject.toml || die
	# Replace /usr/local/ paths with /usr/ in the source code to adhere to Gentoo standards
	sed -i 's|/usr/local/share|/usr/share|g' scripts/auto-cpufreq-install.sh || die
	sed -i 's|usr/local|usr|g' "scripts/${PN}.service" "scripts/${PN}-openrc" auto_cpufreq/core.py || die
	sed -i 's|usr/local|usr|g' "scripts/${PN}.service" "scripts/${PN}-openrc" auto_cpufreq/gui/app.py || die
	# Modify the service file to launch auto-cpufreq natively without the need for virtual environment
	sed -i 's|WorkingDirectory=/opt/auto-cpufreq/venv||g' scripts/auto-cpufreq.service || die
	sed -i 's|Environment=PYTHONPATH=/opt/auto-cpufreq||g' scripts/auto-cpufreq.service || die
	sed -i 's|ExecStart=/opt/auto-cpufreq/venv/bin/python /opt/auto-cpufreq/venv/bin/auto-cpufreq --daemon|ExecStart=/usr/bin/auto-cpufreq --daemon|g' scripts/auto-cpufreq.service || die
	# Change the path in core.py
	sed -i 's|/opt/auto-cpufreq/override.pickle|/var/lib/auto-cpufreq/override.pickle|g' auto_cpufreq/core.py || die
	distutils-r1_src_prepare
}

python_install() {
	distutils-r1_python_install

	# Create the scripts directory if it doesn't exist
	dodir "/usr/share/${PN}/scripts"

	# Create the directory for override.pickle
	dodir /var/lib/auto-cpufreq
	keepdir /var/lib/auto-cpufreq
	fowners root:root /var/lib/auto-cpufreq
	fperms 0755 /var/lib/auto-cpufreq

	# Copy all scripts from the 'scripts' directory
	for script in scripts/*; do
		if [[ -f "$script" ]]; then
			case "${script##*/}" in
				*.sh|*.py|auto-cpufreq-*|cpufreqctl.sh)
					exeinto "/usr/share/${PN}/scripts"
					doexe "$script"
					;;
				*)
					insinto "/usr/share/${PN}/scripts"
					doins "$script"
					;;
			esac
		fi
	done

	# Copy images
	insinto "/usr/share/${PN}/images"
	doins images/*

	# Install icon
	doicon -s 128 images/icon.png

	# Install polkit policy
	insinto /usr/share/polkit-1/actions
	doins scripts/org.auto-cpufreq.pkexec.policy

	# Install desktop file
	domenu scripts/auto-cpufreq-gtk.desktop

	# Install systemd service file
	systemd_dounit "scripts/${PN}.service"

	# Install OpenRC init script
	newinitd "scripts/${PN}-openrc" "${PN}"
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update

	elog "The auto-cpufreq override file will be stored in /var/lib/auto-cpufreq/override.pickle"

	# Create log file
	touch /var/log/auto-cpufreq.log
	elog ""
	elog "Enable auto-cpufreq daemon service at boot:"
	elog "systemd: systemctl enable --now auto-cpufreq"
	elog "openrc: rc-update add auto-cpufreq default"
	elog ""
	elog "To view live log, run:"
	elog "auto-cpufreq --stats"
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update

	# Remove the override.pickle file and directory
	if [[ -d "${EROOT}/var/lib/auto-cpufreq" ]]; then
		rm -rf "${EROOT}"/var/lib/auto-cpufreq || die
	fi

	# Remove auto-cpufreq log file
	if [ -f "${EROOT}/var/log/auto-cpufreq.log" ]; then
		rm "${EROOT}"/var/log/auto-cpufreq.log || die
	fi

	# Remove auto-cpufreq-install script
	if [ -f "${EROOT}/usr/bin/auto-cpufreq-install" ]; then
		rm "${EROOT}"/usr/bin/auto-cpufreq-install || die
	fi

	# Restore original cpufreqctl binary if backup was made
	if [ -f "${EROOT}/usr/bin/cpufreqctl.auto-cpufreq.bak" ]; then
		mv "${EROOT}"/usr/bin/cpufreqctl.auto-cpufreq{.bak,} || die
	fi
	# Remove auto-cpufreq's cpufreqctl binary
	# it overwrites cpufreqctl.sh
	if [ -f "${EROOT}/usr/bin/cpufreqctl" ]; then
		rm "${EROOT}"/usr/bin/cpufreqctl || die
	fi
}
