  <script Language="Javascript">
  <!--
	function refreshForm() {
	  // Call this form again, to refresh fields
	  var frmDetails = document.forms['details'] ;
	  document.forms.details.elements.state.value = "" ;

	  frmDetails.action = "/cgi-bin/details.pl" ;
	  frmDetails.submit() ;
	}

	function recordCountryName() {
	  var selCountry = document.forms.details.elements.countryex ;
      var txtCountryName = document.forms.details.elements.countryname ;

	  txtCountryName.value = selCountry.options[selCountry.selectedIndex].text ;
	}

	function validateField(fldValue) {
	  var retval=0 ;
	  for(var i=0; i<fldValue.length; i++) {
	    if (fldValue[i] != ' ') {
	      //retval++ ;
	      return true ;
	    }
	  }

	  //return (retval>0) ;
	  return false ;
	}

	function validateForm() {
	  // Call this form again, to refresh fields
	  var frmDetails = document.forms['details'] ;
	  var validForm=true ;
      var countryGroup = new String(frmDetails.countryex.value) ;
      countryGroup = countryGroup.substr(0,1) ;

	  if (!validateField(frmDetails.name.value)) validForm=false ;
	  if (!validateField(frmDetails.email.value)) validForm=false ;
	  if (!validateField(frmDetails.company.value)) validForm=false ;
	  if ((countryGroup == '1') && (!validateField(frmDetails.vatno.value))) validForm=false ;
	  if (!validateField(frmDetails.street.value)) validForm=false ;
	  if (!validateField(frmDetails.city.value)) validForm=false ;
	  if (!validateField(frmDetails.state.value)) validForm=false ;
	  if (!validateField(frmDetails.postcode.value)) validForm=false ;
	  if (!validateField(frmDetails.tel.value)) validForm=false ;
	  if (!validateField(frmDetails.fax.value)) validForm=false ;

	  if (validForm) {
	    recordCountryName() ;
	    frmDetails.submit() ;
	  } else {
	    frmDetails.action = "/cgi-bin/details.pl" ;
	    frmDetails.submit() ;
	  }
	}
  //-->
  </script>
