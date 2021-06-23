﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<ICollection<$safeprojectname$.Models.ExternalLogin>>" %>

<% if (Model.Count > 0) { %>
    <h3>Registered external logins</h3>
    <table>
        <tbody>
        <% foreach ($safeprojectname$.Models.ExternalLogin externalLogin in Model) { %>
            <tr>
                <td><%: externalLogin.ProviderDisplayName %></td>
                <td>
                    <% if (ViewBag.ShowRemoveButton) {
                        using (Html.BeginForm("Disassociate", "Account")) { %>
                            <%: Html.AntiForgeryToken() %>
                            <div>
                                <%: Html.Hidden("provider", externalLogin.Provider) %>
                                <%: Html.Hidden("providerUserId", externalLogin.ProviderUserId) %>
                                <input type="submit" value="Remove" title="Remove this <%: externalLogin.ProviderDisplayName %> credential from your account" />
                            </div>
                        <% }
                    } else { %>
                        &nbsp;
                    <% } %>
                </td>
            </tr>
        <% } %>
        </tbody>
    </table>
<% } %>
