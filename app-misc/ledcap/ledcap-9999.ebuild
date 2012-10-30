# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit git autotools

DESCRIPTION="niftyled screen capture tool"
HOMEPAGE="http://wiki.niftylight.de/ledcap"
EGIT_REPO_URI="http://github.com/niftylight/ledcap.git"
#EGIT_COMMIT="master"
#EGIT_BRANCH="${EGIT_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"

IUSE="debug"

RDEPEND="sys-libs/glibc
	dev-libs/niftyled
	media-libs/imlib2
	x11-libs/libX11"

DEPEND="${RDEPEND} 
	virtual/pkgconfig"


src_prepare()
{
	eautoreconf
}

src_unpack()
{
	git_src_unpack
	git_submodules init
	git_submodules update
}

src_configure() 
{
	# debugging symbols?
	if use debug ; then
		myconf+=" --enable-debug"
	else
		myconf+=" --disable-debug"
	fi

	econf ${myconf}
}

src_install() {
    emake DESTDIR="${D}" install

    dodoc NEWS README COPYING AUTHORS ChangeLog
}
