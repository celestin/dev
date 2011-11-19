<?php

?>
<html>
  <head>
    <title>Front Burner FBtracker</title>
    <style type="text/css">
      body {
        text-align:center;
        margin-top: 40px;
      }

      body, p {
        font-family: Arial;
      }

      h1 {
        background-color: #0066CC;
        color: white;
      }

      img {
        border: 0px;
      }

      a.app {
        background-color: #0066CC;
        color: white;
        padding: 2px;
        text-decoration: none;
      }

      a.app:hover {
        background-color: #0099CC;
      }

      #apps {
        width: 800px;
        margin-left: auto;
        margin-right: auto ;
      }

      #apps td {
        text-align: center;
        width: 20%;
      }

      #fblogo {
        text-align: left;
      }

    </style>
    <link rel="shortcut icon" href="img/favicon.ico">
  </head>
  <body>
    <div id="apps">
      <div id="fblogo"><img src="img/fb4.png"></div>
      <h1>FBtracker</h1>
      <table border=1 width="100%">

        <tr>
          <td><a href="bugs"><img src="img/buggie.png"></a></td>
          <td rowspan=3><img src="img/arrow1.png"></td>
          <td><a href="time"><img src="img/clocklogo.png"></a></td>
          <td rowspan=3><img src="img/arrow1.png"></td>
          <td><a href="invoice"><img src="img/bamboo.png"></a></td>
        </tr>

        <tr>
          <td><a class="app" href="bugs">Bugzilla</a><br/><b>Issue Tracking</b></td>
          <td><a class="app" href="time">Kimai</a><br/><b>Time Recording</b></td>
          <td><a class="app" href="invoice">Bamboo</a><br/><b>Invoicing</b></td>
        </tr>

        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td><a href="invoice/invgen.php">Generation &amp; Reports</a></td>
        </tr>

      </table>

      <table border=0 width="100%">

        <tr>
          <td><a href="http://frontburner.homeip.net:8081/dms/browse.php"><img src="img/knowledgetree.png"></a></td>
        </tr>

        <tr>
          <td><a class="app" href="http://frontburner.homeip.net:8081/dms/browse.php">DMS</a></td>
        </tr>

      </table>


    </div>

  </body>
</html>