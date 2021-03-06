<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="OpenAuthProviders.ascx.vb" Inherits="$safeprojectname$.OpenAuthProviders" %>
$if$ ($targetframeworkversion$ == 4.0)<%@ Import Namespace="Microsoft.AspNet.Membership.OpenAuth" %>$endif$

<fieldset class="open-auth-providers">
    <legend>Log in using another service</legend>
    $if$ ($targetframeworkversion$ >= 4.5)
    <asp:ListView runat="server" ID="providerDetails" ItemType="Microsoft.AspNet.Membership.OpenAuth.ProviderDetails"
        SelectMethod="GetProviderNames" ViewStateMode="Disabled">
        <ItemTemplate>
            <button type="submit" name="provider" value="<%#: Item.ProviderName %>"
                title="Log in using your <%#: Item.ProviderDisplayName %> account.">
                <%#: Item.ProviderDisplayName %>
            </button>
        </ItemTemplate>
    $else$
    <asp:ListView runat="server" ID="providersList" ViewStateMode="Disabled">
        <ItemTemplate>
            <button type="submit" name="provider" value="<%# HttpUtility.HtmlAttributeEncode(Item(Of ProviderDetails)().ProviderName) %>"
                title="Log in using your <%# HttpUtility.HtmlAttributeEncode(Item(Of ProviderDetails)().ProviderDisplayName) %> account.">
                <%# HttpUtility.HtmlEncode(Item(Of ProviderDetails)().ProviderDisplayName) %>
            </button>
        </ItemTemplate>
    $endif$
        <EmptyDataTemplate>
            <div class="message-info">
                <p>There are no external authentication services configured. See <a href="http://go.microsoft.com/fwlink/?LinkId=252803">this article</a> for details on setting up this ASP.NET application to support logging in via external services.</p>
            </div>
        </EmptyDataTemplate>
    </asp:ListView>
</fieldset>