// Per un'introduzione al modello di contratto selezione, vedere la seguente documentazione:
// http://go.microsoft.com/fwlink/?LinkId=232514
$wizardcomment$
(function () {
    "use strict";

    var app = WinJS.Application;
    var pickerUI;
    var sched = WinJS.Utilities.Scheduler;
    var ui = WinJS.UI;

    function fileRemovedFromPickerUI(args) {
        // TODO: rispondere a un elemento che viene deselezionato nell'interfaccia utente selezione.
    }

    function getPickerDataSource() {
        if (window.Data) {
            return Data.items.dataSource;
        } else {
            return new WinJS.Binding.List().dataSource;
        }
    }

    function initializeLayout(listView) {
        /// <param name="listView" type="ui.ListView" />

        if (document.documentElement.offsetWidth < 500) {
            listView.layout = new ui.ListLayout();
        } else {
            listView.layout = new ui.GridLayout();
        }
    }

    function updatePickerUI(args) {
        // TODO: rispondere a un elemento che viene selezionato o deselezionato nella pagina.
    }

    app.onactivated = function activated(args) {
        if (args.detail.kind === Windows.ApplicationModel.Activation.ActivationKind.fileOpenPicker) {
            pickerUI = args.detail.fileOpenPickerUI;
            pickerUI.onfileremoved = fileRemovedFromPickerUI;

            // Ottimizzare il carico dell'applicazione e, con la schermata iniziale visualizzata, eseguire il lavoro pianificato in alta priorità.
            ui.disableAnimations();
            var p = ui.processAll().then(function () {
                return sched.requestDrain(sched.Priority.aboveNormal + 1);
            }).then(function () {
                ui.enableAnimations();
                var mainSection = document.querySelector(".$safeitemname$");
                return ui.Animation.enterPage(mainSection);
            }).then(function () {
                var listView = document.querySelector(".pickerlist").winControl;
                listView.itemDataSource = getPickerDataSource();
                listView.itemTemplate = document.querySelector(".itemtemplate");
                listView.onselectionchanged = updatePickerUI;
                initializeLayout(listView);
                window.addEventListener("resize", function resized(args) {
                    initializeLayout(listView);
                });
                listView.element.focus();
            });
            args.setPromise(p);
        }
    };

    app.start();
})();