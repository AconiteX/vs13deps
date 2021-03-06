<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>@ViewData("Title") - My ASP.NET MVC Application</title>
    @Styles.Render("~/Content/css")
    @Scripts.Render("~/bundles/modernizr")
</head>
<body>
    <div id="fb-root"></div>
    <script>
        window.fbAsyncInit = function () {
            FB.init({
                appId: '@Microsoft.AspNet.Mvc.Facebook.GlobalFacebookConfiguration.Configuration.AppId', // App ID
                status: true, // check login status
                cookie: true, // enable cookies to allow the server to access the session
                xfbml: true  // parse XFBML
            });
          };

        // Load the SDK Asynchronously
        (function (d) {
            var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
            if (d.getElementById(id)) { return; }
            js = d.createElement('script'); js.id = id; js.async = true;
            js.src = "//connect.facebook.net/en_US/all.js";
            ref.parentNode.insertBefore(js, ref);
        }(document));
    </script>
    
    <div id="wrapper">
        <header id="topHeader">
            <h1>Hello</h1>
            <span id="arrow"></span>
            <h2>Modify this template to jump-start your Facebook application using ASP.NET MVC.</h2>
            <p>
                Learn more about <a href="http://go.microsoft.com/fwlink/?LinkId=269921" target="_blank">building Facebook apps using ASP.NET MVC</a>.
            </p>
        </header>
        @RenderBody()
        <footer>
            <p>&copy; @DateTime.Now.Year - My ASP.NET MVC Application</p>
        </footer>
    </div>

    @Scripts.Render("~/bundles/jquery")
    @RenderSection("scripts", required:=False)
</body>
</html>