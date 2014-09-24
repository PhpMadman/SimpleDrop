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
				<div class="col-xs-12 col-md-6">
					<label>Products</label>
					<textarea class="form-control" id="products" name="products" style="height:150px;" />{if isset($smarty.post.products)}{$smarty.post.products}{/if}</textarea><br>
					<br>
				</div>
				<div class="col-xs-12 col-md-6">
					<p class="form-group">
						<label for="fileUpload">{l s='Attach PDF' mod='simpledrop'}</label>
						<input type="hidden" name="MAX_FILE_SIZE" value="2000000" />
						<input type="file" name="fileUpload" id="fileUpload" class="form-control" />
					</p>
				</div>
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
