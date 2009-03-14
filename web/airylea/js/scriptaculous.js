/* * * * * * * * * * * * * * * * * * * * * * * *
 * Airylea Motors Website
 * // script.aculo.us scriptaculous.js v1.8.1, Thu Jan 03 22:07:12 -0500 2008
 *
 * // Copyright (c) 2005-2007 Thomas Fuchs (http://script.aculo.us, http://mir.aculo.us)
 * //
 * // Permission is hereby granted, free of charge, to any person obtaining
 * // a copy of this software and associated documentation files (the
 * // "Software"), to deal in the Software without restriction, including
 * // without limitation the rights to use, copy, modify, merge, publish,
 * // distribute, sublicense, and/or sell copies of the Software, and to
 * // permit persons to whom the Software is furnished to do so, subject to
 * // the following conditions:
 * //
 * // The above copyright notice and this permission notice shall be
 * // included in all copies or substantial portions of the Software.
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  14-Mar-2009  10334 : File added.
 * * * * * * * * * * * * * * * * * * * * * * * */

var Scriptaculous = {
  Version: '1.8.1',
  require: function(libraryName) {
    // inserting via DOM fails in Safari 2.0, so brute force approach
    document.write('<script type="text/javascript" src="'+libraryName+'"><\/script>');
  },
  REQUIRED_PROTOTYPE: '1.6.0',
  load: function() {
    function convertVersionString(versionString){
      var r = versionString.split('.');
      return parseInt(r[0])*100000 + parseInt(r[1])*1000 + parseInt(r[2]);
    }

    if((typeof Prototype=='undefined') ||
       (typeof Element == 'undefined') ||
       (typeof Element.Methods=='undefined') ||
       (convertVersionString(Prototype.Version) <
        convertVersionString(Scriptaculous.REQUIRED_PROTOTYPE)))
       throw("script.aculo.us requires the Prototype JavaScript framework >= " +
        Scriptaculous.REQUIRED_PROTOTYPE);

    $A(document.getElementsByTagName("script")).findAll( function(s) {
      return (s.src && s.src.match(/scriptaculous\.js(\?.*)?$/))
    }).each( function(s) {
      var path = s.src.replace(/scriptaculous\.js(\?.*)?$/,'');
      var includes = s.src.match(/\?.*load=([a-z,]*)/);
      (includes ? includes[1] : 'builder,effects,dragdrop,controls,slider,sound').split(',').each(
       function(include) { Scriptaculous.require(path+include+'.js') });
    });
  }
}

Scriptaculous.load();