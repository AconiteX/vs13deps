﻿@If Request.IsAuthenticated
    @<text>
        <ul class="nav navbar-nav navbar-right">
            <li class="navbar-text">
                Hello, @User.Identity.Name!
            </li>
        </ul>
    </text>
End If
