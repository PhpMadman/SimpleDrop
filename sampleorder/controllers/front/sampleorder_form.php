<?php

class SampleOrderSampleOrder_FormModuleFrontController extends ModuleFrontController
{

  public function initContent()
  {
    parent::initContent();
    global $smarty;
    $SampleOrder = new SampleOrderClass; // Get modules class and make it object
    $smarty->assign("sampleorder",$SampleOrder); // asign the object to a smarty var
// 	$this->_prepareHook();
    $this->setTemplate('sampleorder_form.tpl'); // set template
  }

}
?>
<?php
// The functions for this page.
class SampleOrderClass {

	public function DoForm($post) {
		if($post["sampleorder"])  {
			$msg = "F&ouml;rfrågan om sample order<br>";
			$msg .= "<table>";
			$msg .= "<tr>";
			$msg .= "<td>Företag</td>";
			$msg .= "<td>$post[company]</td>";
			$msg .= "</td>";
			$msg .= "</tr>";
			$msg .= "<tr>";
			$msg .= "<td>Org.nr</td>";
			$msg .= "<td>$post[orgnr]</td>";
			$msg .= "</td>";
			$msg .= "</tr>";
			$msg .= "<tr>";
			$msg .= "<td>Kontaktperson&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>";
			$msg .= "<td>$post[contact]</td>";
			$msg .= "</tr>";
			$msg .= "<tr>";
			$msg .= "<td>Adress</td>";
			$msg .= "<td>$post[address]</td>";
			$msg .= "</tr>";
			$msg .= "<tr>";
			$msg .= "<td>Postnr</td>";
			$msg .= "<td>$post[postal_code]</td>";
			$msg .= "</tr>";
			$msg .= "<tr>";
			$msg .= "<td>Stad</td>";
			$msg .= "<td>$post[city]</td>";
			$msg .= "</tr>";
			$msg .= "<tr>";
			$msg .= "<td>Telefon</td>";
			$msg .= "<td>$post[phone]";
			$msg .= "</tr>";
			$msg .= "<tr>";
			$msg .= "<td>E-Mail</td>";
			$msg .= "<td>$post[email]</td>";
			$msg .= "</tr>";
			
			$msg .= "<tr>";
			$msg .= "<td>&nbsp;</td>";
			$msg .= "<td>&nbsp;</td>";
			$msg .= "</tr>";

				for($i = 1; $i <= 10; $i++) {
					$msg .= "<tr>";
					$msg .= "<td>Sample $i</td>";
					$msg .= "<td>" . $post["sample$i"] . "</td>";
					$msg .= "</tr>";
				}
			$msg .= "</table>";
			$headers = 'MIME-Version: 1.0' . "\r\n";
			$headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";
			$headers .= 'From: ' . $post["email"] . "\r\n";
			mail("salj@nldistribution.se","Förfrågan om sample från $post[company]",$msg,$headers);
			return "<div style='background-color:#DFF2BF; border: 1px solid #4F8A10; font-size:14px; height:20px; padding:5px; color: #4F8A10; '>Din förfrågan har skickats, du kommer att få ett varuprovs kvitto när vi skickar din order</div>";
		}
	}
}
?>