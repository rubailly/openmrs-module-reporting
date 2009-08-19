<%@ include file="/WEB-INF/view/module/reporting/include.jsp"%>
<%@ include file="/WEB-INF/view/module/reporting/localHeaderMinimal.jsp"%>

<script type="text/javascript" charset="utf-8">
	$(document).ready(function() {

		$('#cancelButton').click(function(event){
			closeReportingDialog(false);
		});

		$('#submitButton').click(function(event){
			$('#baseParameterizableEditorForm').submit();
		});

	});
</script>

<style>
	div.metadataField { display:block; margin:0; padding:6px 5px 9px 9px; clear:both; color:#444; }
	div.metadataField label.desc { line-height:150%; margin:0; padding:0 0 3px 0; border:none; color:#222; display:block; font-weight:bold; }
</style>

<form id="baseParameterizableEditorForm" method="post" action="saveBaseParameterizable.form">
	<input type="hidden" name="uuid" value="${uuid}"/>
	<input type="hidden" name="type" value="${type.name}"/>
	<div style="margin:0; padding:0; width:100%; padd">
		<div class="metadataField">
			<label class="desc" for="name">Name</label>
			<input type="text" id="name" tabindex="1" name="name" value="${object.name}" size="50"/>
		</div>
		<div class="metadataField">
			<label class="desc" for="description">Description</label>			
			<textarea id="description" cols="80" rows="10" tabindex="2" name="description">${object.description}</textarea>
		</div>
	</div>
	<hr style="color:blue;"/>
	<div style="width:100%; text-align:left;">
		<input type="button" id="cancelButton" class="ui-button ui-state-default ui-corner-all" value="Cancel"/>
		<input type="button" id="submitButton" class="ui-button ui-state-default ui-corner-all" value="Submit"/>
	</div>
</form>