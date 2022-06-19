PORTNAME=	vm-bhyve
PORTVERSION=	1.5.0.20220406
PKGNAMESUFFIX=  -devel
CATEGORIES=	sysutils

MAINTAINER=	churchers@gmail.com
COMMENT=	Management system for bhyve virtual machines

LICENSE=	BSD2CLAUSE
LICENSE_FILE=	${WRKSRC}/LICENSE

RUN_DEPENDS=	${LOCALBASE}/share/certs/ca-root-nss.crt:security/ca_root_nss

USE_GITHUB=	yes
GH_ACCOUNT=	churchers
GH_TAGNAME=     ec0e12e97465822d65ab32e791049d69791d49cb

NO_ARCH=	yes
NO_BUILD=	yes

CONFLICTS_INSTALL=      vm-bhyve


OPTIONS_DEFINE=		BHYVE_FIRMWARE EXAMPLES GRUB2_BHYVE TMUX
BHYVE_FIRMWARE_DESC=	Required to run UEFI guests
EXAMPLES_DESC=		Install example guest templates
GRUB2_BHYVE_DESC=	Required to run Linux or any other guests that need a Grub bootloader
TMUX_DESC=		Tmux console access instead of cu/nmdm

BHYVE_FIRMWARE_RUN_DEPENDS=	bhyve-firmware>0:sysutils/bhyve-firmware
GRUB2_BHYVE_RUN_DEPENDS=	grub2-bhyve>0:sysutils/grub2-bhyve
TMUX_RUN_DEPENDS=		tmux:sysutils/tmux

do-install:
	${INSTALL_SCRIPT} ${WRKSRC}/vm ${STAGEDIR}${PREFIX}/sbin
	${INSTALL_SCRIPT} ${WRKSRC}/rc.d/vm ${STAGEDIR}${PREFIX}/etc/rc.d
	(cd ${WRKSRC}/lib/ && ${COPYTREE_SHARE} . ${STAGEDIR}${PREFIX}/lib/vm-bhyve)
	(cd ${WRKSRC}/sample-templates/ && ${COPYTREE_SHARE} . ${STAGEDIR}${EXAMPLESDIR})
	${INSTALL_MAN} ${WRKSRC}/vm.8 ${STAGEDIR}${MAN8PREFIX}/man/man8

.include <bsd.port.mk>
