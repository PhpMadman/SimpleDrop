<?php
	if (!defined('_PS_VERSION_'))
	exit;

class SimpleDrop extends Module
{
	public function __construct()
	{
		$this->name = 'simpledrop';
		$this->tab = 'Others';
		$this->version =' 0.1';
		$this->author = 'Madman';
		$this->need_instance = 0;
		$this->bootstrap =  true;

		parent::__construct();

		$this->displayName = $this->l('Simple Dropshipping');
		$this->description = $this->l('Adds a simple dropshipping order form on your site');
	}

	public function install()
	{
		return parent::install();
	}

	public function getContent()
	{
		$output = '';
		if (Tools::isSubmit('submitUpdateConfig'))
			$output .= $this->updateConfig();

		return $output.$this->renderSettingsForm();
	}

	private function updateConfig()
	{
		$error = false;
		if (Validate::isEmail(Tools::getValue('PS_MOD_SIMDROP_TO')))
		{
			if (!Configuration::updateValue('PS_MOD_SIMDROP_TO', Tools::getValue('PS_MOD_SIMDROP_TO')))
				$error .= $this->displayError($this->l('To e-mail').': Error while saveing');
		}
		else
			$error .= $this->displayError($this->l('To e-mail').': Not an emai, value was resetl');

		if (!Configuration::updateValue('PS_MOD_SIMDROP_GROUP', Tools::getValue('PS_MOD_SIMDROP_GROUP')))
			$error .= $this->displayError($this->l('Dropshipping group').': Error while saveing');
			
		if (!$error)
			return $this->displayConfirmation($this->l('Settings updated'));
		else
			return $error;
	}

	private function renderSettingsForm()
	{
		$fields_form = array(
			'form' => array(
				'legend' => array(
					'title' => $this->l('Settings'),
					'icon' => 'icon-cogs',
				),
				'input' => array(
					array(
						'value' => 'to@sample.com',
						'name' => 'PS_MOD_SIMDROP_TO',
						'label' => $this->l('To e-mail'),
						'hint' => $this->l('The email to send dropshipping order to'),
						'type' => 'text',
						'class' =>  'fixed-width-xl',
					),
					array(
						'type' => 'select',
						'name' => 'PS_MOD_SIMDROP_GROUP',
						'label' => $this->l('Dropshipping group'),
						'hint' => $this->l('The group that is allowed to use the dropshipping form'),
						'options' => array(
							'query' => Group::getGroups($this->context->language->id),
							'id' => 'id_group',
							'name' => 'name'
						)
					),
				),
				'submit' => array(
					'title' => $this->l('Save'),
				),
			)
		);

		$helper = new HelperForm();
		$helper->show_toolbar = false;
		$helper->table = $this->table;
		$lang = new Language((int)Configuration::get('PS_LANG_DEFAULT'));
		$helper->default_form_language = $lang->id;
		$helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') ? Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') : 0;
		$this->fields_form = array();
		$helper->identifier = $this->identifier;
		$helper->submit_action = 'submitUpdateConfig';
		$helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false)
			.'&configure='.$this->name.'&tab_module='.$this->tab.'&module_name='.$this->name;
		$helper->token = Tools::getAdminTokenLite('AdminModules');
		$helper->tpl_vars = array(
			'fields_value' => $this->getConfigFieldsValues(),
			'languages' => $this->context->controller->getLanguages(),
			'id_language' => $this->context->language->id
		);

		return $helper->generateForm(array($fields_form));
	}

	public function getConfigFieldsValues()
	{
		$fields_value = array(
			'PS_MOD_SIMDROP_TO' => Configuration::get('PS_MOD_SIMDROP_TO'),
			'PS_MOD_SIMDROP_GROUP' => Configuration::get('PS_MOD_SIMDROP_GROUP'),
		);

		return $fields_value;
	}

}
?>
