// Para obtener una introducción a la plantilla Contrato del selector, consulte la siguiente documentación:
// http://go.microsoft.com/fwlink/?LinkId=232514
$wizardcomment$
(function () {
    "use strict";

    var app = WinJS.Application;
    var pickerUI;
    var sched = WinJS.Utilities.Scheduler;
    var ui = WinJS.UI;

    function fileRemovedFromPickerUI(args) {
        // TODO: Responder a la desactivación de un elemento en la IU del selector.
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
        // TODO: Responder a la activación o desactivación de un elemento en la página.
    }

    app.onactivated = function activated(args) {
        if (args.detail.kind === Windows.ApplicationModel.Activation.ActivationKind.fileOpenPicker) {
            pickerUI = args.detail.fileOpenPickerUI;
            pickerUI.onfileremoved = fileRemovedFromPickerUI;

            // Optimizar la carga de la aplicación y, mientras se muestra la pantalla de presentación, ejecutar el trabajo programado con prioridad alta.
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