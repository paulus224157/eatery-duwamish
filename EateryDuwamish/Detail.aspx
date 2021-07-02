<%@ Page Title="Detail" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Detail.aspx.cs" Inherits="EateryDuwamish.Detail" %>
<%@ Register Src="~/UserControl/NotificationControl.ascx" TagName="NotificationControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <%--Datatable Configuration--%>
    <script type="text/javascript">
        function ConfigureDatatable() {
            var table = null;
            if ($.fn.dataTable.isDataTable('#htblRecipeDetail')) {
                table = $('#htblRecipeDetail').DataTable();
            }
            else {
                table = $('#htblRecipeDetail').DataTable({
                    stateSave: false,
                    order: [[1, "asc"]],
                    columnDefs: [{ orderable: false, targets: [0] }, { orderable: false, targets: [4] }]
                });
            }
            return table;
        }
    </script>
    <%--Checkbox Event Configuration--%>
    <script type="text/javascript">
        function ConfigureCheckboxEvent() {
            $('.checkDelete input').change(function () {
                var parent = $(this).parent();
                var value = $(parent).attr('data-value');
                var deletedList = [];

                if ($('#<%=hdfDeletedRecipeDetails.ClientID%>').val())
                    deletedList = $('#<%=hdfDeletedRecipeDetails.ClientID%>').val().split(',');

                if ($(this).is(':checked')) {
                    deletedList.push(value);
                    $('#<%=hdfDeletedRecipeDetails.ClientID%>').val(deletedList.join(','));
                }
                else {
                    var index = deletedList.indexOf(value);
                    if (index >= 0)
                        deletedList.splice(index, 1);
                    $('#<%=hdfDeletedRecipeDetails.ClientID%>').val(deletedList.join(','));
                }
            });
        }
    </script>
    <%--Main Configuration--%>
    <script type="text/javascript">
        function ConfigureElements() {
            ConfigureDatatable();
            ConfigureCheckboxEvent();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <script type="text/javascript">
                $(document).ready(function () {
                    ConfigureElements();
                });
                <%--On Partial Postback Callback Function--%>
                var prm = Sys.WebForms.PageRequestManager.getInstance();
                prm.add_endRequest(function () {
                    ConfigureElements();
                });
            </script>
            <uc1:NotificationControl ID="notifRecipeDetail" runat="server" />
            <div class="page-title">Recipe Details - <asp:Literal runat="server" ID="litPageTitle"></asp:Literal></div><hr style="margin:0"/>
            <%--FORM RECIPE DETAIL--%>
            <asp:Panel runat="server" ID="pnlFormRecipeDetail" Visible="false">
                <div class="form-slip">
                    <div class="form-slip-header">
                        <div class="form-slip-title">
                            FORM RECIPE DETAIL - 
                            <asp:Literal runat="server" ID="litFormType"></asp:Literal>
                        </div>
                        <hr style="margin:0"/>
                    </div>
                    <div class="form-slip-main">
                        <asp:HiddenField ID="hdfRecipeDetailId" runat="server" Value="0"/>
                        <div>
                            <%--Recipe Detail Ingredient Field--%>
                            <div class="col-lg-6 form-group">
                                <div class="col-lg-4 control-label">
                                    Ingredient*
                                </div>
                                <div class="col-lg-6">
                                    <asp:TextBox ID="txtRecipeDetailIngredient" CssClass="form-control" runat="server"></asp:TextBox>
                                    <%--Validator--%>
                                    <asp:RequiredFieldValidator ID="rfvRecipeDetailIngredient" runat="server" ErrorMessage="Please fill this field"
                                        ControlToValidate="txtRecipeDetailIngredient" ForeColor="Red" 
                                        ValidationGroup="InsertUpdateRecipeDetail" Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revRecipeDetailIngredient" runat="server" ErrorMessage="This field has a maximum of 200 characters"
                                        ControlToValidate="txtRecipeDetailIngredient" ValidationExpression="^[\s\S]{0,200}$" ForeColor="Red"
                                        ValidationGroup="InsertUpdateRecipeDetail" Display="Dynamic">
                                    </asp:RegularExpressionValidator>
                                    <%--End of Validator--%>
                                </div>
                            </div>
                            <%--End of Recipe Detail Ingredient Field--%>
                            <%--Recipe Detail Quantity Field--%>
                            <div class="col-lg-6 form-group">
                                <div class="col-lg-4 control-label">
                                    Quantity*
                                </div>
                                <div class="col-lg-6">
                                    <asp:TextBox ID="txtRecipeDetailQuantity" CssClass="form-control" runat="server" type="number"
                                         Min="0" Max="999999999"></asp:TextBox>
                                    </div>
                                    <%--Validator--%>
                                    <asp:RequiredFieldValidator ID="rfvRecipeDetailQuantity" runat="server" ErrorMessage="Please fill this field"
                                        ControlToValidate="txtRecipeDetailQuantity" ForeColor="Red"
                                        ValidationGroup="InsertUpdateRecipeDetail" Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                    <%--End of Validator--%>
                                </div>
                            </div>
                            <%--End of Recipe Detail Quantity Field--%>
                            <%--Recipe Detail Unit Field--%>
                            <div class="col-lg-6 form-group">
                                <div class="col-lg-4 control-label">
                                    Unit*
                                </div>
                                <div class="col-lg-6">
                                    <asp:TextBox ID="txtRecipeDetailUnit" CssClass="form-control" runat="server"></asp:TextBox>
                                    <%--Validator--%>
                                    <asp:RequiredFieldValidator ID="rfvRecipeDetailUnit" runat="server" ErrorMessage="Please fill this field"
                                        ControlToValidate="txtRecipeDetailUnit" ForeColor="Red" 
                                        ValidationGroup="InsertUpdateRecipeDetail" Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revRecipeDetailUnit" runat="server" ErrorMessage="This field has a maximum of 100 characters"
                                        ControlToValidate="txtRecipeDetailUnit" ValidationExpression="^[\s\S]{0,100}$" ForeColor="Red"
                                        ValidationGroup="InsertUpdateRecipeDetail" Display="Dynamic">
                                    </asp:RegularExpressionValidator>
                                    <%--End of Validator--%>
                                </div>
                            </div>
                            <%--End of Recipe Detail Unit Field--%>
                        </div>
                        <div class="col-lg-12">
                            <div class="col-lg-2">
                            </div>
                            <div class="col-lg-2">
                                <asp:Button runat="server" ID="btnSave" CssClass="btn btn-primary" Width="100px"
                                    Text="SAVE" OnClick="btnSave_Click" ValidationGroup="InsertUpdateRecipeDetail">
                                </asp:Button>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <%--END OF FORM RECIPE DETAIL--%>

            <div class="row">
                <div class="table-header">
                    <div class="table-header-title">
                        Ingredients
                    </div>
                    <div class="table-header-button">
                        <asp:Button ID="btnAdd" runat="server" Text="ADD" CssClass="btn btn-primary" Width="100px"
                            OnClick="btnAdd_Click" />
                        <asp:Button ID="btnDelete" runat="server" Text="DELETE" CssClass="btn btn-danger" Width="100px"
                            OnClick="btnDelete_Click" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="table-main col-sm-12">
                    <asp:HiddenField ID="hdfDeletedRecipeDetails" runat="server" />
                    <asp:Repeater ID="rptRecipeDetail" runat="server" OnItemDataBound="rptRecipeDetail_ItemDataBound" OnItemCommand="rptRecipeDetail_ItemCommand">
                        <HeaderTemplate>
                            <table id="htblRecipeDetail" class="table">
                                <thead>
                                    <tr role="row">
                                        <th aria-sort="ascending" style="" colspan="1" rowspan="1"
                                            tabindex="0" class="sorting_asc center">
                                        </th>
                                        <th aria-sort="ascending" style="" colspan="1" rowspan="1" tabindex="0"
                                            class="sorting_asc text-center">
                                            Ingredient
                                        </th>
                                        <th aria-sort="ascending" style="" colspan="1" rowspan="1" tabindex="0"
                                            class="sorting_asc text-center">
                                            Quantity
                                        </th>
                                        <th aria-sort="ascending" style="" colspan="1" rowspan="1" tabindex="0"
                                            class="sorting_asc text-center">
                                            Unit
                                        </th>
                                        <th aria-sort="ascending" style="" colspan="1" rowspan="1" tabindex="0"
                                            class="text-center sorting_asc">
                                            Toggle
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr class="odd" role="row" runat="server" onclick="">
                                <td>
                                    <div style="text-align: center;">
                                        <asp:CheckBox ID="chkChoose" CssClass="checkDelete" runat="server">
                                        </asp:CheckBox>
                                    </div>
                                </td>
                                <td>
                                    <div style="text-align: center;">
                                    <asp:Literal ID="litRecipeDetailIngredient" runat="server"></asp:Literal>
                                    </div>
                                </td>
                                <td>
                                    <div style="text-align: center;">
                                    <asp:Literal ID="litRecipeDetailQuantity" runat="server"></asp:Literal>
                                    </div>
                                </td>
                                <td>
                                    <div style="text-align: center;">
                                    <asp:Literal ID="litRecipeDetailUnit" runat="server"></asp:Literal>
                                    </div>
                                </td>
                                <td>
                                    <div style="text-align: center;">
                                        <asp:LinkButton ID="lbEditRecipeDetail" runat="server" CommandName="EDIT">Edit</asp:LinkButton>
                                    </div>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody> 
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>
            <div class="row">
                <div class="textarea-description">
                    <asp:HiddenField ID="hdfRecipeDescriptionId" runat="server" Value="0" />
                    <asp:TextBox runat="server" CssClass="form-control" TextMode="MultiLine" Rows="10" Columns="20" ReadOnly="true" ID="txtRecipeDescription" ></asp:TextBox>
                </div>
                <div class="table-footer">
                     <div class="table-footer-button">
                            <asp:Button ID="Button1" runat="server" Text="EDIT" CssClass="btn btn-primary" Width="100px"
                                 OnClick="btnEditDescription_Click" />
                                 <asp:Button ID="Button2" runat="server" Text="SAVE" CssClass="btn btn-success" Width="100px"
                                 OnClick="btnSaveDescription_Click" />
                     </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
