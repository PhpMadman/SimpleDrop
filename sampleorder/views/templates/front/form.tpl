{capture name=path}{l s='Sample order'  mod='sampleorder'}{/capture}
<h1 class="page-heading bottom-indent">{l s='Sample Order' mod='sampleorder'}</h1>
{if $logged}
	{if !isset($order_ok)}
<form name="sampleorder" method="post" action="">
	<h3 class="page-subheading">{l s='Want to try a product or two? Send a request for a sample' mod='sampleorder'}</h3>
	<div class="clearfix">
		{if isset($error)}
		<div class="alert alert-danger">
			{$error}
		</div>
		{/if}
		<div class="col-xs-12 col-md-6">
		<p class="required form-group">
			<label for="company">{l s='Company' mod='sampleorder'} <sup>*</sup></label>
			{if isset($customer)}
				<input type="text" class="is_required form-control" id="company" name="company" value="{if isset($smarty.post.company)}{$smarty.post.company}{else}{$customer->company}{/if}"  />
			{else}
				<input type="text" class="is_required form-control" id="company" name="company" value="{if isset($smarty.post.company)}{$smarty.post.company}{/if}"  />
			{/if}
		</p>
		<p class="required form-group">
			<label for="siret">{l s='Siret' mod='sampleorder'} <sup>*</sup></label>
			{if isset($customer)}
				<input type="text" class="is_required validate form-control" data-validate="isSiret" id="siret" name="siret" value="{if isset($smarty.post.siret)}{$smarty.post.siret}{else}{$customer->siret}{/if}" required />
			{else}
				<input type="text" class="is_required validate form-control" data-validate="isSiret" id="siret" name="siret" value="{if isset($smarty.post.siret)}{$smarty.post.siret}{/if}" required />
			{/if}
		</p>
		<p class="required form-group">
			<label for="address">{l s='Address' mod='sampleorder'} <sup>*</sup></label>
			{if isset($customer)}
				<input type="text" class="is_required form-control" id="address1" name="address" value="{if isset($smarty.post.address)}{$smarty.post.address}{/if}" required />
			{else}
				<input type="text" class="is_required form-control" id="address1" name="address" value="{if isset($smarty.post.address)}{$smarty.post.address}{/if}" required />
			{/if}
		</p>
		<p class="required form-group">
			<label for="address2">{l s='Address (Line 2)' mod='sampleorder'} <sup>*</sup></label>
			{if isset($customer)}
				<input type="text" class="is_required form-control" id="address2" name="address2" value="{if isset($smarty.post.address2)}{$smarty.post.address2}{/if}" required />
			{else}
				<input type="text" class="is_required form-control" id="address2" name="address2" value="{if isset($smarty.post.address2)}{$smarty.post.address2}{/if}" required />
			{/if}
		</p>
		<p class="required form-group">
			<label for="postcode">{l s='Postal Code' mod='sampleorder'} <sup>*</sup></label>
			{if isset($customer)}
				<input type="text" class="is_required form-control" id="postcode" name="postcode" value="{if isset($smarty.post.postcode)}{$smarty.post.postcode}{/if}" required />
			{else}
				<input type="text" class="is_required form-control" id="postcode" name="postcode" value="{if isset($smarty.post.postcode)}{$smarty.post.postcode}{/if}" required />
			{/if}
		</p>
		<p class="required form-group">
			<label for="city">{l s='City' mod='sampleorder'} <sup>*</sup></label>
			{if isset($customer)}
				<input type="text" class="is_required form-control" id="city" name="city" value="{if isset($smarty.post.city)}{$smarty.post.city}{/if}" required />
			{else}
				<input type="text" class="is_required form-control" id="city" name="city" value="{if isset($smarty.post.city)}{$smarty.post.city}{/if}" required />
			{/if}
		</p>
		<p class="required form-group">
			<label for="phone">{l s='Phone' mod='sampleorder'} <sup>*</sup></label>
			{if isset($customer)}
				<input type="text" class="is_required form-control" id="phone" name="phone" value="{if isset($smarty.post.phone)}{$smarty.post.phone}{/if}" required />
			{else}
				<input type="text" class="is_required form-control" id="phone" name="phone" value="{if isset($smarty.post.phone)}{$smarty.post.phone}{/if}" required />
			{/if}
		</p>
		<p class="required form-group">
			<label for="firstname">{l s='First name' mod='sampleorder'} <sup>*</sup></label>
			{if isset($customer)}
				<input type="text" class="is_required validate form-control" data-validate="isName" id="firstname" name="firstname" value="{if isset($smarty.post.firstname)}{$smarty.post.firstname}{else}{$customer->firstname}{/if}" required />
			{else}
				<input type="text" class="is_required validate form-control" data-validate="isName" id="firstname" name="firstname" value="{if isset($smarty.post.firstname)}{$smarty.post.firstname}{/if}" required />
			{/if}
		</p>
		<p class="required form-group">
			<label for="lastname">{l s='Last name' mod='sampleorder'} <sup>*</sup></label>
			{if isset($customer)}
				<input type="text" class="is_required validate form-control" data-validate="isName" id="lastname" name="lastname" value="{if isset($smarty.post.lastname)}{$smarty.post.lastname}{else}{$customer->lastname}{/if}" required />
			{else}
				<input type="text" class="is_required validate form-control" data-validate="isName" id="lastname" name="lastname" value="{if isset($smarty.post.lastname)}{$smarty.post.lastname}{/if}" required />
			{/if}
		</p>
		<p class="form-group">
			<label for="email">{l s='E-mail address' mod='sampleorder'} <sup>*</sup></label>
			{if isset($customer)}
				<input class="form-control grey" type="text" id="email" name="email" value="{$customer->email|escape:'html':'UTF-8'}" readonly="readonly" />
			{else}
				<input class="form-control grey validate" type="text" id="email" name="email" data-validate="isEmail" value="{if isset($smarty.post.email)}{$smarty.post.email}{/if}" required />
			{/if}
		</p>
		</div>
		<div class="col-xs-12 col-md-6">
			<label>Products</label>
			{for $var=1 to 10}
				<input class="form-control" type="text" id="products[{$var}]" name="products[{$var}]" value="{if isset($smarty.post.products[$var])}{$smarty.post.products[$var]}{/if}" /><br>
				<br>
			{/for}
		</div>
	</div>
	<div class="submit">
		<button id="submitSampleOrder" class="button btn btn-default button-medium" name="submitSampleOrder" type="submit">
			<span>{l s='Submit' mod='sampleorder'}<i class="icon-chevron-right right"></i>	</span>
		</button>
	</div>
</form>
	{else}
		<span style="font-size:16px;font-weight:bold;">{l s='You request has been sent' mod='sampleorder'}</span><br>
	{/if}
{else}
	{l s='You are not logged in' mod='sampleorder'}<br>
{/if}
