<?php
	if (!defined('_PS_VERSION_'))
	exit;

class SampleOrder extends Module
{
	public function __construct()
	{
		$this->name = 'sampleorder';
		$this->tab = 'Test';
		$this->version = 0.2;
		$this->author = 'Madman';
		$this->need_instance = 0;
		$this->bootstrap =  true;

		parent::__construct();

		$this->displayName = $this->l('Sample Order');
		$this->description = $this->l('Adds a sample order form on your site');
		$this->config = array(
			array(
				'value' => 'to@sample.com',
				'name' => 'PS_MOD_SAMPO_TO',
				'label' => $this->l('To e-mail'),
				'hint' => $this->l('The email to send sample order to'),
				'type' => 'text',
				'class' =>  'fixed-width-xl',
				'configurable' => true,
				'extra' => array(
					'validate' => 'isEmail',
				),
			),
		);
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
		$output = '';
		foreach ($this->config as $config)
		{
			if ($config['configurable'] && $postValue = Tools::getValue($config['name']))
			{
				if (isset($config['extra']['validate']))
				{
					$func = $config['extra']['validate'];
					if (Validate::$func($postValue))
					{
						if (!Configuration::updateValue($config['name'],$postValue))
						{
							$error = true;
							$output .= $this->displayError($config['label'].': '.$this->l('Error while saving'));
						}
					}
					else
					{
						$error = true;
						$output .= $this->displayError($config['label'].': '.$this->l('Invaild choice'));
					}
				}
				else
				{
					if ($config['type'] == 'text')
					{
						Configuration::updateValue($config['name'], $postValue);
					}
				}
			}
		}
		return $output.(isset($error) ? '' : $this->displayConfirmation($this->l('Settings updated')));
	}

	private function generateInput()
	{
		$inputArray = array();
		foreach ($this->config as $config)
		{
			if ($config['configurable'])
			{
				$input = array(
					'type' => $config['type'],
					'label' => $config['label'],
					'name' => $config['name'],
					'hint' => (isset($config['hint']) ? $config['hint'] : null),
				);

				if ($config['type'] == 'text')
				{
					$input['class'] = (isset($config['class']) ? $config['class'] : '');
				}
				if ($config['type'] == 'switch')
				{
					$input['is_bool'] = true;
					$input['values'] = $config['values'];
				}
				$inputArray[] = $input;
			}
		}
		return $inputArray;
	}

	private function renderSettingsForm()
	{
		$inputArray = $this->generateInput();
		$fields_form = array(
			'form' => array(
				'legend' => array(
					'title' => $this->l('Settings'),
				),
				'input' => $inputArray,
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
		$fields_value = array();
		foreach ($this->config as $value)
			if ($value['configurable'])
			{
				if (Configuration::get($value['name']))
					$fields_value[$value['name']] = Configuration::get($value['name']);
				else
					$fields_value[$value['name']] = $value['value'];
			}

		return $fields_value;
	}

}
?>
