{capture name=path}{l s='Simple Dropshipping'  mod='simpledrop'}{/capture}
<h1 class="page-heading bottom-indent">{l s='Simple Dropshipping' mod='simpledrop'}</h1>
{if $logged}
	{if $is_drop}
		{if !isset($order_ok)}
		<form name="simpledrop" method="post" action="" enctype="multipart/form-data" >
			<h3 class="page-subheading">{l s='Send in a dropshipping order' mod='simpledrop'}</h3>
			<div class="clearfix">
				{if isset($error)}
				<div class="alert alert-danger">
					{$error}
				</div>
				{/if}
				{l s='[Add some info about your dropshipping]' mod='simpledrop'}<br>
				{for $var=1 to 10}
					<div id="div_drop_{$var}" {if $var != 1} style="display:none;" {/if}>
					<div class="col-xs-12 col-md-6">
						<label>{l s='Products' mod='simpledrop'}</label>
						<textarea class="form-control" id="products[{$var}]" name="products[{$var}]" style="height:150px;" />{if isset($smarty.post.products[$var])}{$smarty.post.products[$var]}{/if}</textarea><br>
						<br>
					</div>
					<div class="col-xs-12 col-md-6">
						<p class="form-group">
							<label for="fileUpload_{$var}">{l s='Attach PDF' mod='simpledrop'}</label>
							<input type="hidden" name="MAX_FILE_SIZE" value="2000000" />
							<input type="file" name="fileUpload_{$var}" id="fileUpload_{$var}" class="form-control" />
						</p>
					</div>
					<span class="clearfix"></span>
					{if $var != 10}
						<button name="next" value="{$var+1}" class="next_drop_order button btn btn-default button-medium btn-black" style="background-color: #3e3e3e !important;border-color: #3e3e3e !important;">
							{l s='Add another order' mod='simpledrop'}
						</button>
					{/if}
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
		{/if}
	{else}
		<span>{l s='[Add some info on how to become a dropshipping customer]' mod='simpledrop'}</span><br>
	{/if}
{else}
	<span>{l s='You are not logged in' mod='simpledrop'}</span><br>
{/if}
