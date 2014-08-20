<?php

class SampleOrderFormModuleFrontController extends ModuleFrontController
{

	public function initContent()
	{
		parent::initContent();

		if ($this->context->customer->id)
		{
			$customer = new Customer($this->context->customer->id);
			$this->context->smarty->assign(array(
				'customer' => $customer,
			));
		}
		$this->setTemplate('form.tpl'); // set template
	}

	public function postProcess()
	{
		if (Tools::isSubmit('submitSampleOrder'))
		{
			$validateArray = array(
				array('company', $this->module->l('Company','form')),
				array('siret',$this->module->l('Siret','form'),Validate::isSiret(Tools::getValue('siret'))),
				array('address',$this->module->l('Address','form')),
				array('address2',$this->module->l('Address (Line 2)','form')),
				array('postcode',$this->module->l('Postal Code','form')),
				array('city',$this->module->l('City','form')),
				array('phone',$this->module->l('Phone','form')),
				array('firstname',$this->module->l('First name','form'),Validate::isName(Tools::getValue('firstname'))),
				array('lastname',$this->module->l('Last name','form'),Validate::isName(Tools::getValue('lastname'))),
				array('email',$this->module->l('E-mail address','form'),Validate::isEmail(Tools::getValue('email'))),

			);
			$error_msg = false;
			foreach ($validateArray as $value)
			{
				if (Tools::getValue($value[0]))
				{
					if (isset($value[2]))
						if ($value[2] != true)
							$error_msg .= '<li>'.$value[1].$this->module->l(' is not valid!','form').'</li>';
				}
				else
					$error_msg .= '<li>'.$this->module->l('Please fill in ','form').$value[1].'</li>';
			}

			$products = $_POST['products'];
			$gotProduct = false;
			foreach ($products as $product)
				if (!empty($product))
					$gotProduct = true;

			if (!$gotProduct)
				$error_msg .= '<li>'.$this->module->l('Atlest one product must be requested','form').'</li>';

			if ($error_msg)
				$this->context->smarty->assign(array(
					'error' => '<p>'.$this->module->l('Errors was detected').'</p><br><ol>'.$error_msg.'</ol>'
				));
			else
			{
				$product_tpl = "<table>";
				foreach ($products as $product)
				{
					$id = Db::getInstance()->getValue('SELECT p.id_product FROM '._DB_PREFIX_.'product p WHERE p.reference = \''.$product.'\'');
					if ($id)
					{
						$p = new Product($id,true,$this->context->language->id);
						$product_tpl .= '<tr><td>'.$p->reference.' - '.$p->name.'</td></tr>';
					}
					else
						$product_tpl .= '<tr><td>'.$product.'</td></tr>'; // Retrive product and get product name
				}
				$template_vars = array(
					'{firstname}' => Tools::getValue('firstname'),
					'{lastname}' => Tools::getValue('lastname'),
					'{address}' => Tools::getValue('address'),
					'{address2}' => Tools::getValue('address2'),
					'{postcode}' => Tools::getValue('postcode'),
					'{city}' => Tools::getValue('city'),
					'{company}' => Tools::getValue('company'),
					'{siret}' => Tools::getValue('siret'),
					'{products}' => $product_tpl.'</table>',
					'{date}' => Tools::displayDate(date('Y-m-d H:i:s')),
				);

				Mail::Send(
				$this->context->language->id, // The customer deside the language of the mail
				'sampleorder',
				Mail::l('A sampleorder has been requested',$this->context->language->id),
				$template_vars,
				Configuration::get('PS_MOD_SAMPO_TO'),
				'Sample Order',
				Tools::getValue('email'),
				(!empty(Tools::getValue('company')) ? Tools::getValue('company').' ' : '').Tools::getValue('firstname').' '.Tools::getValue('lastname'),
				null,
				null,
				$this->module->getLocalPath().'mails/',
				false,
				$this->context->shop->id
				);
			}
			$this->context->smarty->assign(array(
				'order_ok' => true,
			));
		}
		parent::postProcess();
	}
}
?>
