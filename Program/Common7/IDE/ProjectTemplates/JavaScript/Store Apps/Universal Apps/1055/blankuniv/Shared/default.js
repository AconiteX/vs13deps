// Boş şablona giriş için aşağıdaki belgelere bakın:
// http://go.microsoft.com/fwlink/?LinkID=392286
(function () {
    "use strict";

    var app = WinJS.Application;
    var activation = Windows.ApplicationModel.Activation;

    app.onactivated = function (args) {
        if (args.detail.kind === activation.ActivationKind.launch) {
            if (args.detail.previousExecutionState !== activation.ApplicationExecutionState.terminated) {
                // TODO: Bu uygulama yeni başlatıldı. Başlat
                // uygulamanız burada.
            } else {
                // TODO: Bu uygulama askı durumundan etkinleştirildi.
                // geri yükleme uygulama durumu burada.
            }
            args.setPromise(WinJS.UI.processAll());
        }
    };

    app.oncheckpoint = function (args) {
        // TODO: Bu uygulama askıya alınma hakkında. Herhangi bir durumda kaydet
        // burada askıya alınmalar arasında devam etmesi gerekiyor. Şunu kullanabilirsiniz
        // Otomatik olan WinJS.Application.sessionState nesnesi
        // kaydedildi ve ertelemeler iade edildi. Eğer tamamlaman gerekiyorsa bir
        // uygulamanız ertelenmeden önce asenkron işlemler, çağır
        // args.setPromise().
    };

    app.start();
})();