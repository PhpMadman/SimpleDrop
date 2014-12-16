{capture name=path}{l s='Simple Dropshipping'  mod='simpledrop'}{/capture}
<h1 class="page-heading bottom-indent">{l s='Simple Dropshipping' mod='simpledrop'}</h1>
{if $logged}
	{if $is_drop}
		{if !isset($order_ok)}
		{$limit = 10}
		<form name="simpledrop" method="post" action="" enctype="multipart/form-data" >
			<h3 class="page-subheading">{l s='Send in a dropshipping order' mod='simpledrop'}</h3>
			<div class="clearfix">
				{if isset($error)}
				<div class="alert alert-danger">
					{$error}
				</div>
				{/if}
				{l s='[Add some info about your dropshipping]' mod='simpledrop'}<br><br>
				{for $var=1 to $limit}
					<div id="div_drop_{$var}" {if $var != 1}{if !empty($smarty.post.products[$var][1]) || !empty($smarty.post.products[$var][2]) || !empty($smarty.post.products[$var][3]) || !empty($smarty.post.products[$var][4])}{else}style="display:none;"{/if}{/if}>
					<div class="col-xs-12 col-md-6">
						<label>{l s='Products' mod='simpledrop'}</label><br>
						<span>{l s='Type the product references you want to us to send to this customer' mod='simpledrop'}</span><br>
						<span>{l s='You only need to fill in these if you are not using our product reference on your reciept' mod='simpledrop'}</span>
<!-- 						<textarea class="form-control" id="products[{$var}]" name="products[{$var}]" style="height:150px;" />{if isset($smarty.post.products[$var])}{$smarty.post.products[$var]}{/if}</textarea><br> -->
						<input type="text" class="form-control" id="products[{$var}][1]" name="products[{$var}][1]" value="{if isset($smarty.post.products[$var][1])}{$smarty.post.products[$var][1]}{/if}" /><br>
						<input type="text" class="form-control" id="products[{$var}][2]" name="products[{$var}][2]" value="{if isset($smarty.post.products[$var][2])}{$smarty.post.products[$var][2]}{/if}"/><br>
						<input type="text" class="form-control" id="products[{$var}][3]" name="products[{$var}][3]" value="{if isset($smarty.post.products[$var][3])}{$smarty.post.products[$var][3]}{/if}"/><br>
						<input type="text" class="form-control" id="products[{$var}][4]" name="products[{$var}][4]" value="{if isset($smarty.post.products[$var][4])}{$smarty.post.products[$var][4]}{/if}"/><br>
						<br>
					</div>
					<div class="col-xs-12 col-md-6">
						<p class="form-group">
							<label for="fileUpload_{$var}">{l s='Attach PDF' mod='simpledrop'}</label><br>
							<span>{l s='Attach the pdf reciept for the customer order' mod='simpledrop'}</span>
							<input type="hidden" name="MAX_FILE_SIZE" value="2000000" />
							<input type="file" name="fileUpload_{$var}" id="fileUpload_{$var}" class="form-control" />
						</p>
					</div>
					<span class="clearfix"></span>
					{if $var != $limit}
						<button name="next" value="{$var+1}" id="next_drop_button_{$var}" class="next_drop_order button btn btn-default button-medium btn-black" style="background-color: #3e3e3e !important;border-color: #3e3e3e !important;">
							{l s='Add another order' mod='simpledrop'}
						</button>
					{/if}
					<hr style="border-color:#6b6a6a">
					</div>
				{/for}
			</div>
			<div class="submit">
				<button id="submitSimpleDrop" class="button btn btn-default button-medium" name="submitSimpleDrop" type="submit">
					<span>{l s='Submit' mod='simpledrop'}<i class="icon-chevron-right right"></i>	</span>
				</button>
			</div>
		</form>
		{else}
			<span style="font-size:16px;font-weight:bold;">{l s='You order has been sent' mod='simpledrop'}</span><br>
			<span style="font-size:16px;">{l s='Your orders will be sent to your customers within 2 workdays' mod='simpledrop'}</span><br>
			<span style="font-size:16px;">{l s='When the orders has been sent, we will create a order for you with all the products shipped' mod='simpledrop'}</span><br>
			<br>
		{/if}
	{else}
		<span>{l s='[Add some info on how to become a dropshipping customer]' mod='simpledrop'}</span><br>
	{/if}
{else}
	<span>{l s='You are not logged in' mod='simpledrop'}</span><br>
{/if}
