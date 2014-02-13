 <style type="text/css">
	.td_text {
		width: 120px;
		font-size: 14px;
	}
	.td_input {
		font-size:12px;
		height:20px;
		width: 205px;
	}
	.td_info {
		font-size: 14px;
		text-align: bottom;
	}
	.td_input input {
		width: 200px;
		border: 1px solid #000000;
	}
</style>
<script>
$(document).ready(function() {
    var elements = document.getElementsByTagName("INPUT");
    for (var i = 0; i < elements.length; i++) {
        elements[i].oninvalid = function(e) {
            e.target.setCustomValidity("");
            if (!e.target.validity.valid) {
               e.target.setCustomValidity(e.target.getAttribute("data-requiredmsg"));
            }
        };
        elements[i].oninput = function(e) {
            e.target.setCustomValidity("");
        };
    }
})
</script>

<form name="sampleorder" method="post" action="{$request_uri|escape:'htmlall':'UTF-8'}">

	<span style="font-size:14px;">Vill du testa en produkt eller två? Skicka en förfrågan om varuprov. <br></span><br>

	<table>
	<tr>
		<td class="td_text">Företag *</td>
		<td class="td_input"><input type="text" name="company" required autofocus data-requiredmsg="Du måste ange ett företagsnamn"/>
		</td>
	</tr>
	<tr>
		<td class="td_text">Org.nr/Person nr *</td>
		<td class="td_input"><input type="text" name="orgnr" required autofocus data-requiredmsg="Du måste ange ett org/person nummer"/>
		</td>
	</tr>
	<tr>
		<td class="td_text">Kontaktperson</td>
		<td class="td_input"><input type="text" name="contact"/></td> <!--required data-requiredmsg="Du måste ange en kontaktperson"  -->
	</tr>
	<tr>
		<td class="td_text">Adress *</td>
		<td class="td_input"><input type="text" name="address" required data-requiredmsg="Du måste ange en address" /></td>
	</tr>
	<tr>
		<td class="td_text">Postnr *</td>
		<td class="td_input"><input type="text" name="postal_code" required data-requiredmsg="Du måste ange ett postnr" /></td>
	</tr>
	<tr>
		<td class="td_text">Stad *</td>
		<td class="td_input"><input type="text" name="city" required data-requiredmsg="Du måste ange en stad" /></td>
	</tr>
	<tr>
		<td class="td_text">Telefon</td>
		<td class="td_input"><input type="tel" name="phone" /></td> <!--  required data-requiredmsg="Du måste ange ett telefonnummer" -->
	</tr>
	<tr>
		<td class="td_text">E-Mail *</td>
		<td class="td_input"><input type="email" name="email" required data-requiredmsg="Du måste ange en e-mail address" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2" class="td_info">Ange referensnummer nedan, t.e.x:  000002N</td>
	</tr>
	<tr>
		<td class="td_text">Varuprov 1*</td>
		<td class="td_input"><input type="text" name="sample1" required data-requiredmsg="Du måste fylla i varuprov 1" /></td>
	</tr>
	<tr>
		<td class="td_text">Varuprov 2</td>
		<td class="td_input"><input type="text" name="sample2" /></td>
	</tr>
	<tr>
		<td class="td_text">Varuprov 3</td>
		<td class="td_input"><input type="text" name="sample3" /></td>
	</tr>
	<tr>
		<td class="td_text">Varuprov 4</td>
		<td class="td_input"><input type="text" name="sample4" /></td>
	</tr>
	<tr>
		<td class="td_text">Varuprov 5</td>
		<td class="td_input"><input type="text" name="sample5" /></td>
	</tr>
	<tr>
		<td class="td_text">Varuprov 6</td>
		<td class="td_input"><input type="text" name="sample6" /></td>
	</tr>
	<tr>
		<td class="td_text">Varuprov 7</td>
		<td class="td_input"><input type="text" name="sample7" /></td>
	</tr>
	<tr>
		<td class="td_text">Varuprov 8</td>
		<td class="td_input"><input type="text" name="sample8" /></td>
	</tr>
	<tr>
		<td class="td_text">Varuprov 9</td>
		<td class="td_input"><input type="text" name="sample9" /></td>
	</tr>
	<tr>
		<td class="td_text">Varuprov 10</td>
		<td class="td_input"><input type="text" name="sample10" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="3" class="td_info">
			<strong>Villkor:</strong><br>
			Försändelsen ska återlevereras via A-Post inom 30 dagar<br>
			Vill ni behålla försändelsen övergår Varuofferten till faktura efter 30:e dagen<br><br><br>
		</td>
	</tr>
	<tr>
		<td></td>
		<td><input type="submit" name="sampleorder" value="Beställ varuprov" class="button"/></td>
	</tr>
	</table>
</form>
<br><br><br>
{$sampleorder->DoForm($smarty.post)}