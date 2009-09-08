<%@ include file="../manage/localHeader.jsp"%>
<openmrs:require privilege="Manage Reports" otherwise="/login.htm" redirect="/module/reporting/reports/manageReports.form" />

		<c:choose>
			<c:when test="${report.uuid == null}">

				<b class="boxHeader">Create Period Indicator Report</b>
				<div class="box">
					<openmrs:portlet url="baseMetadata" id="baseMetadata" moduleId="reporting" parameters="type=org.openmrs.module.report.DariusPeriodIndicatorReportDefinition|size=380|mode=edit|dialog=false|cancelUrl=manageReports.form|successUrl=dariusPeriodIndicatorReport.form?uuid=uuid" />
				</div>

			</c:when>		
			<c:otherwise>
			
				<script type="text/javascript">
					$(document).ready(function() {
						$('#addColumnDialog').dialog({
							autoOpen: false,
							draggable: false,
							resizable: false,
							show: null,
							width: '90%',
							modal: true,
							title: 'Add another column'											
						});
						$('#cancelDialogButton').click(function() { $('#addColumnDialog').dialog('close') });
						$('.addColumnButton').click(function() { $('#addColumnDialog').dialog('open') });
						$('#column-table').dataTable({
							"bPaginate": false,
							"bLengthChange": false,
							"bFilter": false,
							"bSort": false,
							"bInfo": false,
							"bAutoWidth": false
						} );
					} ); 
				</script>
			
				<div id="addColumnDialog" style="display: none">
					<form method="post" action="dariusPeriodIndicatorReportAddColumn.form">
						<input type="hidden" name="uuid" value="${report.uuid}"/>
						<table>
							<tr>
								<td>Key</td>
								<td><input type="text" name="key"/></td>
							</tr>
							<tr>
								<td>Display Name</td>
								<td><input type="text" name="displayName"/></td>
							</tr>
							<tr>
								<td>Indicator</td>
								<td>
									<select name="indicator">
										<option value=""></option>
										<c:forEach var="ind" items="${indicators}">
											<option value="${ind.uuid}">${ind.name}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<c:if test="${fn:length(report.indicatorDataSetDefinition.dimensions) > 0}">
								<tr valign="top">
									<td>Dimensions</td>
									<td>
										<table>
											<c:forEach var="dim" items="${report.indicatorDataSetDefinition.dimensions}">
												<tr>
													<td align="right">
														${dim.key}:
													</td>
													<td>
														<select name="dimensionOption_${dim.key}">
															<option value="">*</option>
															<c:forEach var="dimOpt" items="${dim.value.parameterizable.cohortDefinitions}">
																<option value="${dimOpt.key}">${dimOpt.key}</option>
															</c:forEach>
														</select>
													</td>
												</tr>
											</c:forEach>
										</table>
									</td>
								</tr>
							</c:if>
							<tr>
								<td colspan="2" align="center">
									<input type="submit" value="<spring:message code="general.add"/>"/>
									<input type="button" id="cancelDialogButton" value="<spring:message code="general.cancel"/>"/>
								</td>
							</tr>
						</table>
					</form>
				</div>
			
				<table>
					<tr valign="top">
						<td>

							<openmrs:portlet url="baseMetadata" id="baseMetadata" moduleId="reporting" parameters="type=${report.class.name}|uuid=${report.uuid}|size=380|label=Basic Details" />
			
							<br/>
							
							<b class="boxHeader">Dimensions</b>
							<div class="box">
								<table border="1" cellspacing="0" cellpadding="2">
									<thead>
										<tr>
											<td>Key</td>
											<td>Display Name</td>
											<td>&nbsp;</td>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="dim" items="${report.indicatorDataSetDefinition.dimensions}">
											<tr>
												<td>${dim.key}</td>
												<td>${dim.value.parameterizable.name}</td>
												<td>
													<a href="dariusPeriodIndicatorReportRemoveDimension.form?key=${dim.key}&uuid=${report.uuid}">
														<img src='<c:url value="/images/trash.gif"/>' border="0"/>
													</a>
												</td>
											</tr>
										</c:forEach>
									</tbody>
									<tfoot>
										<tr>
											<td colspan="3">
												<openmrs:portlet url="mappedProperty" id="newDim" moduleId="reporting" 
															 parameters="type=${report.indicatorDataSetDefinition.class.name}|uuid=${report.indicatorDataSetDefinition.uuid}|property=dimensions|mode=add|label=New Dimension" />
											</td>
										</tr>
									</tfoot>
								</table>
							</div>
					
							<br/>
							<br/>
							<openmrs:portlet url="mappedProperty" id="baseCohortDefinition" moduleId="reporting" 
											 parameters="type=${report.class.name}|uuid=${report.uuid}|property=baseCohortDefinition|label=Filter|nullValueLabel=All Patients" />
						
						</td>
						<td>

							<b class="boxHeader" style="text-align: right">
								<span style="float:left">
									Columns
								</span>
								<a href="#" class="addColumnButton"><spring:message code="general.add"/></a>
							</b>
								<table id="column-table">
									<thead>
										<tr>
											<th>Key</th>
											<th>Display Name</th>
											<th>Indicator</th>
											<th>Dimensions</th>
											<th>&nbsp;</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="col" items="${report.indicatorDataSetDefinition.columns}">
											<tr>
												<td>${col.columnKey}</td>
												<td>${col.displayName}</td>
												<td>${col.indicator.parameterizable.name}</td>
												<td>
													<c:forEach var="dimOpt" items="${col.dimensionOptions}">
														${dimOpt.key}=${dimOpt.value} <br/>
													</c:forEach>
												</td>
												<td>
													<a href="dariusPeriodIndicatorReportRemoveColumn.form?key=${col.columnKey}&uuid=${report.uuid}">
														<img src='<c:url value="/images/trash.gif"/>' border="0"/>
													</a>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
						</td>
					</tr>
				</table>
			
			</c:otherwise>
		</c:choose>

<%@ include file="/WEB-INF/template/footer.jsp"%>