  <script Language="Javascript">
  <!--
	function isInt(entered)
	{
		with (entered)
		{
			checkvalue = parseInt(value) ;

			if (value!=checkvalue)
			{
				value=0 ;
				return true ;
			}

			if (value<0)
			{
				value=0 ;
				return true ;
			}
			else
			{
				return true ;
			}
		}
	}

	function verify(entered)
	{
		if (isInt(entered))
		{
			window.document.buy.action = "/cgi-bin/buy.pl" ;
			window.document.buy.submit.value = "Calculate" ;
		}
	}

	function doCalc()
	{
		window.document.buy.action = "/cgi-bin/buy.pl" ;
		window.document.buy.submit.value = "Calculate" ;
	}
  //-->
  </script>
