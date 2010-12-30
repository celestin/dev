{cycle values="odd,even" reset=true print=false}
{if $arr_exp}
        <div id="exptable">
        
          <table>
              
            <colgroup>
              <col class="option" />
              <col class="date" />
              <col class="time" />
              <col class="value" />
              <col class="client" />
              <col class="project" />
              <col class="designation" />
            </colgroup>

            <tbody>
                
{section name=row loop=$arr_exp}

                <tr id="expEntry{$arr_exp[row].exp_ID}" class="{cycle values="odd,even"}">
               
{*--OPTIONS-----------------------------------------------------*}
                    <td nowrap class="option">

{* only users can see options *}
{if $kga.usr}

                        
{*Edit Record Button *}
                        {strip}<a href ='#' onClick="exp_editRecord({$arr_exp[row].exp_ID}); $(this).blur(); return false;" title='{$kga.lang.edit}'>
                            <img src='../skins/{$kga.conf.skin}/grfx/edit2.gif' width='13' height='13' alt='{$kga.lang.edit}' title='{$kga.lang.edit}' border='0' />
                        </a>{/strip}
                        

    {* quick erase trashcan *}
    {if $kga.conf.quickdelete == 1}
                        {strip}<a href ='#' class='quickdelete' onClick="exp_quickdelete({$arr_exp[row].exp_ID}); return false;">
                            <img src='../skins/{$kga.conf.skin}/grfx/button_trashcan.png' width='13' height='13' alt='{$kga.lang.quickdelete}' title='{$kga.lang.quickdelete}' border=0 />
                        </a>{/strip}
    {/if}


{/if}

{*--/OPTIONS----------------------------------------------------*}
                    
                    </td>                   

{*datum --------------------------------------------------------*}

                    <td class="date">
                        {$arr_exp[row].exp_timestamp|date_format:$kga.date_format.1}
                    </td>

{*time ---------------------------------------------------------*}

                    <td class="time">
                        {$arr_exp[row].exp_timestamp|date_format:"%H:%M"}
                    </td>

{*value --------------------------------------------------------*}

                    <td class="value">
                        {$arr_exp[row].exp_value|replace:'.':$kga.conf.decimalSeparator}
                    </td>

{*client name --------------------------------------------------*}

                    <td class="knd">
                        {$arr_exp[row].knd_name}
                    </td>

{*project name -------------------------------------------------*}

                    <td class="pct">
                            {$arr_exp[row].pct_name}
                    </td>


{*designation and comment bubble -------------------------------*}

                    <td class="designation">
                            {$arr_exp[row].exp_designation}
                        
{if $arr_exp[row].exp_comment}
    {if $arr_exp[row].exp_comment_type == '0'}
                        <a href="#" onClick="exp_comment({$arr_exp[row].exp_ID}); $(this).blur(); return false;"><img src='../skins/{$kga.conf.skin}/grfx/blase.gif' width="12" height="13" title='{$arr_exp[row].exp_comment}' border="0" /></a>
    {/if}
    {if $arr_exp[row].exp_comment_type == '1'}
                        <a href="#" onClick="exp_comment({$arr_exp[row].exp_ID}); $(this).blur(); return false;"><img src='../skins/{$kga.conf.skin}/grfx/blase_sys.gif' width="12" height="13" title='{$arr_exp[row].exp_comment}' border="0" /></a>
    {/if}
    {if $arr_exp[row].exp_comment_type == '2'}
                        <a href="#" onClick="exp_comment({$arr_exp[row].exp_ID}); $(this).blur(); return false;"><img src='../skins/{$kga.conf.skin}/grfx/blase_caution.gif' width="12" height="13" title='{$arr_exp[row].exp_comment}' border="0" /></a>
    {/if}
{/if}
                    </td>

                </tr>
                
                <tr id="exp_c{$arr_exp[row].exp_ID}" class="comm{$arr_exp[row].exp_comment_type}" style="display:none;">
                    <td colspan=8>{$arr_exp[row].exp_comment|nl2br}</td>
                </tr>
               
{/section}
                
            </tbody>   
        </table>
    </div>  
{else}
<div style='padding:5px;color:#f00'>
    <strong>{$kga.lang.noEntries}</strong>
</div>
{/if}

<script type="text/javascript"> 
    exp_usr_ann = null;
    exp_knd_ann = null;
    exp_pct_ann = null;
    exp_evt_ann = null;
    exp_total = '{$total}';

    { if $usr_ann }
    exp_usr_ann = new Array();
    {foreach key=id item=value from=$usr_ann}
      exp_usr_ann[{$id}] = "{$value}";
    {/foreach}
    {/if}

    { if $knd_ann }
    exp_knd_ann = new Array();
    {foreach key=id item=value from=$knd_ann}
      exp_knd_ann[{$id}] = "{$value}";
    {/foreach}
    {/if}

    { if $pct_ann }
    exp_pct_ann = new Array();
    {foreach key=id item=value from=$pct_ann}
      exp_pct_ann[{$id}] = "{$value}";
    {/foreach}
    {/if}

    { if $evt_ann }
    exp_evt_ann = new Array();
    {foreach key=id item=value from=$evt_ann}
      exp_evt_ann[{$id}] = "{$value}";
    {/foreach}
    {/if}
    
    {literal}
    lists_update_annotations(parseInt($('#gui div.ki_expenses').attr('id').substring(7)),exp_usr_ann,exp_knd_ann,exp_pct_ann,exp_evt_ann);
    $('#display_total').html(exp_total);
    {/literal}
    
</script>