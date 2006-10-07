<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * New Search form
 * Copyright (c) 2006 frontburner.co.uk
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  30-Sep-2006  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

include_once 'Main.php';

global $make,$model,$variant,$keywords,$min_pr,$max_pr,$mileage,$agerange,$postcode,$miles,$source,$retry,$form_error,$search;
?>

<!--
<Script type="text/javascript" language="javascript" src="http://www.autotrader.co.uk/CARS/common/_make_model.js"></Script>
-->
<Script type="text/javascript" language="javascript" src="js/make_model.js"></Script>
<Script type="text/javascript" language="javascript" src="js/car.js"></Script>

<table align=center border=1 cellpadding=5 cellspacing=0>
<form name="qSearch" action="new.search.php" onSubmit="return checkKeywords();" method="post">
  <input type="hidden" value="3" name="sort" checked>
  <input type="hidden" value="200" name="max_records">
  <input type="hidden" value="1" name="retry">
  <input type="hidden" value="<? echo $search; ?>" name="search">

  <tr>

    <td colspan=4><div class="head">Vehicle details</div></td>
    <td colspan=2><div class="head">Your details</div></td>

  </tr><tr>
    <td class="lbl">Make</td>
    <td><select name="make" id="make" onchange="get_range(_model[this.selectedIndex], 'ANY');" style="display:none">
          <option>&nbsp;</option>
        </select></td>

    <td class="lbl">Min. Price</td>
    <td><select name="min_pr" id="min_pr" style="display:none">
          <option value="75">Any</option>
          <option value="500">£500</option>
          <option value="1000">£1000</option>
          <option value="2000">£2000</option>
          <option value="3000">£3000</option>
          <option value="4000">£4000</option>
          <option value="5000">£5000</option>
          <option value="6000">£6000</option>
          <option value="7000">£7000</option>
          <option value="8000">£8000</option>
          <option value="9000">£9000</option>
          <option value="10000">£10000</option>
          <option value="11000">£11000</option>
          <option value="12000">£12000</option>
          <option value="13000">£13000</option>
          <option value="14000">£14000</option>
          <option value="15000">£15000</option>
          <option value="16000">£16000</option>
          <option value="17000">£17000</option>
          <option value="18000">£18000</option>
          <option value="19000">£19000</option>
          <option value="20000">£20000</option>
          <option value="22500">£22500</option>
          <option value="25000">£25000</option>
          <option value="27500">£27500</option>
          <option value="30000">£30000</option>
          <option value="35000">£35000</option>
          <option value="40000">£40000</option>
          <option value="50000">£50000</option>
          <option value="75000">£75000</option>
          <option value="100000">£100000</option>
          <option value="150000">£150000</option>
          <option value="250000">£250000</option>
          <option value="500000">£500000</option>
          <option value="1000000">£1000000</option>
        </select></td>

    <td class="lbl">Postcode</td>
    <td><input type="text" size="5" name="postcode" value="<? echo $postcode; ?>"></td>


  </tr><tr>
    <td class="lbl">Model</td>
    <td><select name="model" id="model" style="width: 160px;" style="display:none">
          <option>&nbsp;</option>
        </select></td>

    <td class="lbl">Max. Price</td>
    <td><select name="max_pr" id="max_pr" style="display:none">
          <option value="0">Any</option>
          <option value="500">£500</option>
          <option value="1000">£1000</option>
          <option value="2000">£2000</option>
          <option value="3000">£3000</option>
          <option value="4000">£4000</option>
          <option value="5000">£5000</option>
          <option value="6000">£6000</option>
          <option value="7000">£7000</option>
          <option value="8000">£8000</option>
          <option value="9000">£9000</option>
          <option value="10000">£10000</option>
          <option value="11000">£11000</option>
          <option value="12000">£12000</option>
          <option value="13000">£13000</option>
          <option value="14000">£14000</option>
          <option value="15000">£15000</option>
          <option value="16000">£16000</option>
          <option value="17000">£17000</option>
          <option value="18000">£18000</option>
          <option value="19000">£19000</option>
          <option value="20000">£20000</option>
          <option value="22500">£22500</option>
          <option value="25000">£25000</option>
          <option value="27500">£27500</option>
          <option value="30000">£30000</option>
          <option value="35000">£35000</option>
          <option value="40000">£40000</option>
          <option value="50000">£50000</option>
          <option value="75000">£75000</option>
          <option value="100000">£100000</option>
          <option value="150000">£150000</option>
          <option value="250000">£250000</option>
          <option value="500000">£500000</option>
          <option value="1000000">£1000000</option>
          <option value="3000000">up to £3000000</option>
        </select></td>

    <td class="lbl">Distance</td>
    <td><select name="miles" id="miles" style="display:none">
          <option value="1">1 mile</option>
          <option value="10">10 miles</option>
          <option value="20">20 miles</option>
          <option value="30">30 miles</option>
          <option value="40" selected>40 miles</option>
          <option value="60">60 miles</option>
          <option value="100">100 miles</option>
          <option value="200">200 miles</option>
          <option value="1500">National</option>
        </select>

  </tr><tr>
    <td class="lbl">Trim</td>
    <td><input type="text" name="variant" size="20" value="<? echo $variant; ?>"></td>

    <td class="lbl">Max. Mileage</td>
    <td><select name="mileage" id="mileage" style="display:none">
          <option value="0">Any</option>
          <option value="1">up to 5,000</option>
          <option value="2">up to 10,000</option>
          <option value="3">up to 20,000</option>
          <option value="4">up to 40,000</option>
          <option value="5">up to 60,000</option>
          <option value="6">up to 80,000</option>
          <option value="8">up to 100,000</option>
          <option value="9">over 100,000</option>
        </select></td>

    <td colspan=2><div class="head">Seller details</div></td>

  </tr><tr>
    <td class="lbl">Keywords</td>
    <td><input type="text" name="keywords" size="20" value="<? echo $keywords; ?>"></td>

    <td class="lbl">Max. Age</td>
    <td><select name="agerange" id="agerange" style="display:none">
          <option value="0">Any</option>
          <option value="6">0 to 1 years</option>
          <option value="7">1 to 2 years</option>
          <option value="1">Up to 2 years</option>
          <option value="5">Up to 3 years</option>
          <option value="2">Up to 5 years</option>
          <option value="3">Up to 10 years</option>
          <option value="4">Over 10</option>
        </select></td>

    <td class="lbl">Type</td>
    <td><select name="source">
          <option value="0">Private &amp; Trade</option>
          <option value="1">Private</option>
          <option value="2">Trade</option>
        </select>

  </tr><tr>
    <td colspan=6 align=right><input class="button" type="submit" value="<? echo (!$search) ? 'Add' : 'Edit' ?>"></td>
  </tr>

</table>



</form>

<script type="text/javascript">
  var num=0;
  var interval = null;
  var mkIndex=0;

  function setupLists()  {
  num++;
    if (num < 100)  {
      if (typeof get_makes == 'function' && typeof get_range =='function' && typeof _model=='object' && typeof make_v=='object' && typeof make_d=='object')  {
        clearInterval(interval);
        get_makes('<? echo $make ?>');
        if (document.qSearch && document.qSearch.make && typeof document.qSearch.make.selectedIndex == 'number')  {
          mkIndex = document.qSearch.make.selectedIndex;
        }
        get_range(_model[mkIndex], '<? echo $model ?>');

        setDropValue('min_pr', '<? echo $min_pr ?>');
        setDropValue('max_pr', '<? echo $max_pr ?>');
        setDropValue('miles', '<? echo $miles ?>');
        setDropValue('agerange', '<? echo $agerange ?>');
        setDropValue('mileage', '<? echo $mileage ?>');

      }
    }
    else {
      clearInterval(interval);
    }
  }
  interval=setInterval("setupLists()", 100);
</script>


