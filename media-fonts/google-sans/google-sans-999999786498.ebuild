# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Package version is based on
# fc-query --format '%{fontversion}\n' <filename>
# The 9999999 is there to force it to be higher than a previous package number.

EAPI=8

inherit font

DESCRIPTION="Current generation of Google’s brand typeface."
HOMEPAGE="https://fonts.google.com/specimen/Google+Sans"

SRC_URI="
	https://fonts.gstatic.com/s/googlesans/v67/4Ua_rENHsxJlGDuGo1OIlJfC6l_24rlCK1Yo_Iqcsih3SAyH6cAwhWdRFD48TE63OOYKtrwEIKlirSjiEjo5.ttf -> GoogleSans17pt-Regular-${PV}.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua_rENHsxJlGDuGo1OIlJfC6l_24rlCK1Yo_Iqcsih3SAyH6cAwhWdRFD48TE63OOYKtrw2IKlirSjiEjo5.ttf -> GoogleSans17pt-Medium-${PV}.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua_rENHsxJlGDuGo1OIlJfC6l_24rlCK1Yo_Iqcsih3SAyH6cAwhWdRFD48TE63OOYKtrzaJ6lirSjiEjo5.ttf -> GoogleSans17pt-SemiBold-${PV}.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua_rENHsxJlGDuGo1OIlJfC6l_24rlCK1Yo_Iqcsih3SAyH6cAwhWdRFD48TE63OOYKtrzjJ6lirSjiEjo5.ttf -> GoogleSans17pt-Bold-${PV}.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua_rENHsxJlGDuGo1OIlJfC6l_24rlCK1Yo_Iqcsih3SAyH6cAwhX9RFD48TE63OOYKtrwEIKlirSjiEjo5.ttf -> GoogleSans-Regular-${PV}.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua_rENHsxJlGDuGo1OIlJfC6l_24rlCK1Yo_Iqcsih3SAyH6cAwhX9RFD48TE63OOYKtrw2IKlirSjiEjo5.ttf -> GoogleSans-Medium-${PV}.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua_rENHsxJlGDuGo1OIlJfC6l_24rlCK1Yo_Iqcsih3SAyH6cAwhX9RFD48TE63OOYKtrzaJ6lirSjiEjo5.ttf -> GoogleSans-SemiBold-${PV}.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua_rENHsxJlGDuGo1OIlJfC6l_24rlCK1Yo_Iqcsih3SAyH6cAwhX9RFD48TE63OOYKtrzjJ6lirSjiEjo5.ttf -> GoogleSans-Bold-${PV}.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua9rENHsxJlGDuGo1OIlL3L2JB874GPhFI9_IqmuRqGpjeaLi42kO8QpnQOs5beU3yksanMY0EhpyzAFyo5T4o.ttf -> GoogleSans17pt-Italic-${PV}.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua9rENHsxJlGDuGo1OIlL3L2JB874GPhFI9_IqmuRqGpjeaLi42kO8QpnQOs5beU3yksanMY3MhpyzAFyo5T4o.ttf -> GoogleSans17pt-MediumItalic-${PV}.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua9rENHsxJlGDuGo1OIlL3L2JB874GPhFI9_IqmuRqGpjeaLi42kO8QpnQOs5beU3yksanMY58mpyzAFyo5T4o.ttf -> GoogleSans17pt-SemiBoldItalic-${PV}.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua9rENHsxJlGDuGo1OIlL3L2JB874GPhFI9_IqmuRqGpjeaLi42kO8QpnQOs5beU3yksanMY6YmpyzAFyo5T4o.ttf -> GoogleSans17pt-BoldItalic-${PV}.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua9rENHsxJlGDuGo1OIlL3L2JB874GPhFI9_IqmuRqGpjeaLi42kO8QvnQOs5beU3yksanMY0EhpyzAFyo5T4o.ttf -> GoogleSans-Italic-${PV}.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua9rENHsxJlGDuGo1OIlL3L2JB874GPhFI9_IqmuRqGpjeaLi42kO8QvnQOs5beU3yksanMY3MhpyzAFyo5T4o.ttf -> GoogleSans-MediumItalic-${PV}.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua9rENHsxJlGDuGo1OIlL3L2JB874GPhFI9_IqmuRqGpjeaLi42kO8QvnQOs5beU3yksanMY58mpyzAFyo5T4o.ttf -> GoogleSans-SemiBoldItalic-${PV}.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua9rENHsxJlGDuGo1OIlL3L2JB874GPhFI9_IqmuRqGpjeaLi42kO8QvnQOs5beU3yksanMY6YmpyzAFyo5T4o.ttf -> GoogleSans-BoldItalic-${PV}.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4UaGrENHsxJlGDuGo1OIlI3JyJ98KhtH.ttf
		-> GoogleSans-VariableFont_GRAD,opsz,wght-${PV}.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4UaErENHsxJlGDuGo1OIlL3LwpteLwtHJlc.ttf
		-> GoogleSans-Italic-VariableFont_GRAD,opsz,wght-${PV}.ttf
"

S="${DISTDIR}"

LICENSE="OFL-1.1"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

FONT_SUFFIX="ttf"
