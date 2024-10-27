# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="An open-source GUI wallet developed by the Monero community."
HOMEPAGE="https://github.com/monero-project/monero-gui/ https://www.getmonero.org/"
SRC_URI="https://downloads.getmonero.org/gui/monero-gui-linux-x64-v${PV}.tar.bz2 -> ${P}.tar.bz2"

S="${WORKDIR}/monero-gui-v${PV}"
LICENSE="BSD MIT"
SLOT="0"
KEYWORDS="-* ~amd64"

IUSE="+daemon tools wallet-cli wallet-rpc"

QA_PREBUILT="*"

src_install() {
	insinto /usr/bin
	doins monero-wallet-gui

	if use daemon ; then
		doins monerod
	fi

	if use tools ; then
		doins extras/monero-blockchain-ancestry
		doins extras/monero-blockchain-depth
		doins extras/monero-blockchain-export
		doins extras/monero-blockchain-import
		doins extras/monero-blockchain-mark-spent-outputs
		doins extras/monero-blockchain-prune
		doins extras/monero-blockchain-prune-known-spent-data
		doins extras/monero-blockchain-stats
		doins extras/monero-blockchain-usage
		doins extras/monero-gen-ssl-cert
		doins extras/monero-gen-trusted-multisig
	fi

	if use wallet-cli ; then
		doins extras/monero-wallet-cli
	fi

	if use wallet-rpc ; then
		doins extras/monero-wallet-rpc
	fi

	domenu "${FILESDIR}"/monero-gui.desktop

	local x
	for x in 16 24 32 48 64 96 128 256; do
		newicon -s ${x} "${FILESDIR}"/${x}x${x}.png monero-gui.png
	done

	fperms +x /usr/bin/monero-wallet-gui

	if use daemon ; then
		fperms +x /usr/bin/monerod
	fi

	if use tools ; then
		fperms +x /usr/bin/monero-blockchain-ancestry
		fperms +x /usr/bin/monero-blockchain-depth
		fperms +x /usr/bin/monero-blockchain-export
		fperms +x /usr/bin/monero-blockchain-import
		fperms +x /usr/bin/monero-blockchain-mark-spent-outputs
		fperms +x /usr/bin/monero-blockchain-prune
		fperms +x /usr/bin/monero-blockchain-prune-known-spent-data
		fperms +x /usr/bin/monero-blockchain-stats
		fperms +x /usr/bin/monero-blockchain-usage
		fperms +x /usr/bin/monero-gen-ssl-cert
		fperms +x /usr/bin/monero-gen-trusted-multisig
	fi

	if use wallet-cli ; then
		fperms +x /usr/bin/monero-wallet-cli
	fi

	if use wallet-rpc ; then
		fperms +x /usr/bin/monero-wallet-rpc
	fi
}
