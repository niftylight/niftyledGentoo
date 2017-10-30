# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools

DESCRIPTION="libniftyled runtime loadable plugins"
HOMEPAGE="http://wiki.niftylight.de/Hardware-plugins"
# removed git:// style URI due to security reasons
EGIT_REPO_URI="https://github.com/niftylight/niftyled-plugins.git"
#EGIT_COMMIT="master"
#EGIT_BRANCH="${EGIT_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="debug lpd8806-spi niftylino arduino usb"

DOCS=( NEWS README.md AUTHORS ChangeLog )

RDEPEND="media-gfx/niftyled"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

REQUIRED_USE="
	niftylino? ( usb )"

src_prepare()
{
	default
	eautoreconf
}

src_unpack()
{
	git-r3_src_unpack
}

src_configure()
{
	econf \
		$(use_enable debug) \
		$(use_enable niftylino plugin-niftylino) \
		$(use_enable arduino plugin-arduino-72xx) \
		$(use_enable lpd8806-spi plugin-lpd8806-spi)
}

src_install()
{
	emake DESTDIR="${D}" install
	einstalldocs
}
