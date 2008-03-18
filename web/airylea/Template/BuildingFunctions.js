    function openInstructions(filename,category,item,winWidth,winHeight) {
      if (winWidth==null) winWidth='840';
      if (winHeight==null) winHeight='600';

      if (instWin) instWin.close() ;
      instWin = window.open(filename, 'INSTRUCTIONS', 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=1,width='+winWidth+',height='+winHeight);
    }

    function openBase(item,size) {
      var space = 30 ;
      var titleBar = 20 ;
      var winWidth = imgBase.width + imgThumb.width + space ;
      var winHeight = imgBase.height + titleBar + space ;

      if (baseWin) baseWin.close() ;
      baseWin = window.open('', 'BASE_SIZE', 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=1,width='+winWidth+',height='+winHeight);
      with (baseWin.document) {
        open() ;
        write("<html><head><title>" + buildingName + "</title><link href=./style.css rel=stylesheet type=text/css></head>") ;
        write("<body marginwidth=0 marginheight=0 topmargin=0 leftmargin=0 rightmargin=0>") ;
        write("<table width='100%' height='100%' border=0 cellpadding=4>") ;
        write("<tr class=navBg><td class=navText colspan=2 height=" + titleBar + "><b>" + buildingName + "</b></td></tr>") ;
        write("<tr height=\"100%\">") ;
        write("<td align=left valign=top><img src=\"" + imgThumb.src + "\"></td>") ;
        write("<td align=center valign=center><img src=\"" + imgBase.src + "\"></td>") ;
        write("</tr></table></body></html>") ;
        close();
      }
    }

