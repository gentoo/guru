# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Virtual for sendmail program"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

DEPEND="
	|| (
		mail-mta/nullmailer
		mail-mta/msmtp[mta]
		mail-mta/ssmtp[mta]
		mail-mta/esmtp
		mail-mta/opensmtpd
		mail-mta/postfix
		mail-mta/courier
		mail-mta/exim
		mail-mta/sendmail
		virtual/qmail
	)
"
