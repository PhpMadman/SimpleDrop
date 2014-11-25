<?php

class SimpleDropFormModuleFrontController extends ModuleFrontController
{

	public function initContent()
	{
		parent::initContent();

		if ($this->context->customer->id)
		{
			$customer = new Customer($this->context->customer->id);
			$drop_group = Configuration::get('PS_MOD_SIMDROP_GROUP');
			$groups = Customer::getGroupsStatic($customer->id);
			$isDrop = false;
			foreach($groups as $id_group)
				if ($drop_group == $id_group)
				{
					$isDrop = true;
					break;
				}

			$this->context->smarty->assign(array(
				'customer' => $customer,
				'is_drop' => $isDrop,
			));
		}
		$this->setTemplate('form.tpl'); // set template
	}

	public function setMedia()
	{
		parent::setMedia();
		$this->context->controller->addJS($this->module->getLocalPath().'/js/form.js');
	}

	public function postProcess()
	{
		if (Tools::isSubmit('submitSimpleDrop'))
		{
			$error_msg = false;

			$products = $_POST['products'];
// 			$products = Tools::getValue('products');

			$gotProd = false;

			foreach($products as $product)
				if ($product != '')
					 $gotProd = true;

			if (!$gotProd)
				$error_msg .= '<li>'.$this->module->l('Atlest one product must be requested','form').'</li>';

			$extension = array('.pdf');
			$file_attachements = array();
			$product_string = '';
			foreach($products as $key => $product)
			{
				$fileAttachment = Tools::fileAttachment('fileUpload_'.$key);
				if (!empty($fileAttachment['name']) && $fileAttachment['error'] != 0)
				{
					$this->errors[] = Tools::displayError('An error occurred during the file-upload process.');
					$fileAttachment = false;
				}
				else
					if (!empty($fileAttachment['name']) && !in_array( Tools::strtolower(substr($fileAttachment['name'], -4)), $extension) && !in_array( Tools::strtolower(substr($fileAttachment['name'], -5)), $extension))
					{
						$this->errors[] = Tools::displayError('Bad file extension');
						$fileAttachment = false;
					}

				if ($fileAttachment)
				{
					// Attach tmp to mail, then it will be auto delted when completed
					$file_attachement['content'] = file_get_contents($fileAttachment['tmp_name']);
					$file_attachement['name'] = 'Order-'.$key.'-'.$fileAttachment['name'];
					$file_attachement['mime'] = 'application/pdf';
					$file_attachements[] = $file_attachement;
				}
				if ($product != '')
					$product_string .= 'Order '.$key.'<br>'.Tools::nl2br($product).($fileAttachment ? '' : '<br><br><strong>'.$this->module->l('No file attached to this order').'</strong>').'<hr><br>';
			}

			if ($error_msg)
				$this->context->smarty->assign(array(
					'error' => '<p>'.$this->module->l('Errors was detected').'</p><br><ol>'.$error_msg.'</ol>'
				));
			else
			{
				$template_vars = array(
					'{firstname}' => $this->context->customer->firstname,
					'{lastname}' => $this->context->customer->lastname,
					'{company}' => $this->context->customer->company,
					'{products}' => $product_string,
					'{date}' => Tools::displayDate(date('Y-m-d H:i:s')),
				);

				$company = $this->context->customer->company;
				Mail::Send(
					$this->context->language->id, // The customer deside the language of the mail
					'simpledrop',
					Mail::l('A dropshipping order has been sent',$this->context->language->id), //subject
					$template_vars,
					Configuration::get('PS_MOD_SIMDROP_TO'), //to
					'Simple Drop', // to name
					$this->context->customer->email, // from
					($company != '' ? $company.' ' : '').$this->context->customer->firstname.' '.$this->context->customer->lastname, // fromname
					$file_attachements,
					null,
					$this->module->getLocalPath().'mails/',
	// 				$this->module->_path.'mails/', // For 1.5
					false,
					$this->context->shop->id
				);
				$this->context->smarty->assign(array(
					'order_ok' => true,
				));
			}
		}
		parent::postProcess();
	}
}
?>
