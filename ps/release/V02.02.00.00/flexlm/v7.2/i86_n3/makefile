#
# FLEXLM makefile for PCs
# If you have a real kit, change DAEMON=demo.exe below to your real
# vendor daemon name
# Use nmake DLL=1 for dll clients
# Use nmake MD=1 for dynamic runtime library: msvcrt.lib
#
DAEMON = demo.exe

SRCDIR = ..\machind
!ifdef DEBUG
XTRACFLAG=/Zi 
LDFLAGS=/DEBUG
CNAME=d
!else
XTRACFLAG = 
LDFLAGS = 
CNAME=
!endif

LD = LINK /nologo /NODEFAULTLIB /OPT:NOREF $(LDFLAGS)
RC = RC

INCFLAGS = /I$(SRCDIR) /I.
!ifdef DLL
LMGRNAME=327b
MDNAME=
DLL_FLAG=/DFLEXLM_DLL
CRT_LIB=libcmt$(CNAME).lib
LMNEW_OBJ=lm_new.obj
CRT_FLAG=/MT$(CNAME)
!else
!ifdef MD
LMGRNAME=_md
LMNEW_OBJ=lm_new_md.obj 
CRT_FLAG=/MD$(CNAME)
CRT_LIB=msvcrt$(CNAME).lib 
!else
LMGRNAME=

CRT_FLAG=/MT$(CNAME)
LMNEW_OBJ=lm_new.obj
CRT_LIB=libcmt$(CNAME).lib
!endif

MDNAME=$(LMGRNAME)

!endif

LMGR_LIB=lmgr$(LMGRNAME).lib





XTRALIB1 =  oldnames.lib kernel32.lib user32.lib netapi32.lib \
        advapi32.lib  gdi32.lib comdlg32.lib  comctl32.lib wsock32.lib

XTRALIB =  $(XTRALIB1) $(CRT_LIB)

XTRACFLAG=$(XTRACFLAG) $(DLL_FLAG)

#
#	Use XTRAOBJS to define your object files for vendor daemon
#	initialization routines, checkout filter, checkin callback, etc.
#
XTRAOBJS = 


CFLAGS_NOOPT = /nologo /c  $(INCFLAGS) $(CRT_FLAG) $(XTRACFLAG)
CFLAGS = $(CFLAGS_NOOPT) /O1
LMNEW_CFLAGS = /nologo /c  $(INCFLAGS) $(CRT_FLAG)

SRCS	= $(SRCDIR)/lsvendor.c


EXECS = lmsimple.exe lmflex.exe lmwin.exe makekey.exe makepkg.exe lmclient.exe lmcrypt.exe lmfeats.exe lmstrip.exe installs.exe

CLIENTLIB	= $(LMGR_LIB) libsb$(MDNAME).lib libcrvs$(MDNAME).lib \
			flock$(MDNAME).lib
STATIC_CLIENTLIB = lmgr$(MDNAME).lib libsb$(MDNAME).lib \
			libcrvs$(MDNAME).lib flock$(MDNAME).lib
LIBS		= lmgras.lib lmgrs.lib $(STATIC_CLIENTLIB)

DAEMONLIBS		= lmgras.lib lmgrs.lib lmgr.lib libsb.lib libcrvs.lib


all: lmwin.res $(EXECS) $(DAEMON) utils 


daemon:	$(DAEMON)

$(DAEMON):	$(XTRAOBJS) $(LIBS) lsvendor.obj $(SRCDIR)/lsserver.h \
        		lm_new.obj
        $(LD) /subsystem:console /out:$(DAEMON) lsvendor.obj lm_new.obj \
            $(XTRAOBJS) $(DAEMONLIBS) $(XTRALIB1) libcmt.lib
 
lsvendor.obj: lm_new.obj
        $(CC) $(CFLAGS) -I../h lsrvend.c 
	if exist lsvendor.obj del lsvendor.obj
        ren lsrvend.obj lsvendor.obj
 
$(LMNEW_OBJ): $(SRCDIR)/lsvendor.c $(SRCDIR)\lm_code.h $(CLIENTLIB)
	lmrand1 -i $(SRCDIR)/lsvendor.c
	$(CC) /c $(LMNEW_CFLAGS) -I../h lmcode.c
	$(LD) /subsystem:CONSOLE lmrand2.obj lmcode.obj \
        lmgr$(MDNAME).lib libcrvs.lib libsb.lib $(XTRALIB1) $(CRT_LIB) /out:lmrand2.exe
	if exist lm_new.c del lm_new.c
	lmrand2.exe $(DAEMON)  -o lm_new.c
    $(CC) $(LMNEW_CFLAGS) /Fo$(LMNEW_OBJ) lm_new.c 


