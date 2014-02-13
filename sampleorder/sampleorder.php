<?php
	if (!defined('_PS_VERSION_'))
	exit;

	class SampleOrder extends Module {
		public function __construct() {
			$this->name = 'sampleorder';
			$this->tab = 'Test';
			$this->version = 0.1;
			$this->author = 'Madman';
			$this->need_instance = 0;

			parent::__construct();

			$this->displayName = $this->l($this->name);
			$this->description = $this->l('Adds a order form on your site');
		}

		// this also works, and is more future-proof
		public function install() {
			if (parent::install() == false
			)
				return false;
			return true;

		}

	}
?>