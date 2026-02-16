# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Package version is based on
# fc-query --format '%{fontversion}\n' <filename>

EAPI=8

inherit font

DESCRIPTION="Current generation of Google’s brand typeface."
HOMEPAGE="https://fonts.google.com/specimen/Google+Sans"

SRC_URI="
	https://fonts.gstatic.com/s/googlesans/v67/4Ua_rENHsxJlGDuGo1OIlJfC6l_24rlCK1Yo_Iqcsih3SAyH6cAwhWdRFD48TE63OOYKtrwEIKlirSjiEjo5.ttf -> GoogleSans17pt-Regular.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua_rENHsxJlGDuGo1OIlJfC6l_24rlCK1Yo_Iqcsih3SAyH6cAwhWdRFD48TE63OOYKtrw2IKlirSjiEjo5.ttf -> GoogleSans17pt-Medium.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua_rENHsxJlGDuGo1OIlJfC6l_24rlCK1Yo_Iqcsih3SAyH6cAwhWdRFD48TE63OOYKtrzaJ6lirSjiEjo5.ttf -> GoogleSans17pt-SemiBold.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua_rENHsxJlGDuGo1OIlJfC6l_24rlCK1Yo_Iqcsih3SAyH6cAwhWdRFD48TE63OOYKtrzjJ6lirSjiEjo5.ttf -> GoogleSans17pt-Bold.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua_rENHsxJlGDuGo1OIlJfC6l_24rlCK1Yo_Iqcsih3SAyH6cAwhX9RFD48TE63OOYKtrwEIKlirSjiEjo5.ttf -> GoogleSans-Regular.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua_rENHsxJlGDuGo1OIlJfC6l_24rlCK1Yo_Iqcsih3SAyH6cAwhX9RFD48TE63OOYKtrw2IKlirSjiEjo5.ttf -> GoogleSans-Medium.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua_rENHsxJlGDuGo1OIlJfC6l_24rlCK1Yo_Iqcsih3SAyH6cAwhX9RFD48TE63OOYKtrzaJ6lirSjiEjo5.ttf -> GoogleSans-SemiBold.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua_rENHsxJlGDuGo1OIlJfC6l_24rlCK1Yo_Iqcsih3SAyH6cAwhX9RFD48TE63OOYKtrzjJ6lirSjiEjo5.ttf -> GoogleSans-Bold.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua9rENHsxJlGDuGo1OIlL3L2JB874GPhFI9_IqmuRqGpjeaLi42kO8QpnQOs5beU3yksanMY0EhpyzAFyo5T4o.ttf -> GoogleSans17pt-Italic.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua9rENHsxJlGDuGo1OIlL3L2JB874GPhFI9_IqmuRqGpjeaLi42kO8QpnQOs5beU3yksanMY3MhpyzAFyo5T4o.ttf -> GoogleSans17pt-MediumItalic.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua9rENHsxJlGDuGo1OIlL3L2JB874GPhFI9_IqmuRqGpjeaLi42kO8QpnQOs5beU3yksanMY58mpyzAFyo5T4o.ttf -> GoogleSans17pt-SemiBoldItalic.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua9rENHsxJlGDuGo1OIlL3L2JB874GPhFI9_IqmuRqGpjeaLi42kO8QpnQOs5beU3yksanMY6YmpyzAFyo5T4o.ttf -> GoogleSans17pt-BoldItalic.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua9rENHsxJlGDuGo1OIlL3L2JB874GPhFI9_IqmuRqGpjeaLi42kO8QvnQOs5beU3yksanMY0EhpyzAFyo5T4o.ttf -> GoogleSans-Italic.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua9rENHsxJlGDuGo1OIlL3L2JB874GPhFI9_IqmuRqGpjeaLi42kO8QvnQOs5beU3yksanMY3MhpyzAFyo5T4o.ttf -> GoogleSans-MediumItalic.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua9rENHsxJlGDuGo1OIlL3L2JB874GPhFI9_IqmuRqGpjeaLi42kO8QvnQOs5beU3yksanMY58mpyzAFyo5T4o.ttf -> GoogleSans-SemiBoldItalic.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4Ua9rENHsxJlGDuGo1OIlL3L2JB874GPhFI9_IqmuRqGpjeaLi42kO8QvnQOs5beU3yksanMY6YmpyzAFyo5T4o.ttf -> GoogleSans-BoldItalic.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4UaGrENHsxJlGDuGo1OIlI3JyJ98KhtH.ttf
		-> GoogleSans-VariableFont_GRAD,opsz,wght.ttf
	https://fonts.gstatic.com/s/googlesans/v67/4UaErENHsxJlGDuGo1OIlL3LwpteLwtHJlc.ttf
		-> GoogleSans-Italic-VariableFont_GRAD,opsz,wght.ttf
"

S="${DISTDIR}"

LICENSE="OFL-1.1"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

FONT_SUFFIX="ttf"