makekey.exe:	$(SRCDIR)\makekey.c $(SRCDIR)\lm_code.h lm_new.obj \
				$(SRCDIR)/lmclient.h $(STATIC_CLIENTLIB)
	$(CC) $(CFLAGS) $(SRCDIR)/makekey.c
	$(LD) /out:makekey.exe makekey.obj $(STATIC_CLIENTLIB) $(XTRALIB)
	if exist makekey.obj del makekey.obj

makepkg.exe:	$(SRCDIR)/makepkg.c lm_new.obj \
				$(SRCDIR)/lmclient.h $(STATIC_CLIENTLIB)
	$(CC) $(CFLAGS) $(SRCDIR)/makepkg.c
	$(LD) /out:makepkg.exe makepkg.obj $(STATIC_CLIENTLIB) $(XTRALIB)
	if exist makepkg.obj del makepkg.obj

lmcrypt.exe: $(SRCDIR)/lmcrypt.c \
		$(SRCDIR)/lmclient.h $(SRCDIR)\lm_code.h $(STATIC_CLIENTLIB) 
	$(CC) $(CFLAGS) $(SRCDIR)/lmcrypt.c
	$(LD) /out:lmcrypt.exe lmcrypt.obj $(STATIC_CLIENTLIB) $(XTRALIB)

validdat.exe:	$(SRCDIR)/validdat.c  $(CLIENTLIB)
	$(CC) $(CFLAGS) $(SRCDIR)/validdat.c
	$(LD) /out:validdat.exe validdat.obj $(CLIENTLIB) $(XTRALIB)
	if exist validdat.obj del validdat.obj

lmclient.exe:	$(SRCDIR)/lmclient.c  $(LMNEW_OBJ) \
				$(CLIENTLIB) lmstrip.exe
	$(CC) $(CFLAGS) $(SRCDIR)/lmclient.c
	$(LD) /out:lmclient.exe lmclient.obj $(LMNEW_OBJ) $(CLIENTLIB) $(XTRALIB)
	if exist lmclient.obj del lmclient.obj

lmsimple.exe:	$(SRCDIR)/lmsimple.c  $(LMNEW_OBJ) \
				$(CLIENTLIB) lmstrip.exe
	$(CC) $(CFLAGS) $(SRCDIR)/lmsimple.c
	$(LD) /out:lmsimple.exe lmsimple.obj $(LMNEW_OBJ)\
			$(CLIENTLIB) $(XTRALIB)
	if exist lmsimple.obj del lmsimple.obj


lmwin.exe:	$(SRCDIR)/lmwin.c  $(LMNEW_OBJ)
        $(CC) $(CFLAGS) /Zi $(SRCDIR)/lmwin.c
	$(RC) $(SRCDIR)/lmwin.rc
        $(LD) /out:lmwin.exe lmwin.obj $(LMNEW_OBJ) \
                    $(SRCDIR)\lmwin.res $(CLIENTLIB) $(XTRALIB) 
	if exist lmwin.obj del lmwin.obj

lmflex.exe:	$(SRCDIR)/lmflex.c  $(LMNEW_OBJ) \
				$(CLIENTLIB) lmstrip.exe
	$(CC) $(CFLAGS) $(SRCDIR)/lmflex.c
	$(LD) /out:lmflex.exe lmflex.obj $(LMNEW_OBJ) $(CLIENTLIB) $(XTRALIB)
	if exist lmflex.obj del lmflex.obj

lmfeats.exe: $(SRCDIR)/lmfeats.c $(CLIENTLIB)  
	$(CC) $(CFLAGS) $(SRCDIR)/lmfeats.c
	$(LD) /out:lmfeats.exe lmfeats.obj $(CLIENTLIB) $(XTRALIB)
	if exist lmfeats.obj del lmfeats.obj

lmstrip.exe: $(SRCDIR)/lmstrip.c
        $(CC) $(CFLAGS) $(SRCDIR)/lmstrip.c
        $(LD) /out:lmstrip.exe lmstrip.obj $(XTRALIB)
	if exist lmstrip.obj del lmstrip.obj

installs.exe: $(SRCDIR)/installs.c
        $(CC) $(CFLAGS) $(SRCDIR)/installs.c
        $(LD) /out:installs.exe installs.obj $(XTRALIB)
	if exist installs.obj del installs.obj

lmwin.res: $(SRCDIR)\lmwin.rc
        rc /l 0x409 /r /folmwin.res $(SRCDIR)/lmwin.rc
