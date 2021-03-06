# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils

DESCRIPTION="Japanese input method Anthy IMEngine for SCIM"
HOMEPAGE="http://scim-imengine.sourceforge.jp/index.cgi?cmd=view;name=SCIMAnthy"
SRC_URI="mirror://sourceforge.jp/scim-imengine/37309/${P}.tar.gz
	https://dev.gentoo.org/~juippis/distfiles/tmp/scim-anthy-1.2.7-gtk2_build.patch
	gtk3?	( https://dev.gentoo.org/~heroxbd/${P}-patches.tar.xz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ppc sparc x86"
IUSE="+gtk3 nls kasumi"

DEPEND=">=app-i18n/scim-1.2[gtk3=]
	>=app-i18n/anthy-5900
	nls? ( virtual/libintl )
	gtk3? ( x11-libs/gtk+:3 )"
RDEPEND="${DEPEND}
	kasumi? ( app-dicts/kasumi )"
DEPEND="${DEPEND}
	nls? ( sys-devel/gettext )
	virtual/pkgconfig"

src_prepare() {
	default

	if use gtk3; then
		EPATCH_SOURCE="${WORKDIR}/patches" EPATCH_SUFFIX="patch" epatch
	else
		epatch "${DISTDIR}/${P}-gtk2_build.patch"
	fi

	eautoreconf
}

src_configure() {
	econf \
		$(use_enable nls) \
		--disable-static
}

src_install() {
	default
	dodoc AUTHORS ChangeLog NEWS README
}