clean:;	
        if exist lmrand2.obj ren lmrand2.obj lmrand2.sav
        if exist *.obj del *.obj
        if exist lmrand2.sav ren lmrand2.sav lmrand2.obj
        if exist makekey.exe del makekey.exe 
        if exist lmrand2.exe del lmrand2.exe
        if exist makepkg.exe del makepkg.exe 
        if exist lmclient.exe del lmclient.exe 
        if exist lmcrypt.exe del lmcrypt.exe 
        if exist lmfeats.exe del lmfeats.exe 
        if exist lmstrip.exe del lmstrip.exe
        if exist $(DAEMON) del $(DAEMON)
        if exist lmcode.c del lmcode.c 
        if exist lmcode.obj del lmcode.obj 
        if exist lm_new.c del lm_new*.c 
        if exist lm_new.obj del lm_new*.obj 
        if exist lsrvend.c del lsrvend.c 
        if exist lmflex.exe del lmflex.exe
        if exist lmsimple.exe del lmsimple.exe
        if exist lmwin.exe del lmwin.exe
	if exist $(SRCDIR)\lmwin.res del $(SRCDIR)\lmwin.res
	if exist *.ilk del *.ilk
	if exist *.p* del *.p*
	if exist *.res del *.res

veryclean:
	if exist lmhostid.exe del lmhostid.exe
	if exist lmver.exe del lmver.exe
	if exist lmcksum.exe del lmcksum.exe
	if exist lmdown.exe del lmdown.exe
	if exist lmremove.exe del lmremove.exe
	if exist lmreread.exe del lmreread.exe
	if exist lmswitchr.exe del lmswitchr.exe
	if exist lmstat.exe del lmstat.exe
	if exist lmdiag.exe del lmdiag.exe
	if exist lminstall.exe del lminstall.exe
        $(MAKE) clean

kitclean:
	if exist lmcode.c del lmcode.c
	if exist lmcode.obj del lmcode.obj
	if exist lmcrypt.obj del lmcrypt.obj
	if exist lmrand2.exe del lmrand2.exe
	if exist lm_new.c del lm_new.c
	if exist lm_new.obj del lm_new.obj
	if exist lsvendor.obj del lsvendor.obj
	if exist lmhostid.exe del lmhostid.exe
	if exist lmver.exe del lmver.exe
	if exist lmcksum.exe del lmcksum.exe
	if exist lmdown.exe del lmdown.exe
	if exist lmhostid.exe del lmhostid.exe
	if exist lminstall.exe del lminstall.exe
	if exist lmremove.exe del lmremove.exe
	if exist lmreread.exe del lmreread.exe
	if exist  lmswitchr.exe del  lmswitchr.exe
	if exist lmstat.exe del lmstat.exe
	if exist lmdiag.exe del lmdiag.exe
	if exist lmver.exe  del lmver.exe 
        



lmcrypt.obj:	$(SRCDIR)/lmcrypt.c $(SRCDIR)\lm_code.h $(SRCDIR)/lmclient.h
	$(CC) $(CFLAGS) $(SRCDIR)/lmcrypt.c
	if exist lmcrypt.exe del lmcrypt.exe

utils:	lmhostid.exe lmver.exe lmcksum.exe lmdown.exe lmremove.exe lmreread.exe lmswitchr.exe lmstat.exe lmdiag.exe lminstall.exe

lmhostid.exe:   lmutil.exe
    copy lmutil.exe lmhostid.exe

lmver.exe:   lmutil.exe
    copy lmutil.exe lmver.exe

lmcksum.exe:   lmutil.exe
    copy lmutil.exe lmcksum.exe

lmdown.exe:   lmutil.exe
    copy lmutil.exe lmdown.exe

lmremove.exe:   lmutil.exe
    copy lmutil.exe lmremove.exe

lmswitchr.exe:   lmutil.exe
    copy lmutil.exe lmswitchr.exe

lmreread.exe:   lmutil.exe
    copy lmutil.exe lmreread.exe

lmstat.exe:   lmutil.exe
    copy lmutil.exe lmstat.exe

lmdiag.exe:   lmutil.exe
    copy lmutil.exe lmdiag.exe

lminstall.exe:   lmutil.exe
    copy lmutil.exe lminstall.exe

        copy lmutil.exe lmhostid.exe
        copy lmutil.exe lmver.exe
        copy lmutil.exe lmcksum.exe
        copy lmutil.exe lmdown.exe
        copy lmutil.exe lmremove.exe
        copy lmutil.exe lmreread.exe
        copy lmutil.exe lmswitchr.exe
        copy lmutil.exe lmstat.exe
        copy lmutil.exe lmdiag.exe
        copy lmutil.exe lminstall.exe


